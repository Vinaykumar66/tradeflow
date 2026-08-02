import '../../shared/models/product.dart';

abstract interface class IProductRepository {
  Future<Product> createProduct(Product product);
  Future<Product?> getProduct(String businessId, String productId);
  Future<Product?> getProductByBarcode(String businessId, String barcode);
  Stream<List<Product>> streamProducts(String businessId);
  Stream<List<Product>> streamLowStockProducts(String businessId);
  Stream<List<Product>> streamExpiringProducts(
      String businessId, int withinDays);
  Future<List<String>> getCategories(String businessId);
  Future<Product> updateProduct(Product product);
  Future<void> updateStock({
    required String businessId,
    required String productId,
    required int newStockQty,
    required String updatedBy,
  });
  Future<void> archiveProduct(String businessId, String productId);
}
