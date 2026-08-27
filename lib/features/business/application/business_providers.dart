// lib/features/business/application/business_providers.dart

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/repository_providers.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../shared/models/business.dart';
import '../../../core/supabase/supabase_client.dart';

part 'business_providers.g.dart';

// ── userBusinessListProvider ──────────────────────────────────────────────────
// Returns all businesses the logged-in user belongs to
// Used by OnboardingScreen
@riverpod
Future<List<Business>> userBusinessList(UserBusinessListRef ref) async {
  // Watch auth stream — rebuilds when session loads
  ref.watch(supabaseAuthStateProvider);

  final user = supabase.auth.currentUser;
  if (user == null) return [];

  return ref.read(businessRepositoryProvider).getUserBusinesses(user.id);
}

// ── activeBusinessProvider ────────────────────────────────────────────────────
// Fetches the active business for the logged-in user directly from Supabase
// Does NOT depend on activeBusinessIdProvider — avoids circular dependency
@riverpod
Future<Business?> activeBusiness(ActiveBusinessRef ref) async {
  // Watch auth stream — ensures this rebuilds after login
  // Without this the provider runs before the session is ready
  ref.watch(supabaseAuthStateProvider);

  // Read current user from the live session
  final user = supabase.auth.currentUser;

  if (user == null) {
    debugPrint('activeBusinessProvider: no user in session');
    return null;
  }

  debugPrint('activeBusinessProvider: querying for uid=${user.id}');

  try {
    // Step 1: find business_id from business_members
    final memberRow = await supabase
        .from('business_members')
        .select('business_id')
        .eq('uid', user.id)
        .eq('is_active', true)
        .limit(1)
        .maybeSingle();

    debugPrint('activeBusinessProvider memberRow: $memberRow');

    if (memberRow == null) {
      debugPrint('activeBusinessProvider: no membership found for this user');
      return null;
    }

    final bizId = memberRow['business_id'] as String;

    // Step 2: fetch the full business row
    final bizRow = await supabase
        .from('businesses')
        .select()
        .eq('id', bizId)
        .maybeSingle();

    debugPrint('activeBusinessProvider bizRow: $bizRow');

    if (bizRow == null) {
      debugPrint('activeBusinessProvider: business row not found');
      return null;
    }

    final business = Business.fromJson(bizRow);
    debugPrint('activeBusinessProvider: loaded ${business.name}');
    return business;
  } catch (e, st) {
    debugPrint('activeBusinessProvider error: $e');
    debugPrint('$st');
    return null;
  }
}

// ── activeBusinessIdProvider ──────────────────────────────────────────────────
// Derives business ID from activeBusinessProvider
// ONE WAY ONLY: activeBusiness → activeBusinessId (never reverse)
@riverpod
Future<String?> activeBusinessId(ActiveBusinessIdRef ref) async {
  final business = await ref.watch(activeBusinessProvider.future);
  return business?.id;
}

// ── UpdateBusinessNotifier ────────────────────────────────────────────────────
// Saves changes to the business profile
// Called from OnboardingScreen and BusinessSettingsScreen

@riverpod
class UpdateBusinessNotifier extends _$UpdateBusinessNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> update(Business b) async {
    debugPrint('UpdateBusinessNotifier: update() called, id=${b.id}');
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      debugPrint(
          'UpdateBusinessNotifier: calling repository.updateBusiness()...');
      await ref.read(businessRepositoryProvider).updateBusiness(b);
      debugPrint('UpdateBusinessNotifier: repository call completed');
    });

    if (state is AsyncError) {
      debugPrint(
          'UpdateBusinessNotifier: FAILED — ${(state as AsyncError).error}');
    } else {
      debugPrint('UpdateBusinessNotifier: SUCCESS');
    }

    debugPrint('UpdateBusinessNotifier: invalidating activeBusinessProvider');
    ref.invalidate(activeBusinessProvider);
  }
}

// @riverpod
// class UpdateBusinessNotifier extends _$UpdateBusinessNotifier {
//   @override
//   AsyncValue<void> build() => const AsyncValue.data(null);

//   Future<void> update(Business b) async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(
//         () => ref.read(businessRepositoryProvider).updateBusiness(b));
//     // Invalidate activeBusiness so AppShell refreshes the business name
//     ref.invalidate(activeBusinessProvider);
//   }
// }

//Commented on 04.08.2026 replaced the whole code with above code

// // Riverpod providers for business data.
// // Used by OnboardingScreen, AppShell, and any screen that needs
// // the active business details.

// import 'package:flutter/material.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart'; // @riverpod annotation
// import '../../../core/di/repository_providers.dart'; // businessRepositoryProvider
// import '../../../features/auth/application/auth_providers.dart'; // currentSupabaseUserProvider, activeBusinessIdProvider
// import '../../../shared/models/business.dart'; // Business Freezed model
// import '../../../core/supabase/supabase_client.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'business_providers.g.dart'; // generated by build_runner

// // userBusinessListProvider: loads all businesses the logged-in user belongs to
// // Returns List<Business> from business_members join in BusinessRepository
// // Used by OnboardingScreen to get the business created during signup
// @riverpod
// Future<List<Business>> userBusinessList(UserBusinessListRef ref) async {
//   // Watch the Supabase auth user - rebuilds if user changes
//   final user = ref.watch(currentSupabaseUserProvider);
//   // Return empty list if no user logged in (guard against null)
//   if (user == null) {
//     debugPrint('activeBusinessProvider: no auth user');
//     return [];
//   }

//   // getUserBusinesses queries business_members WHERE uid = user.id
//   // try {
//   final memberRow = await supabase
//       .from('business_members')
//       .select('business_id')
//       .eq('uid', user.id)
//       .eq('is_active', true)
//       .limit(1)
//       .maybeSingle();

//   debugPrint('activeBusinessProvider member Row: $memberRow');

//   if (memberRow == null) {
//     debugPrint('activeBusinessProvider: no business_members row');
//     // return null;
//   }
//   final bizId = memberRow?['business_id'] as String;

//   //fetch the full business row
//   final bizRow =
//       await supabase.from('businesses').select().eq('id', bizId).maybeSingle();

//   debugPrint('activeBusinessProvider bizRow:$bizRow');

//   if (bizRow == null) {
//     debugPrint('activeBusinessProvider: business row not found');
//     // return null;
//   }

//   return [Business.fromJson(bizRow!)];
//   // }
//   // catch (e, st) {
//   //   debugPrint('activeBusinessProvider error: $e');
//   //   debugPrint('$st');
//   //   // return null;
//   // }

//   // return ref.read(businessRepositoryProvider).getUserBusinesses(user.id);
// }

// // activeBusinessProvider: streams the currently selected business details
// // Watches activeBusinessIdProvider - rebuilds when Admin switches business
// // Used by AppShell (business name in AppBar) and throughout the app
// @riverpod
// Future<Business?> activeBusiness(ActiveBusinessRef ref) async {
//   // Watch activeBusinessIdProvider - this is the UUID string set after login
//   final id = ref.watch(activeBusinessIdProvider);
//   // Return null if no business selected yet (e.g. before onboarding)
//   if (id == null) return null;
//   // getBusiness fetches one business row by UUID from Supabase
//   return ref.read(businessRepositoryProvider).getBusiness(id as String);
// }

// // UpdateBusinessNotifier: saves changes to the business profile
// // Called from OnboardingScreen and BusinessSettingsScreen
// @riverpod
// class UpdateBusinessNotifier extends _$UpdateBusinessNotifier {
//   // Initial state: idle, no update in progress
//   @override
//   AsyncValue<void> build() => const AsyncValue.data(null);

//   // update: sends the updated Business object to Supabase
//   // Shows AsyncLoading state while saving (disables Save button in UI)
//   Future<void> update(Business b) async {
//     state = const AsyncValue.loading(); // triggers spinner on Save button
//     // AsyncValue.guard catches any Supabase errors and wraps in AsyncError
//     /* In Riverpod 2.x the mounted property exists on ConsumerState (inside Flutter widgets) but not on Ref inside a Notifier class. The pattern changed between Riverpod 1.x and 2.x:
//     // final result = await AsyncValue.guard(
//     //     () => ref.read(businessRepositoryProvider).updateBusiness(b));
//     // // Check mounted before updating state (widget may be disposed)
//     // if (ref.mounted) state = result;
//  In Riverpod 2.x the mounted property exists on ConsumerState (inside Flutter widgets) but not on Ref inside a Notifier class. The pattern changed between Riverpod 1.x and 2.x:*/

//     state = await AsyncValue.guard(
//         () => ref.read(businessRepositoryProvider).updateBusiness(b));
//   }
// }
