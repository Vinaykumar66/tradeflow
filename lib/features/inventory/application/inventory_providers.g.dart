// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inventoryListHash() => r'09a56a06cade06cfc07d584fbdbb86d0ddf4df12';

/// See also [inventoryList].
@ProviderFor(inventoryList)
final inventoryListProvider = AutoDisposeStreamProvider<List<Product>>.internal(
  inventoryList,
  name: r'inventoryListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inventoryListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InventoryListRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$lowStockProductsHash() => r'ed15d5303acfc55b8374f6c178f39b67692cf8d5';

/// See also [lowStockProducts].
@ProviderFor(lowStockProducts)
final lowStockProductsProvider =
    AutoDisposeStreamProvider<List<Product>>.internal(
  lowStockProducts,
  name: r'lowStockProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lowStockProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LowStockProductsRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$expiringProductsHash() => r'724355440c753188260926391831560e2dd2f39f';

/// See also [expiringProducts].
@ProviderFor(expiringProducts)
final expiringProductsProvider =
    AutoDisposeStreamProvider<List<Product>>.internal(
  expiringProducts,
  name: r'expiringProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expiringProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExpiringProductsRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$filterInventoryHash() => r'b19eb5944d5f06af4bf9421b91e0f7f33b4cad2f';

/// See also [filterInventory].
@ProviderFor(filterInventory)
final filterInventoryProvider =
    AutoDisposeProvider<AsyncValue<List<Product>>>.internal(
  filterInventory,
  name: r'filterInventoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filterInventoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilterInventoryRef = AutoDisposeProviderRef<AsyncValue<List<Product>>>;
String _$inventoryFilterHash() => r'a61c6474adfa90431834f00883c56dda357dc2e4';

/// See also [InventoryFilter].
@ProviderFor(InventoryFilter)
final inventoryFilterProvider =
    AutoDisposeNotifierProvider<InventoryFilter, String>.internal(
  InventoryFilter.new,
  name: r'inventoryFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inventoryFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InventoryFilter = AutoDisposeNotifier<String>;
String _$updateStockNotifierHash() =>
    r'471fae636bfcf435a30c7e0090a3f8240cf07a0e';

/// See also [UpdateStockNotifier].
@ProviderFor(UpdateStockNotifier)
final updateStockNotifierProvider =
    AutoDisposeNotifierProvider<UpdateStockNotifier, AsyncValue<void>>.internal(
  UpdateStockNotifier.new,
  name: r'updateStockNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateStockNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateStockNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
