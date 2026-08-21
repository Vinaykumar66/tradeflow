import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/permission_keys.dart';
import '../../../core/di/repository_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../shared/models/customer.dart';
import '../../../shared/widgets/field_guard.dart';
import '../../business/application/business_providers.dart'
    show activeBusinessProvider;
import '../application/customer_providers.dart';
import '../../../core/config/country_tax_config.dart';

class AddEditCustomerScreen extends ConsumerStatefulWidget {
  final Customer? customer;
  const AddEditCustomerScreen({super.key, required this.customer});
  @override
  ConsumerState<AddEditCustomerScreen> createState() =>
      _AddEditCustomerScreenState();
}

class _AddEditCustomerScreenState extends ConsumerState<AddEditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _creditCtrl = TextEditingController(text: '0.00');
  int _paymentTerms = 0;
  bool get _isEditing => widget.customer != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) _prefill(widget.customer!);
  }

  void _prefill(Customer c) {
    _nameCtrl.text = c.name;
    _phoneCtrl.text = c.phone ?? '';
    _emailCtrl.text = c.email ?? '';
    _addressCtrl.text = c.address ?? '';
    _cityCtrl.text = c.city ?? '';
    _stateCtrl.text = c.state ?? '';
    _gstinCtrl.text = c.gstin ?? '';
    _creditCtrl.text = (c.creditLimit / 100).toStringAsFixed(2);
    _paymentTerms = c.paymentTerms;
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtrl,
      _phoneCtrl,
      _emailCtrl,
      _addressCtrl,
      _cityCtrl,
      _stateCtrl,
      _gstinCtrl,
      _creditCtrl
    ]) c.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final bizId = ref.read(activeBusinessIdProvider) ?? '';
    final credit = ((double.tryParse(_creditCtrl.text) ?? 0) * 100).toInt();
    final customer = Customer(
      id: _isEditing ? widget.customer!.id : '',
      businessId: bizId,
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
      email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      address:
          _addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim(),
      city: _cityCtrl.text.trim().isEmpty ? null : _cityCtrl.text.trim(),
      state: _stateCtrl.text.trim().isEmpty ? null : _stateCtrl.text.trim(),
      gstin: _gstinCtrl.text.trim().isEmpty
          ? null
          : _gstinCtrl.text.trim().toUpperCase(),
      creditLimit: credit,
      paymentTerms: _paymentTerms,
      createdAt: widget.customer?.createdAt ?? DateTime.now(),
    );
    await ref.read(saveCustomerNotifierProvider.notifier).save(customer);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final sym = '₹';
    final isSaving = ref.watch(saveCustomerNotifierProvider) is AsyncLoading;
    final biz = ref.watch(activeBusinessProvider).asData?.value;
    final taxConfig = CountryTaxRegistry.forCountry(biz?.countryCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Customer' : 'Add Customer'),
        actions: [
          TextButton(
            onPressed: isSaving ? null : _onSubmit,
            child: isSaving
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Text('SAVE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          //Basic details
          Text(
            'Customer Details',
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: 12),
          _f(_nameCtrl, 'Customer Name *',
              validator: (v) => v!.trim().isEmpty ? 'Name required' : null),
          _f(_phoneCtrl, 'Phone Number', type: TextInputType.phone),
          _f(_emailCtrl, 'Email Address', type: TextInputType.emailAddress),
          const SizedBox(height: 20),

          //Address
          Text('Address (optional)', style: AppTextStyles.h3),
          const SizedBox(height: 12),
          _f(_addressCtrl, 'Street / Building'),
          Row(children: [
            Expanded(child: _f(_cityCtrl, 'City')),
            const SizedBox(width: 12),
            Expanded(child: _f(_stateCtrl, 'State')),
            const SizedBox(height: 20),
          ]),
          // Business details
          Text('Business Details (optional)', style: AppTextStyles.h3),
          const SizedBox(height: 12),
          // GSTIN validator
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextFormField(
              controller: _gstinCtrl,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                  labelText: '${taxConfig.taxIdLabel} (optional)',
                  hintText: taxConfig.taxIdHint),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;

                // India keeps the exact 15-character GSTIN.
                // Every other country accepts any non-empty value unless a
                // validator is explicitly configured for it in country_tax_config.dart.
//commenting this to generalize tax ID across Geo
                // if (v.trim().length != 15)
                //   return 'GSTIN must be exactly 15 characters';
                // if (!RegExp(
                //         r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
                //     .hasMatch(v.trim())) return 'Invalid GSTIN format';
//commenting this to generalize tax ID across Geo
                final validator = taxConfig.taxIdValidator;
                if (validator != null && !validator.hasMatch(v.trim())) {
                  return 'Invalid ${taxConfig.taxIdLabel} format';
                }

                return null;
              },
            ),
          ),
          const SizedBox(height: 20),

          // Credit terms
          Text('Credit Terms', style: AppTextStyles.h3),
          const SizedBox(height: 12),

          // Credit limit - FieldGuard hides from Salesperson
          FieldGuard(
            fieldKey: AppFieldKeys.customerCreditLimit,
            child: GestureDetector(
              onTap: () async {
                // AUDIT: log when credit limit is accessed
                final user = ref.read(currentAppUserProvider).asData?.value;
                final biz = ref.read(activeBusinessIdProvider) ?? '';
                if (user != null && widget.customer != null) {
                  await ref.read(auditServiceProvider).logSensitiveView(
                        userId: user.id,
                        userName: user.name,
                        businessId: biz,
                        tableName: 'customers',
                        recordId: widget.customer!.id,
                        fieldName: AppFieldKeys.customerCreditLimit,
                      );
                }
              },
              child: _f(_creditCtrl,
                  'Credit Limit ($sym)', // sym from activeBusinessProvider
                  type: TextInputType.number),
            ),
            readOnlyChild: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                    title: const Text('Credit Limit'),
                    trailing: Text(
                        '$sym ${_creditCtrl.text}', // sym from activeBusinessProvider
                        style: const TextStyle(color: Colors.grey)))),
          ),

          // Payment terms
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: DropdownButtonFormField<int>(
              value: _paymentTerms,
              decoration: const InputDecoration(labelText: 'Payment Terms'),
              items: const [
                DropdownMenuItem(value: 0, child: Text('Cash on Delivery')),
                DropdownMenuItem(value: 7, child: Text('Net 7 days')),
                DropdownMenuItem(value: 15, child: Text('Net 15 days')),
                DropdownMenuItem(value: 30, child: Text('Net 30 days')),
                DropdownMenuItem(value: 60, child: Text('Net 60 days')),
              ],
              onChanged: (v) => setState(() => _paymentTerms = v ?? 0),
            ),
          ),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }

  Widget _f(TextEditingController ctrl, String label,
          {TextInputType type = TextInputType.text,
          String? Function(String?)? validator}) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
              controller: ctrl,
              keyboardType: type,
              validator: validator,
              decoration: InputDecoration(labelText: label)));
}
