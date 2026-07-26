// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userBusinessListHash() => r'37fa4a81287ea2cb011da1536249d32f65325c11';

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
String _$activeBusinessHash() => r'c4e7973d94a5c8579776aea1ab38031e39a076fa';

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
String _$updateBusinessNotifierHash() =>
    r'05020f66f6a045ff187b9bfdf4d137d243214ced';

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
