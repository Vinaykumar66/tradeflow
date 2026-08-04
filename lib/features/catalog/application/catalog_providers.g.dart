// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productListHash() => r'dbe4132890608d546ddf973739d6aa3e325e96db';

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
String _$filteredProductsHash() => r'ae8e97eb294e84db0acaaece93e86b82757fcc48';

/// See also [filteredProducts].
@ProviderFor(filteredProducts)
final filteredProductsProvider =
    AutoDisposeProvider<AsyncValue<List<Product>>>.internal(
  filteredProducts,
  name: r'filteredProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredProductsRef = AutoDisposeProviderRef<AsyncValue<List<Product>>>;
String _$productSearchQueryHash() =>
    r'bedaf5d2189dd1c04c717e665058438be50faef4';

/// See also [ProductSearchQuery].
@ProviderFor(ProductSearchQuery)
final productSearchQueryProvider =
    AutoDisposeNotifierProvider<ProductSearchQuery, String>.internal(
  ProductSearchQuery.new,
  name: r'productSearchQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productSearchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductSearchQuery = AutoDisposeNotifier<String>;
String _$selectedProductCategoryHash() =>
    r'2d5d00d7f712cfca8b87d28a86cfd31e175f9319';

/// See also [SelectedProductCategory].
@ProviderFor(SelectedProductCategory)
final selectedProductCategoryProvider =
    AutoDisposeNotifierProvider<SelectedProductCategory, String?>.internal(
  SelectedProductCategory.new,
  name: r'selectedProductCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedProductCategoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedProductCategory = AutoDisposeNotifier<String?>;
String _$saveProductNotifierHash() =>
    r'd968d89091a04d6ca483478f2a2678f9615f2080';

/// See also [SaveProductNotifier].
@ProviderFor(SaveProductNotifier)
final saveProductNotifierProvider = AutoDisposeNotifierProvider<
    SaveProductNotifier, AsyncValue<Product?>>.internal(
  SaveProductNotifier.new,
  name: r'saveProductNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveProductNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SaveProductNotifier = AutoDisposeNotifier<AsyncValue<Product?>>;
String _$archiveProductNotifierHash() =>
    r'6c9ba4fc31f1d35d644abcca70d5ba3a515acfb2';

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
