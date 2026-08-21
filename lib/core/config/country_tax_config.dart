// Maps a business country_code to the correct tax terminology.
// This is what fixes the Day 23 GSTIN field: GSTIN was hardcoded as
// the label for every country, which is only correct for India.
//
// IMPORTANT: India keeps GSTIN exactly as it is built, including
// the original 15-character regex. Nothing about the Indian flow changes.
// Every other country gets its own sensible label instead of GSTIN.

class CountryTaxConfig {
  final String taxIdLabel;
  final String taxIdHint;
  final RegExp? taxIdValidator;
  final String taxLabel;
  final double defaultRate;

  const CountryTaxConfig({
    required this.taxIdLabel,
    required this.taxIdHint,
    this.taxIdValidator,
    required this.taxLabel,
    required this.defaultRate,
  });
}

class CountryTaxRegistry {
  static final _india = CountryTaxConfig(
    taxIdLabel: 'GSTIN',
    taxIdHint: '29AAAAA0000A1Z5',
    taxLabel: 'GST',
    taxIdValidator:
        RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$'),
    defaultRate: 18.0,
  );
  static const _generic = CountryTaxConfig(
    taxIdLabel: 'Tax ID',
    taxIdHint: 'Business tax registration number',
    taxLabel: 'Tax',
    defaultRate: 0.0,
  );
  static final Map<String, CountryTaxConfig> _configs = {
    'IN': _india,
    'US': const CountryTaxConfig(
        taxIdLabel: 'EIN / Tax ID',
        taxIdHint: '12-3456789',
        taxLabel: 'Sales Tax',
        defaultRate: 0.0),
    'GB': const CountryTaxConfig(
        taxIdLabel: 'VAT Number',
        taxIdHint: 'GB123456789',
        taxLabel: 'VAT',
        defaultRate: 20.0),
    'AE': const CountryTaxConfig(
        taxIdLabel: 'TRN',
        taxIdHint: '100123456700003',
        taxLabel: 'VAT',
        defaultRate: 5.0),
    'AU': const CountryTaxConfig(
        taxIdLabel: 'ABN',
        taxIdHint: '51 824 753 556',
        taxLabel: 'GST',
        defaultRate: 10.0),
    'SG': const CountryTaxConfig(
        taxIdLabel: 'GST Reg. No.',
        taxIdHint: '200312345A',
        taxLabel: 'GST',
        defaultRate: 9.0),
  };
  static CountryTaxConfig forCountry(String? countryCode) =>
      _configs[countryCode] ?? _generic;
}
