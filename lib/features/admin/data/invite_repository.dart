import 'dart:math';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/business_invite.dart';

class InviteRepository {
  String _generateCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rand = Random.secure();
    return List.generate(8, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  Future<BusinessInvite> createInvite({
    required String businessId,
    required String email,
    required String roleValue,
    required String invitedByUid,
  }) async {
    final code = _generateCode();
    final row = await supabase
        .from('business_invites')
        .insert({
          'business_id': businessId,
          'email': email.trim().toLowerCase(),
          'role_value': roleValue,
          'invite_code': code,
          'invited_by': invitedByUid,
        })
        .select()
        .single();
    return BusinessInvite.fromJson(row);
  }

  Stream<List<BusinessInvite>> streamPendingInvites(String businessId) {
// return supabase
//         .from('business_invites')
//         .stream(primaryKey: ['id'])
//         .eq('business_id', businessId)
//         .eq('status', 'pending')
//         .map((rows) => rows.map(BusinessInvite.fromJson).toList());
    return supabase
        .from('business_invites')
        .select()
        .eq('business_id', businessId)
        .eq('status', 'pending')
        .asStream()
        .map((rows) => rows.map(BusinessInvite.fromJson).toList());
  }

  Future<void> revokeInvite(String id) async {
    await supabase
        .from('business_invites')
        .update({'status': 'revoked'}).eq('id', id);
  }
}
