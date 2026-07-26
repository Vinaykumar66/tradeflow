// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supabaseAuthStateHash() => r'17ba88ab55a3684451385e7e292f1227b645c5c4';

/// See also [supabaseAuthState].
@ProviderFor(supabaseAuthState)
final supabaseAuthStateProvider = AutoDisposeStreamProvider<AuthState>.internal(
  supabaseAuthState,
  name: r'supabaseAuthStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$supabaseAuthStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SupabaseAuthStateRef = AutoDisposeStreamProviderRef<AuthState>;
String _$currentSupabaseUserHash() =>
    r'43a3077dccdade19bb7e3b901a68d4e53840adc6';

/// See also [currentSupabaseUser].
@ProviderFor(currentSupabaseUser)
final currentSupabaseUserProvider = AutoDisposeProvider<User?>.internal(
  currentSupabaseUser,
  name: r'currentSupabaseUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSupabaseUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentSupabaseUserRef = AutoDisposeProviderRef<User?>;
String _$currentAppUserHash() => r'aa9dcc6aba5d9b9c2ecc198e9d60388d29f003c0';

/// See also [currentAppUser].
@ProviderFor(currentAppUser)
final currentAppUserProvider = AutoDisposeFutureProvider<AppUser?>.internal(
  currentAppUser,
  name: r'currentAppUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentAppUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentAppUserRef = AutoDisposeFutureProviderRef<AppUser?>;
String _$currentMemberHash() => r'55b2ec740d494b99140812cccaf9aa97cb047a63';

/// See also [currentMember].
@ProviderFor(currentMember)
final currentMemberProvider =
    AutoDisposeFutureProvider<BusinessMember?>.internal(
  currentMember,
  name: r'currentMemberProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentMemberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentMemberRef = AutoDisposeFutureProviderRef<BusinessMember?>;
String _$activeBusinessIdHash() => r'25213492ce173e5f3f909e2c065d955107e53942';

/// See also [ActiveBusinessId].
@ProviderFor(ActiveBusinessId)
final activeBusinessIdProvider =
    AutoDisposeNotifierProvider<ActiveBusinessId, String?>.internal(
  ActiveBusinessId.new,
  name: r'activeBusinessIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeBusinessIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActiveBusinessId = AutoDisposeNotifier<String?>;
String _$signUpNotifierHash() => r'5c852f4330ed5b09283f3328829a132860aa38c0';

/// See also [SignUpNotifier].
@ProviderFor(SignUpNotifier)
final signUpNotifierProvider =
    AutoDisposeNotifierProvider<SignUpNotifier, AsyncValue<AppUser?>>.internal(
  SignUpNotifier.new,
  name: r'signUpNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signUpNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignUpNotifier = AutoDisposeNotifier<AsyncValue<AppUser?>>;
String _$loginNotifierHash() => r'758bb9bb76a8f93d9e668f3e3e0f2282226b0563';

/// See also [LoginNotifier].
@ProviderFor(LoginNotifier)
final loginNotifierProvider =
    AutoDisposeNotifierProvider<LoginNotifier, AsyncValue<AppUser?>>.internal(
  LoginNotifier.new,
  name: r'loginNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoginNotifier = AutoDisposeNotifier<AsyncValue<AppUser?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
