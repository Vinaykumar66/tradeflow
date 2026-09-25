import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/interfaces/i_vendor_repository.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/vendor.dart';

class VendorRepository implements IVendorRepository {
  final _uuid = const Uuid();
  @override
  Stream<List<Vendor>> streamVendors(String businessId) {
    return supabase
        .from('vendors')
        .stream(primaryKey: ['id'])
        .eq('business_id', businessId)
        .order('name')
        .map((rows) => rows
            .where((r) => r['is_active'] == true)
            .map((r) => Vendor.fromJson(r))
            .toList());
  }

  @override
  Future<Vendor> createVendor(Vendor vendor) async {
    final id = _uuid.v4();
    final map = {...vendor.toInsertMap(), 'id': id};
    await supabase.from('vendors').insert(map);
    return vendor.copyWith(id: id);
  }

  @override
  Future<void> updateVendor(Vendor vendor) async {
    await supabase
        .from('vendors')
        .update(vendor.toInsertMap())
        .eq('id', vendor.id);
  }

  @override
  Future<Vendor?> getVendor(String businessId, String vendorId) async {
    final row = await supabase
        .from('vendors')
        .select()
        .eq('business_id', businessId)
        .eq('id', vendorId)
        .maybeSingle();
    return row == null ? null : Vendor.fromJson(row);
  }
}

@riverpod
IVendorRepository vendorRepository(Ref ref) => VendorRepository();
