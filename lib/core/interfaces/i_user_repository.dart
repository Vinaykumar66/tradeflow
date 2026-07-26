import '../../shared/models/app_user.dart';

abstract interface class IUserRepository {
  Future<void> createUser(AppUser user);
  Future<AppUser?> getUser(String user);
  Stream<AppUser?> streamUser(String id);
  Future<void> updateProfile(
      {required String id, String? name, String? photoUrl, String? phone});
}
