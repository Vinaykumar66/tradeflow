import '../../shared/models/tax_code.dart';

abstract interface class ITaxCodeRepository {
  Stream<List<TaxCode>> streamTaxCodes(String businessId);
  Future<TaxCode> createTaxCode(TaxCode code);
  Future<void> updateTaxCode(TaxCode code);
  Future<void> archiveTaxCode(String id);
  Future<void> setDefault(String businessId, String id);
}
