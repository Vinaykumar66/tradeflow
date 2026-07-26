class CountryData {
  final String countryCode;
  final String countryName;
  final String currencyCode;
  final String currencySymbol;
  final String taxLabel;
  final double defaultTaxRate;
  final bool useLakhFormat; // true for India and Bangladesh
  const CountryData({
    required this.countryCode,
    required this.countryName,
    required this.currencyCode,
    required this.currencySymbol,
    required this.taxLabel,
    required this.useLakhFormat,
    required this.defaultTaxRate,
  });
}

//Supported countries list for onboarding dropdown

const kSupportedCountries = [
  CountryData(
      countryCode: 'IN',
      countryName: 'India',
      currencyCode: 'INR',
      currencySymbol: '₹',
      taxLabel: 'GST',
      defaultTaxRate: 18.0,
      useLakhFormat: true),
  CountryData(
      countryCode: 'LK',
      countryName: 'Sri Lanka',
      currencyCode: 'LKR',
      currencySymbol: 'LKR',
      taxLabel: 'VAT',
      defaultTaxRate: 18.0,
      useLakhFormat: true),
  CountryData(
      countryCode: 'BD',
      countryName: 'Bangladesh',
      currencyCode: 'BDT',
      currencySymbol: '৳',
      taxLabel: 'VAT',
      defaultTaxRate: 15.0,
      useLakhFormat: true),
  CountryData(
      countryCode: 'AE',
      countryName: 'UAE',
      currencyCode: 'AED',
      currencySymbol: 'AED',
      taxLabel: 'VAT',
      defaultTaxRate: 5.0,
      useLakhFormat: false),
  CountryData(
      countryCode: 'SA',
      countryName: 'Saudi Arabia',
      currencyCode: 'SAR',
      currencySymbol: 'SAR',
      taxLabel: 'VAT',
      defaultTaxRate: 15.0,
      useLakhFormat: false),
  CountryData(
      countryCode: 'NG',
      countryName: 'Nigeria',
      currencyCode: 'NGN',
      currencySymbol: '₦',
      taxLabel: 'VAT',
      defaultTaxRate: 7.5,
      useLakhFormat: false),
  CountryData(
      countryCode: 'KE',
      countryName: 'Kenya',
      currencyCode: 'KES',
      currencySymbol: 'KSh',
      taxLabel: 'VAT',
      defaultTaxRate: 16.0,
      useLakhFormat: false),
];

//helper: look up country by code

CountryData? countryByCode(String code) =>
    kSupportedCountries.where((c) => c.countryCode == code).firstOrNull;
