import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tradeflow/features/auth/data/supabase_auth_service.dart';
import 'package:riverpod/riverpod.dart';
import '../../../core/di/repository_providers.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/app_user.dart';
import '../../../shared/models/business_member.dart';

part 'auth_providers.g.dart';

@riverpod
Stream<AuthState> supabaseAuthState(SupabaseAuthStateRef ref) =>
    supabase.auth.onAuthStateChange;

@riverpod
User? currentSupabaseUser(CurrentSupabaseUserRef ref) {
  ref.watch(supabaseAuthStateProvider);
  return supabase.auth.currentUser;
}

@riverpod
Future<AppUser?> currentAppUser(CurrentAppUserRef ref) async {
  final u = ref.watch(currentSupabaseUserProvider);
  if (u == null) return null;
  return ref.read(userRepositoryProvider).getUser(u.id);
}

@riverpod
class ActiveBusinessId extends _$ActiveBusinessId {
  @override
  String? build() => null;
  void set(String id) => state = id;
  void clear() => state = null;
}

@riverpod
Future<BusinessMember?> currentMember(CurrentMemberRef ref) async {
  final u = ref.watch(currentSupabaseUserProvider);
  final biz = ref.watch(activeBusinessIdProvider);
  if (u == null || biz == null) return null;
  return ref.read(businessRepositoryProvider).getMember(biz, u.id);
}

@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  @override
  AsyncValue<AppUser?> build() => const AsyncValue.data(null);
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String businessName,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard<AppUser?>(() async {
      await ref.read(authServiceProvider).signUp(
            name: name,
            email: email,
            password: password,
            businessName: businessName,
          );
      return null;
    });
  }
}

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  AsyncValue<AppUser?> build() => const AsyncValue.data(null);
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard<AppUser?>(() async {
      await ref
          .read(authServiceProvider)
          .signIn(email: email, password: password);
      return null;
    });
  }

  Future<void> signOut() async {
    await ref.read(authServiceProvider).signOut();
    ref.read(activeBusinessIdProvider.notifier).clear();
  }
}
