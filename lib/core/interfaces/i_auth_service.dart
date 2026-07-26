import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class IAuthService {
  User? get currentUser;
  Stream<AuthState> get authStateChanges; // AuthState not User?
  Future<User> signUp(
      {required String name,
      required String email,
      required String password,
      required String businessName});
  Future<User> signIn({required String email, required String password});
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
}
