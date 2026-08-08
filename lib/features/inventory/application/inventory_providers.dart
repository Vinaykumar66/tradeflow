import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tradeflow/features/business/application/business_providers.dart';
import '../../../core/di/repository_providers.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../shared/models/product.dart';

part 'inventory_providers.g.dart';

@riverpod
Stream<List<Product>> inventoryList(InventoryListRef ref) {
  final biz = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (biz == null) {
    return const Stream.empty();
  }
  return ref.watch(productRepositoryProvider).streamProducts(biz);
}

@riverpod
Stream<List<Product>> lowStockProducts(LowStockProductsRef ref) {
  final biz = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (biz == null) {
    return const Stream.empty();
  }
  return ref.watch(productRepositoryProvider).streamLowStockProducts(biz);
}

@riverpod
Stream<List<Product>> expiringProducts(ExpiringProductsRef ref) {
  final biz = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (biz == null) {
    return const Stream.empty();
  }
  return ref.watch(productRepositoryProvider).streamExpiringProducts(biz, 30);
}

@riverpod
class InventoryFilter extends _$InventoryFilter {
  @override
  String build() => 'all';
  void set(String f) => state = f;
}

@riverpod
AsyncValue<List<Product>> filterInventory(FilterInventoryRef ref) {
  final filter = ref.watch(inventoryFilterProvider);
  final all = ref.watch(inventoryListProvider);
  if (!all.hasValue) return all;
  final products = all.requireValue;
  return AsyncData(switch (filter) {
    'low' =>
      products.where((p) => p.stockStatus == StockStatus.lowStock).toList(),
    'out' =>
      products.where((p) => p.stockStatus == StockStatus.outOfStock).toList(),
    'expiring' => products
        .where((p) =>
            p.expiryStatus == ExpiryStatus.expiringSoon ||
            p.expiryStatus == ExpiryStatus.expired)
        .toList(),
    _ => products,
  });
}

@riverpod
class UpdateStockNotifier extends _$UpdateStockNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);
  Future<void> update(
      {required String bizId,
      required String productId,
      required int newQty}) async {
    state = const AsyncValue.loading();
    final uid = ref.read(currentSupabaseUserProvider)?.id ?? '';
    final r = await AsyncValue.guard(() => ref
        .read(productRepositoryProvider)
        .updateStock(
            businessId: bizId,
            productId: productId,
            newStockQty: newQty,
            updatedBy: uid));
    // if (ref.mounted)
    state = r;
  }
}
