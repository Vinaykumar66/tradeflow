// lib/features/business/presentation/onboarding_screen.dart
//
// Post sign-up screen that completes the business profile.
// Shown once after a new user creates their account.
// Fields: Country picker → auto-fills currency/tax, GSTIN/Tax ID, Phone, Address.
// Has a Skip button in the AppBar top-right.
// On Save: updates Supabase businesses row with all i18n fields + sets activeBusinessId.
// On Skip: sets activeBusinessId only and goes to /dashboard.
//
// DEPENDS ON:
//   lib/core/utils/country_data.dart           CountryData, kSupportedCountries
//   lib/shared/models/business.dart            Business Freezed model + BusinessX
//   lib/features/business/application/
//     business_providers.dart                  userBusinessListProvider, updateBusinessNotifierProvider
//   lib/features/auth/application/
//     auth_providers.dart                      activeBusinessIdProvider

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // ConsumerStatefulWidget, WidgetRef
import 'package:go_router/go_router.dart'; // context.go() for navigation

import '../../../core/router/app_router.dart'; // AppRoutes.dashboard constant
import '../../../core/theme/app_colors.dart'; // AppColors constants
import '../../../core/theme/app_text_styles.dart'; // AppTextStyles constants
import '../../../core/utils/country_data.dart'; // CountryData, kSupportedCountries
import '../../auth/application/auth_providers.dart'; // activeBusinessIdProvider
import '../application/business_providers.dart'; // userBusinessListProvider, updateBusinessNotifierProvider

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  // Form key used by Form widget to validate all fields at once
  final _formKey = GlobalKey<FormState>();

  // ── TEXT CONTROLLERS ───────────────────────────────────────────────────────
  // Each controller manages one text input field
  // Must be disposed in dispose() to prevent memory leaks

  // Tax ID field: GSTIN for India, TRN for UAE, VAT Reg No for others (optional)
  final _taxIdCtrl = TextEditingController();

  // Business phone number (optional)
  final _phoneCtrl = TextEditingController();

  // Street address line (optional, maxLines 3)
  final _addressCtrl = TextEditingController();

  // City name (optional)
  final _cityCtrl = TextEditingController();

  // State/Province/Emirate (optional)
  final _stateCtrl = TextEditingController();

  // PIN code / ZIP code / Postal code (optional)
  final _pincodeCtrl = TextEditingController();

  // ── STATE ──────────────────────────────────────────────────────────────────

  // _selectedCountry: the CountryData object the user picked from the dropdown
  // Starts as India (first in kSupportedCountries) so fields pre-populate
  CountryData _selectedCountry = kSupportedCountries.first;

  @override
  void dispose() {
    // Dispose all controllers to release memory when screen is removed
    _taxIdCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _pincodeCtrl.dispose();
    super.dispose();
  }

  // ── TAX ID FIELD HELPERS ───────────────────────────────────────────────────

  // _taxIdLabel returns the correct label for the tax registration number field
  // depending on which country was selected
  String get _taxIdLabel => switch (_selectedCountry.countryCode) {
        'IN' => 'GSTIN (optional)', // India: GST Identification Number
        'AE' => 'TRN - Tax Registration Number (optional)', // UAE
        'SA' => 'VAT Registration Number (optional)', // Saudi Arabia
        _ => 'Tax ID / VAT Number (optional)', // all other countries
      };

  // _taxIdHint returns an example value for the tax ID placeholder text
  String get _taxIdHint => switch (_selectedCountry.countryCode) {
        'IN' =>
          '22AAAAA0000A1Z5', // India GSTIN example: state code + PAN + entity
        'AE' => '100123456700003', // UAE TRN example
        'SA' => '300123456700003', // Saudi VAT number example
        _ => 'Enter your tax registration number',
      };

  // _validateTaxId validates the tax ID format per country
  // Returns null if valid (or empty since it is optional)
  // Returns an error string if the format is wrong
  String? _validateTaxId(String? v) {
    // Empty is always allowed - tax ID is optional
    if (v == null || v.trim().isEmpty) return null;

    if (_selectedCountry.countryCode == 'IN') {
      // India GSTIN: exactly 15 chars in specific format
      // Format: 2 digits (state) + 5 uppercase letters + 4 digits + 1 letter + 1 alphanumeric + Z + 1 alphanumeric
      if (v.trim().length != 15) {
        return 'GSTIN must be exactly 15 characters';
      }
      // Regex validates the exact GSTIN format
      if (!RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
          .hasMatch(v.trim())) {
        return 'Invalid GSTIN format. Example: 22AAAAA0000A1Z5';
      }
    }
    // Other countries: no strict format validation, any text is accepted
    return null;
  }

  // ── SAVE HANDLER ──────────────────────────────────────────────────────────

  Future<void> _onSave() async {
    // Validate all form fields before saving
    // _formKey.currentState!.validate() triggers all validator functions
    if (!_formKey.currentState!.validate()) return;

    // Load the list of businesses this user owns
    // userBusinessListProvider is a FutureProvider from business_providers.dart
    final list = await ref.read(userBusinessListProvider.future);

    // Guard: if somehow no business exists, just navigate to dashboard
    if (list.isEmpty) {
      _navigateToDashboard(null);
      return;
    }

    // Get the first (and usually only) business this user owns
    // This is the business created automatically during sign-up in SignUpNotifier
    final business = list.first;

    // Build the tax ID value - convert to uppercase for India GSTIN
    final taxId = _taxIdCtrl.text.trim().isEmpty
        ? null // null if empty
        : _selectedCountry.countryCode == 'IN'
            ? _taxIdCtrl.text.trim().toUpperCase() // GSTIN must be uppercase
            : _taxIdCtrl.text.trim(); // other countries: as-is

    // Update the business with all fields using Freezed copyWith
    // copyWith creates a new Business object with the specified fields changed
    await ref.read(updateBusinessNotifierProvider.notifier).update(
          business.copyWith(
            // ── TAX ID (country-specific) ────────────────────────────────────
            // Store in gstin column for India, or a general tax_id column for others
            // For India: this is the GSTIN field
            // For other countries: this is stored in a general tax ID field
            gstin: _selectedCountry.countryCode == 'IN' ? taxId : null,

            // ── CONTACT ─────────────────────────────────────────────────────
            // phone from _phoneCtrl, null if empty
            phone:
                _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),

            // ── ADDRESS ─────────────────────────────────────────────────────
            address: _addressCtrl.text.trim().isEmpty
                ? null
                : _addressCtrl.text.trim(),

            city: _cityCtrl.text.trim().isEmpty ? null : _cityCtrl.text.trim(),

            // state is the state/province/emirate field
            state:
                _stateCtrl.text.trim().isEmpty ? null : _stateCtrl.text.trim(),

            // country stored as full name e.g. 'India', 'UAE'
            country: _selectedCountry.countryName,

            pincode: _pincodeCtrl.text.trim().isEmpty
                ? null
                : _pincodeCtrl.text.trim(),

            // ── INTERNATIONALISATION FIELDS ──────────────────────────────────
            // These come from the CountryData object the user selected
            // They drive CurrencyFormatter and invoice PDF generation throughout the app

            // currencyCode: ISO 4217 e.g. 'INR', 'AED', 'NGN', 'BDT', 'LKR'
            currencyCode: _selectedCountry.currencyCode,

            // currencySymbol: display symbol e.g. 'Rs.', 'AED', '₦', '৳'
            currencySymbol: _selectedCountry.currencySymbol,

            // countryCode: ISO 3166-1 alpha-2 e.g. 'IN', 'AE', 'NG'
            countryCode: _selectedCountry.countryCode,

            // taxLabel: shown on invoices and reports e.g. 'GST', 'VAT', 'Tax'
            taxLabel: _selectedCountry.taxLabel,

            // defaultTaxRate: percentage applied to new products by default
            // e.g. 18.0 for India, 5.0 for UAE, 7.5 for Nigeria
            defaultTaxRate: _selectedCountry.defaultTaxRate,

            // useLakhFormat: true = 1,00,000 style (India/Bangladesh)
            //               false = 100,000 style (UAE, Nigeria etc.)
            useLakhFormat: _selectedCountry.useLakhFormat,
          ),
        );

    // Check mounted before any context operations (widget may have been disposed)
    if (mounted) {
      // Navigate to dashboard and set activeBusinessId
      _navigateToDashboard(business.id);
    }
  }

  // ── SKIP HANDLER ──────────────────────────────────────────────────────────

  Future<void> _onSkip() async {
    // Load business list even on skip so we can set activeBusinessId
    final list = await ref.read(userBusinessListProvider.future);
    // Navigate with business id if available, null if no business found
    _navigateToDashboard(list.isEmpty ? null : list.first.id);
  }

  // ── NAVIGATION HELPER ─────────────────────────────────────────────────────

  void _navigateToDashboard(String? businessId) {
    // Set the active business ID in Riverpod state
    // activeBusinessIdProvider is a StateNotifier from auth_providers.dart
    if (businessId != null) {
      ref.read(activeBusinessIdProvider.notifier).set(businessId);
    }
    // Navigate to dashboard using GoRouter
    // context.go() replaces the current route (cannot go back to onboarding)
    context.go(AppRoutes.dashboard);
  }

  // ── BUILD ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // Watch the update notifier to know when a save is in progress
    // AsyncLoading state = save is running (show spinner on button)
    final isSaving = ref.watch(updateBusinessNotifierProvider) is AsyncLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Business Profile'),
        // automaticallyImplyLeading: false removes the back arrow
        // User must use Save or Skip - cannot go back to signup
        automaticallyImplyLeading: false,
        actions: [
          // Skip button in AppBar top-right
          TextButton(
            onPressed:
                _onSkip, // _onSkip sets activeBusinessId and goes to dashboard
            child: const Text(
              'Skip',
              style: TextStyle(
                  color: Colors.white), // white text on primary AppBar
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Padding 24px all sides for comfortable reading
        padding: const EdgeInsets.all(24),
        child: Form(
          key:
              _formKey, // GlobalKey used by Form to validate all fields at once
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── HEADER ────────────────────────────────────────────────────
              Text(
                'Tell us about your business',
                style: AppTextStyles.h2, // from app_text_styles.dart
              ),
              const SizedBox(height: 8),
              Text(
                'This helps personalise invoices and reports. '
                'You can update these anytime from Settings.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 32),

              // ── COUNTRY PICKER ────────────────────────────────────────────
              // This is the most important field - drives all i18n settings
              Text('Country & Currency', style: AppTextStyles.labelMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<CountryData>(
                // Current selected country from _selectedCountry state
                value: _selectedCountry,
                decoration: InputDecoration(
                  // Border and fill from app theme
                  prefixIcon: const Icon(Icons.public_outlined),
                  helperText:
                      'Sets currency: ${_selectedCountry.currencySymbol}  '
                      '|  Tax: ${_selectedCountry.taxLabel} ${_selectedCountry.defaultTaxRate}%',
                  helperMaxLines: 2,
                ),
                // Build one item per supported country from kSupportedCountries list
                items: kSupportedCountries.map((country) {
                  return DropdownMenuItem<CountryData>(
                    value: country, // CountryData object as value
                    child: Row(
                      children: [
                        // Country name
                        Text(country.countryName),
                        const SizedBox(width: 8),
                        // Currency symbol in grey so user knows what they are picking
                        Text(
                          '(${country.currencySymbol})',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (CountryData? selected) {
                  // When user picks a country, update _selectedCountry
                  // setState triggers rebuild which updates:
                  //   - _taxIdLabel and _taxIdHint for the tax field below
                  //   - helperText showing the currency and tax rate
                  if (selected != null) {
                    setState(() => _selectedCountry = selected);
                  }
                },
              ),
              const SizedBox(height: 20),

              // ── TAX ID FIELD ──────────────────────────────────────────────
              // Label and hint change based on selected country (see _taxIdLabel getter)
              // India shows GSTIN with strict regex validation
              // UAE shows TRN, others show generic Tax ID
              TextFormField(
                controller: _taxIdCtrl,
                // Force uppercase for GSTIN (India) since it must be uppercase
                textCapitalization: _selectedCountry.countryCode == 'IN'
                    ? TextCapitalization.characters // GSTIN: all caps
                    : TextCapitalization.none,
                textInputAction: TextInputAction.next, // next field on keyboard
                // validator runs when Form.validate() is called
                validator: _validateTaxId,
                decoration: InputDecoration(
                  labelText: _taxIdLabel, // GSTIN / TRN / VAT Reg No
                  hintText: _taxIdHint, // example value
                  prefixIcon: const Icon(Icons.receipt_long_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // ── PHONE ─────────────────────────────────────────────────────
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone, // shows phone keyboard
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Phone Number (optional)',
                  hintText: '+91 98765 43210',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                // No validator - phone is optional, any format accepted
              ),
              const SizedBox(height: 16),

              // ── ADDRESS ───────────────────────────────────────────────────
              TextFormField(
                controller: _addressCtrl,
                maxLines: 3, // multi-line address box
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Street Address (optional)',
                  hintText: 'Building / Street / Area',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  alignLabelWithHint: true, // label aligns to top of multi-line
                ),
              ),
              const SizedBox(height: 16),

              // ── CITY + STATE ROW ──────────────────────────────────────────
              // Two fields side by side using Row + Expanded
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // City field - takes half the row
                  Expanded(
                    child: TextFormField(
                      controller: _cityCtrl,
                      textCapitalization:
                          TextCapitalization.words, // Title Case
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'City',
                        hintText: 'Mumbai',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12), // gap between the two fields
                  // State/Province field - takes other half
                  Expanded(
                    child: TextFormField(
                      controller: _stateCtrl,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        // Label adapts to country: 'State' for India, 'Province' etc.
                        labelText: _selectedCountry.countryCode == 'AE' ||
                                _selectedCountry.countryCode == 'SA'
                            ? 'Emirate / Region' // UAE and Saudi use Emirate
                            : 'State / Province', // everyone else
                        hintText: _selectedCountry.countryCode == 'IN'
                            ? 'Maharashtra' // India hint
                            : _selectedCountry.countryCode == 'AE'
                                ? 'Dubai' // UAE hint
                                : 'State', // fallback hint
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ── PINCODE ROW ───────────────────────────────────────────────
              // Full width for pincode (simpler layout on smaller screens)
              TextFormField(
                controller: _pincodeCtrl,
                keyboardType: TextInputType.number, // numeric keyboard
                textInputAction:
                    TextInputAction.done, // 'Done' button on keyboard
                decoration: InputDecoration(
                  // Label adapts to country
                  labelText: switch (_selectedCountry.countryCode) {
                    'IN' => 'PIN Code (optional)', // India uses PIN code
                    'AE' => 'P.O. Box (optional)', // UAE uses P.O. Box
                    'NG' => 'Postal Code (optional)',
                    _ => 'ZIP / Postal Code (optional)',
                  },
                  hintText: _selectedCountry.countryCode == 'IN'
                      ? '400001' // India: 6-digit PIN
                      : '00000', // generic hint
                  prefixIcon: const Icon(Icons.markunread_mailbox_outlined),
                ),
              ),
              const SizedBox(height: 32),

              // ── CURRENCY SUMMARY CARD ─────────────────────────────────────
              // Shows the user what they are committing to before saving
              // Helps them confirm the country selection is correct
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // Light primary tint background
                  color: AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Invoice Settings',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Show each i18n setting derived from selected country
                    _SettingRow(
                      label: 'Currency',
                      // Shows both symbol and ISO code e.g. 'Rs. (INR)'
                      value: '${_selectedCountry.currencySymbol}'
                          ' (${_selectedCountry.currencyCode})',
                    ),
                    _SettingRow(
                      label: 'Tax Label',
                      value: _selectedCountry.taxLabel, // GST / VAT / Tax
                    ),
                    _SettingRow(
                      label: 'Default Tax Rate',
                      // toStringAsFixed(1) shows one decimal e.g. '18.0%'
                      value:
                          '${_selectedCountry.defaultTaxRate.toStringAsFixed(1)}%',
                    ),
                    _SettingRow(
                      label: 'Number Format',
                      // Show example of how large numbers will be formatted
                      value: _selectedCountry.useLakhFormat
                          ? '1,00,000 (Lakh)' // India/Bangladesh
                          : '100,000 (Standard)', // all others
                    ),
                    const SizedBox(height: 4),
                    // Reassurance text that settings can be changed later
                    Text(
                      'These can be changed in Settings > Business Profile anytime.',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── SAVE BUTTON ───────────────────────────────────────────────
              SizedBox(
                width: double.infinity, // full-width button
                child: ElevatedButton(
                  // Disable button while save is in progress
                  onPressed: isSaving ? null : _onSave,
                  child: isSaving
                      // Show spinner while Supabase update is in progress
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      // Normal button label
                      : const Text('Save and Continue'),
                ),
              ),
              const SizedBox(height: 12),

              // ── SKIP LINK (duplicate at bottom for visibility) ─────────────
              Center(
                child: TextButton(
                  onPressed: _onSkip,
                  child: Text(
                    'Skip for now',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
              const SizedBox(height: 32), // bottom padding for scroll
            ],
          ),
        ),
      ),
    );
  }
}

// ── HELPER WIDGET ──────────────────────────────────────────────────────────────

// _SettingRow displays one label + value pair in the currency summary card
// Used to show currency, tax label, tax rate, number format
class _SettingRow extends StatelessWidget {
  final String label; // left side: e.g. 'Currency'
  final String value; // right side: e.g. 'Rs. (INR)'

  const _SettingRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          // Label in grey - min width so values line up
          SizedBox(
            width: 130,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          // Value in dark text - bold for prominence
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Business Setup'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () => context.go('/dashboard'),
//             child: const Text('Continue')),
//       ),
//     );
//   }
// }
