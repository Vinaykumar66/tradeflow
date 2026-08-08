// lib/features/catalog/application/catalog_providers.dart

import 'package:flutter/material.dart' show debugPrint;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/repository_providers.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/product.dart';
part 'catalog_providers.g.dart';

// ── productListProvider ───────────────────────────────────────────────────────
// Streams all active products for the current business
// Uses activeBusinessProvider directly — NOT activeBusinessIdProvider
// This avoids the FutureProvider-inside-StreamProvider timing issue
@riverpod
Stream<List<Product>> productList(ProductListRef ref) async* {
  // Watch business — this rebuilds when business loads
  final bizAsync = ref.watch(activeBusinessProvider);
  final bizId = bizAsync.asData?.value?.id;

  debugPrint('productListProvider: bizId=$bizId');

  if (bizId == null) {
    // Emit empty list immediately instead of never emitting
    // This moves provider to AsyncData([]) not AsyncLoading
    yield [];
    return;
  }

  // Stream all products for this business
  // Supabase realtime — updates when products are added/edited
  yield* ref.read(productRepositoryProvider).streamProducts(bizId);
}

// ── saveProductNotifierProvider ───────────────────────────────────────────────
@riverpod
class SaveProductNotifier extends _$SaveProductNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> save(Product product) async {
    state = const AsyncValue.loading();

    try {
      if (product.id.isEmpty) {
        await ref.read(productRepositoryProvider).createProduct(product);
        debugPrint('SaveProduct: created ${product.name}');
      } else {
        await ref.read(productRepositoryProvider).updateProduct(product);
        debugPrint('SaveProduct: updated ${product.name}');
      }
      state = const AsyncValue.data(null);
    } catch (e, st) {
      debugPrint('SaveProduct error: $e');
      state = AsyncValue.error(e, st);
      rethrow; // so _onSubmit catch block fires
    }
  }
}

// ── archiveProductNotifierProvider ────────────────────────────────────────────
@riverpod
class ArchiveProductNotifier extends _$ArchiveProductNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> archive(String bizId, String productId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() =>
        ref.read(productRepositoryProvider).archiveProduct(bizId, productId));
  }
}

// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../../../core/di/repository_providers.dart';
// import '../../../features/auth/application/auth_providers.dart';
// import '../../../shared/models/product.dart';

// part 'catalog_providers.g.dart';

// @riverpod
// Stream<List<Product>> productList(ProductListRef ref) {
//   final biz = ref.watch(activeBusinessIdProvider);
//   if (biz == null) return const Stream.empty();
//   return ref.watch(productRepositoryProvider).streamProducts(biz);
// }

// //Search query state
// @riverpod
// class ProductSearchQuery extends _$ProductSearchQuery {
//   @override
//   String build() => '';
//   void set(String q) => state = q;
//   void clear() => state = '';
// }

// //Category filter state
// @riverpod
// class SelectedProductCategory extends _$SelectedProductCategory {
//   @override
//   String? build() => null;
//   void set(String? c) => state = c;
// }

// //Filtered product list - search + category applied in memory
// @riverpod
// AsyncValue<List<Product>> filteredProducts(FilteredProductsRef ref) {
//   final all = ref.watch(productListProvider);
//   final q = ref.watch(productSearchQueryProvider).toLowerCase();
//   final cat = ref.watch(selectedProductCategoryProvider);
//   if (!all.hasValue) return all;
//   var list = all.requireValue;
//   if (cat != null) list = list.where((p) => p.category == cat).toList();
//   if (q.isNotEmpty)
//     list = list
//         .where((p) =>
//             p.name.toLowerCase().contains(q) ||
//             p.sku.toLowerCase().contains(q) ||
//             (p.barcode?.toLowerCase().contains(q) ?? false))
//         .toList();
//   return AsyncData(list);
// }

// //Save product(create or update)

// @riverpod
// class SaveProductNotifier extends _$SaveProductNotifier {
//   @override
//   AsyncValue<Product?> build() => const AsyncValue.data(null);
//   Future<Product?> save(Product p) async {
//     state = const AsyncValue.loading();
//     final repo = ref.read(productRepositoryProvider);
//     final result = await AsyncValue.guard<Product?>(() async {
//       if (p.id.isEmpty) return repo.createProduct(p);
//       await repo.updateProduct(p);
//       return p;
//     });
//     // if (ref.mounted) state = result;
//     return result.asData?.value;
//   }
// }

// //Archive product
// @riverpod
// class ArchiveProductNotifier extends _$ArchiveProductNotifier {
//   @override
//   AsyncValue<void> build() => const AsyncValue.data(null);
//   Future<void> archive(String bizId, String productId) async {
//     state = const AsyncValue.loading();
//     final r = await AsyncValue.guard(() =>
//         ref.read(productRepositoryProvider).archiveProduct(bizId, productId));
//     // if (ref.mounted)
//     state = r;
//   }
// }
