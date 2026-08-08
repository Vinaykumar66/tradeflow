import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/table_constants.dart';
import '../../../core/interfaces/i_product_repository.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/product.dart';

class ProductRepository implements IProductRepository {
  final _uuid = const Uuid();

  @override
  Future<Product> createProduct(Product product) async {
    final id = product.id.isEmpty ? _uuid.v4() : product.id;
    final map = {...product.toInsertMap(), 'id': id};
    await supabase.from(SupabaseTables.products).insert(map);
    return product.copyWith(id: id);
  }

  @override
  Future<Product?> getProduct(String businessId, String productId) async {
    final d = await supabase
        .from(SupabaseTables.products)
        .select()
        .eq('business_id', businessId)
        .eq('id', productId)
        .maybeSingle();
    return d == null ? null : ProductX.fromMap(d);
  }

  @override
  Future<Product?> getProductByBarcode(
      String businessId, String barcode) async {
    // Guard — never query with empty businessId
    if (businessId.isEmpty) {
      debugPrint('getProductByBarcode: empty businessId — skipping');
      return null;
    }

    final d = await supabase
        .from(SupabaseTables.products)
        .select()
        .eq('business_id', businessId)
        .eq('barcode', barcode)
        .maybeSingle();
    return d == null ? null : ProductX.fromMap(d);
  }

  @override
  Stream<List<Product>> streamProducts(String businessId) {
    return supabase
        .from(SupabaseTables.products)
        .stream(primaryKey: ['id'])
        .eq('business_id', businessId)
        .order('name')
        .map((rows) => rows
            .where((r) => r['is_active'] == true)
            .map((r) => ProductX.fromMap(r))
            .toList());
  }

  @override
  Stream<List<Product>> streamLowStockProducts(String businessId) {
    return streamProducts(businessId).map((products) => products
        .where((p) =>
            p.trackInventory &&
            p.stockQty <= p.reorderLevel &&
            p.reorderLevel > 0)
        .toList());
  }

  Stream<List<Product>> streamExpiringProducts(
      String businessId, int withinDays) {
    return streamProducts(businessId).map((products) {
      final cutoff = DateTime.now().add(Duration(days: withinDays));
      return products
          .where((p) => p.expiryDate != null && p.expiryDate!.isBefore(cutoff))
          .toList();
    });
  }

  @override
  Future<List<String>> getCategories(String businessId) async {
    final rows = await supabase
        .from(SupabaseTables.products)
        .select('category')
        .eq('business_id', businessId)
        .eq('is_active', true);
    final categories = rows
        .map((r) => r['category'] as String?)
        .whereType<String>()
        .toSet()
        .toList()
      ..sort();
    categories.sort();
    return categories;
  }

  @override
  Future<Product> updateProduct(Product product) async {
    await supabase.from(SupabaseTables.products).update({
      ...product.toInsertMap(),
      'updated_at': DateTime.now().toIso8601String()
    }).eq('id', product.id);
    return product;
  }

  @override
  Future<void> updateStock({
    required String businessId,
    required String productId,
    required int newStockQty,
    required String updatedBy,
  }) async {
    await supabase
        .from(SupabaseTables.products)
        .update({
          'stock_qty': newStockQty,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', productId)
        .eq('business_id', businessId);
  }

  @override
  Future<void> archiveProduct(String businessId, String productId) async {
    await supabase
        .from(SupabaseTables.products)
        .update({'is_active': false}).eq('id', productId);
  }
}
