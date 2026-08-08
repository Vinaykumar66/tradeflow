// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inventoryListHash() => r'9103b1f40873097df640406283b1ae720328bc3f';

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
String _$lowStockProductsHash() => r'72282da6fe7830b7df2d879cf856d1c8e33fa679';

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
String _$expiringProductsHash() => r'5268ebe0c3b684e393464defcb2ad6c9a8019c40';

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
String _$filterInventoryHash() => r'0b576877930f506745ec2b1ef325cb10f8c192f3';

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
    r'06b7d753fb98da0f32381e893a21b8ad15adcd6b';

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
