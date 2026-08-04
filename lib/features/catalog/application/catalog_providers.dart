import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/repository_providers.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../shared/models/product.dart';

part 'catalog_providers.g.dart';

@riverpod
Stream<List<Product>> productList(ProductListRef ref) {
  final biz = ref.watch(activeBusinessIdProvider);
  if (biz == null) return const Stream.empty();
  return ref.watch(productRepositoryProvider).streamProducts(biz);
}

//Search query state
@riverpod
class ProductSearchQuery extends _$ProductSearchQuery {
  @override
  String build() => '';
  void set(String q) => state = q;
  void clear() => state = '';
}

//Category filter state
@riverpod
class SelectedProductCategory extends _$SelectedProductCategory {
  @override
  String? build() => null;
  void set(String? c) => state = c;
}

//Filtered product list - search + category applied in memory
@riverpod
AsyncValue<List<Product>> filteredProducts(FilteredProductsRef ref) {
  final all = ref.watch(productListProvider);
  final q = ref.watch(productSearchQueryProvider).toLowerCase();
  final cat = ref.watch(selectedProductCategoryProvider);
  if (!all.hasValue) return all;
  var list = all.requireValue;
  if (cat != null) list = list.where((p) => p.category == cat).toList();
  if (q.isNotEmpty)
    list = list
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.sku.toLowerCase().contains(q) ||
            (p.barcode?.toLowerCase().contains(q) ?? false))
        .toList();
  return AsyncData(list);
}

//Save product(create or update)

@riverpod
class SaveProductNotifier extends _$SaveProductNotifier {
  @override
  AsyncValue<Product?> build() => const AsyncValue.data(null);
  Future<Product?> save(Product p) async {
    state = const AsyncValue.loading();
    final repo = ref.read(productRepositoryProvider);
    final result = await AsyncValue.guard<Product?>(() async {
      if (p.id.isEmpty) return repo.createProduct(p);
      await repo.updateProduct(p);
      return p;
    });
    // if (ref.mounted) state = result;
    return result.asData?.value;
  }
}

//Archive product
@riverpod
class ArchiveProductNotifier extends _$ArchiveProductNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);
  Future<void> archive(String bizId, String productId) async {
    state = const AsyncValue.loading();
    final r = await AsyncValue.guard(() =>
        ref.read(productRepositoryProvider).archiveProduct(bizId, productId));
    // if (ref.mounted)
    state = r;
  }
}
