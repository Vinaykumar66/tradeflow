import 'package:uuid/uuid.dart';

import '../../../core/constants/table_constants.dart';
import '../../../core/interfaces/i_business_repository.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/business.dart';
import '../../../shared/models/business_member.dart';
import '../../admin/data/permission_repository.dart';

class BusinessRepository implements IBusinessRepository {
  @override
  Future<Business> createBusiness(
      {required String ownerUid,
      required String ownerName,
      required String ownerEmail,
      required String businessName,
      String? city,
      String? phone,
      String? state,
      String? pin,
      String? gstin}) async {
    final user = supabase.auth.currentUser;
    final _uuid = const Uuid();
    final bizId = _uuid.v4();
    final d = await supabase
        .from(SupabaseTables.businesses)
        .insert({
          'id': bizId,
          'owner_uid': user!.id,
          'name': businessName,
          // 'owner_uid': ownerUid,
          'email': ownerEmail,
          'phone': phone,
          'city': city,
          'state': state,
          'pincode': pin,
          'gstin': gstin
        })
        .select()
        .single();
    final b = BusinessX.fromMap(d);
    try {
      await supabase.from('business_members').insert({
        'uid': user.id,
        'business_id': bizId,
        'role_value': 'owner',
        'is_active': true,
        'name': '${user.userMetadata?['name'] ?? ''}',
        'email': user.email,
      });
    } catch (e) {
      try {
        await supabase.from('businesses').delete().eq('id', bizId);
      } catch (_) {}
      rethrow;
    }
    return b;
  }

  @override
  Future<Business?> getBusiness(String id) async {
    final d = await supabase
        .from(SupabaseTables.businesses)
        .select()
        .eq('id', id)
        .maybeSingle();
    return d == null ? null : BusinessX.fromMap(d);
  }

  @override
  Future<void> updateBusiness(Business b) async {
    await supabase
        .from(SupabaseTables.businesses)
        .update(b.toUpdateMap())
        .eq('id', b.id);
  }

  @override
  Future<List<Business>> getUserBusinesses(String uid) async {
    final d = await supabase
        .from(SupabaseTables.businessMembers)
        .select('business_id, businesses(*)')
        .eq('uid', uid)
        .eq('is_active', true);
    return d
        .map((r) => BusinessX.fromMap(r['businesses'] as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<BusinessMember?> getMember(String businessId, String uid) async {
    final d = await supabase
        .from(SupabaseTables.businessMembers)
        .select()
        .eq('business_id', businessId)
        .eq('uid', uid)
        .maybeSingle();
    return d == null ? null : BusinessMemberX.fromMap(d);
  }

  @override
  Future<List<BusinessMember>> getMembers(String businessId) async {
    final d = await supabase
        .from(SupabaseTables.businessMembers)
        .select()
        .eq('business_id', businessId);
    return d.map((r) => BusinessMemberX.fromMap(r)).toList();
  }

  @override
  Future<void> addMember(BusinessMember m) async {
    await supabase.from(SupabaseTables.businessMembers).insert(m.toInsertMap());
  }

  @override
  Future<void> updateMemberRole(
      {required String businessId,
      required String uid,
      required String newRole}) async {
    await supabase
        .from(SupabaseTables.businessMembers)
        .update({'role_value': newRole})
        .eq('business_id', businessId)
        .eq('uid', uid);
  }
}


/* placed in create business after await supabase.from('businesses').insert({'id': bizId, 'owner_uid': user.id
await supabase.from(SupabaseTables.businessMembers).insert({
      'uid': ownerUid,
      'business_id': b.id,
      'name': ownerName,
      'email': ownerEmail,
      'role_value': 'owner'
    });

    // Seed default permissions for all 3 roles
    await PermissionRepository().seedDefaultPermissions(b.id);
    */