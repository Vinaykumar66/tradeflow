// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productListHash() => r'0ea4bde9aab4d7e4cf3f2f17c60da687254a8be6';

/// See also [productList].
@ProviderFor(productList)
final productListProvider = AutoDisposeStreamProvider<List<Product>>.internal(
  productList,
  name: r'productListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$productListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductListRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$saveProductNotifierHash() =>
    r'd5bbaa1cf2c0b2ce5aed6637eace2c84c6e8bd67';

/// See also [SaveProductNotifier].
@ProviderFor(SaveProductNotifier)
final saveProductNotifierProvider =
    AutoDisposeNotifierProvider<SaveProductNotifier, AsyncValue<void>>.internal(
  SaveProductNotifier.new,
  name: r'saveProductNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveProductNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SaveProductNotifier = AutoDisposeNotifier<AsyncValue<void>>;
String _$archiveProductNotifierHash() =>
    r'b82150a57c558d632554527ccb609076000495ae';

/// See also [ArchiveProductNotifier].
@ProviderFor(ArchiveProductNotifier)
final archiveProductNotifierProvider = AutoDisposeNotifierProvider<
    ArchiveProductNotifier, AsyncValue<void>>.internal(
  ArchiveProductNotifier.new,
  name: r'archiveProductNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$archiveProductNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ArchiveProductNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
