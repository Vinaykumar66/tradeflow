// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userBusinessListHash() => r'1b30773b0230552cdaed79004d9a26b953cb6669';

/// See also [userBusinessList].
@ProviderFor(userBusinessList)
final userBusinessListProvider =
    AutoDisposeFutureProvider<List<Business>>.internal(
  userBusinessList,
  name: r'userBusinessListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userBusinessListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserBusinessListRef = AutoDisposeFutureProviderRef<List<Business>>;
String _$activeBusinessHash() => r'38c06cf4c5d3f18f7b5cd83c4393994bc7259949';

/// See also [activeBusiness].
@ProviderFor(activeBusiness)
final activeBusinessProvider = AutoDisposeFutureProvider<Business?>.internal(
  activeBusiness,
  name: r'activeBusinessProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeBusinessHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveBusinessRef = AutoDisposeFutureProviderRef<Business?>;
String _$activeBusinessIdHash() => r'6502fadbef4a27692bc7d7d8ae95b46503d2d704';

/// See also [activeBusinessId].
@ProviderFor(activeBusinessId)
final activeBusinessIdProvider = AutoDisposeFutureProvider<String?>.internal(
  activeBusinessId,
  name: r'activeBusinessIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeBusinessIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveBusinessIdRef = AutoDisposeFutureProviderRef<String?>;
String _$updateBusinessNotifierHash() =>
    r'085bb4d3e38f8e60711ac751c3d78ea1655b0aea';

/// See also [UpdateBusinessNotifier].
@ProviderFor(UpdateBusinessNotifier)
final updateBusinessNotifierProvider = AutoDisposeNotifierProvider<
    UpdateBusinessNotifier, AsyncValue<void>>.internal(
  UpdateBusinessNotifier.new,
  name: r'updateBusinessNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateBusinessNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateBusinessNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
