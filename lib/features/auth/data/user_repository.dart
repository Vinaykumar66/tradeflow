import 'dart:async';

import '../../../core/constants/table_constants.dart';
import '../../../core/interfaces/i_user_repository.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/app_user.dart';

class UserRepository implements IUserRepository {
  @override
  Future<void> createUser(AppUser user) async {
    await supabase.from(SupabaseTables.users).insert(user.toMap());
  }

  @override
  Future<AppUser?> getUser(String id) async {
    final d = await supabase
        .from(SupabaseTables.users)
        .select()
        .eq('id', id)
        .maybeSingle();
    return d == null ? null : AppUserX.fromMap(d);
  }

  @override
  Future<void> updateProfile(
      {required String id,
      String? name,
      String? photoUrl,
      String? phone}) async {
    final u = <String, dynamic>{};
    if (name != null) u['name'] = name;
    if (photoUrl != null) u['photo_url'] = photoUrl;
    if (phone != null) u['phone'] = phone;
    if (u.isEmpty) return;
    await supabase.from(SupabaseTables.users).update(u).eq('id', id);
  }

  @override
  Stream<AppUser?> streamUser(String id) {
    return supabase
        .from(SupabaseTables.users)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((rows) => rows.isEmpty ? null : AppUserX.fromMap(rows.first));
  }
}
