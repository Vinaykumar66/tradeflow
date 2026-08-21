import 'package:uuid/uuid.dart';
import '../../../core/interfaces/i_tax_code_repository.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/tax_code.dart';

class TaxCodeRepository implements ITaxCodeRepository {
  final _uuid = const Uuid();
  @override
  Stream<List<TaxCode>> streamTaxCodes(String businessId) {
    return supabase
        .from('tax_codes')
        .stream(primaryKey: ['id'])
        .eq('business_id', businessId)
        .order('name')
        .map((rows) => rows
            .where((r) => r['is_active'] == true)
            .map((r) => TaxCode.fromJson(r))
            .toList());
  }

  @override
  Future<TaxCode> createTaxCode(TaxCode code) async {
    final id = _uuid.v4();
    final map = {...code.toInsertMap(), 'id': id};
    await supabase.from('tax_codes').insert(map);
    return code.copyWith(id: id);
  }

  @override
  Future<void> updateTaxCode(TaxCode code) async {
    await supabase
        .from('tax_codes')
        .update(code.toInsertMap())
        .eq('id', code.id);
  }

  @override
  Future<void> archiveTaxCode(String id) async {
    await supabase.from('tax_codes').update({'is_active': false}).eq('id', id);
  }

  @override
  Future<void> setDefault(String businessId, String id) async {
    await supabase
        .from('tax_codes')
        .update({'is_default': false}).eq('business_id', businessId);
    await supabase.from('tax_codes').update({'is_default': true}).eq('id', id);
  }
}
