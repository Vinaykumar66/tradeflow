import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/interfaces/i_auth_service.dart';
import '../../../core/supabase/supabase_client.dart';

class SupabaseAuthService implements IAuthService {
  @override
  User? get currentUser => supabase.auth.currentUser;
  @override
  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;
  @override
  @override
  Future<User> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    final r = await supabase.auth.signUp(
      email: email.trim(),
      password: password,
      data: {'name': name.trim()},
    );
    if (r.user == null) throw Exception('Sign up failed');
    return r.user!; // hasSession is false until the email is verified
  }
  //replaced this with above code to mitigate the business creation after user signup
  // Future<User> signUp({
  //   required String businessName,
  //   required String email,
  //   required String name,
  //   required String password,
  // }) async {
  //   final r = await supabase.auth.signUp(
  //     email: email.trim(),
  //     password: password,
  //     data: {
  //       'businessName': businessName,
  //       'name': name,
  //     },
  //   );
  //   debugPrint('SIGNUP data=$r');
  //   debugPrint('SIGNUP user=${r.user?.id} hasSession=${r.session != null}');
  //   if (r.user == null) throw Exception('Sign up failed');
  //   return r.user!;
  // }

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


//select pg_get_functiondef('public.handle_new_user()'::regprocedure);

// CREATE OR REPLACE FUNCTION public.handle_new_user()
// RETURNS TRIGGER AS $$
// BEGIN
//   INSERT INTO public.users (id, email, name)
//   VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'name')
//   ON CONFLICT (id) DO NOTHING;
//   RETURN NEW;
// END;
// $$ LANGUAGE plpgsql SECURITY DEFINER;

// DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
// CREATE TRIGGER on_auth_user_created
//   AFTER INSERT ON auth.users
//   FOR EACH ROW
//   EXECUTE FUNCTION public.handle_new_user();