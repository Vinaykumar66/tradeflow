import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/interfaces/i_auth_service.dart';
import '../../../core/supabase/supabase_client.dart';

class SupabaseAuthService implements IAuthService {
  @override
  User? get currentUser => supabase.auth.currentUser;
  @override
  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;
  @override
  Future<User> signUp({
    required String businessName,
    required String email,
    required String name,
    required String password,
  }) async {
    final r = await supabase.auth.signUp(
      email: email.trim(),
      password: password,
      data: {
        'businessName': businessName,
        'name': name,
      },
    );
    if (r.user == null) throw Exception('Sign up failed');
    return r.user!;
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    final r = await supabase.auth
        .signInWithPassword(email: email.trim(), password: password);
    if (r.user == null) throw Exception('Sign in failed');
    return r.user!;
  }

  @override
  Future<void> signOut() => supabase.auth.signOut();
  @override
  Future<void> sendPasswordResetEmail(String email) =>
      supabase.auth.resetPasswordForEmail(email.trim());
}
