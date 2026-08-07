import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

extension ProductX on Product {
  static Product fromMap(Map<String, dynamic> m) => Product.fromJson(m);
}

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    @JsonKey(name: 'business_id') required String businessId,
    required String sku,
    String? category,
    String? barcode,
    String? brand,
    required String description,
    @JsonKey(name: 'image_url') String? imageUrl,
    String? unit,
    //Prices in Paise(integer) - Rs. 99.50 = 9950
    @JsonKey(name: 'cost_price') @Default(0) int costPrice,
    @JsonKey(name: 'selling_price') @Default(0) int sellingPrice,
    @JsonKey(name: 'mrp') @Default(0) int mrp,
    //Tax
    @JsonKey(name: 'tax_rate') @Default(18.0) double taxRate,
    @JsonKey(name: 'tax_type') @Default('GST') String TaxType,
    @JsonKey(name: 'tax_inclusive') @Default(false) bool taxInclusive,
    //Inventory
    @JsonKey(name: 'stock_qty') @Default(0) int stockQty,
    @JsonKey(name: 'reorder_level') @Default(0) int reorderLevel,
    @JsonKey(name: 'reorder_qty') @Default(0) int reorderQty,
    @JsonKey(name: 'expiry_date') DateTime? expiryDate,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'track_inventory') @Default(true) bool trackInventory,
    @JsonKey(name: 'created_at') required DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'created_by') String? createdBy,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

enum StockStatus { inStock, lowStock, outOfStock, notTracked }

enum ExpiryStatus { valid, expiringSoon, expired, noExpiryDate }

extension ProdutX on Product {
  static Product fromMap(Map<String, dynamic> m) => Product.fromJson(m);
  Map<String, dynamic> toInsertMap() => {
        'business_id': businessId,
        'name': name,
        'sku': sku,
        'category': category,
        'barcode': barcode,
        'brand': brand,
        'description': description,
        'image_url': imageUrl,
        'unit': unit,
        'cost_price': costPrice,
        'selling_price': sellingPrice,
        'mrp': mrp,
        'tax_rate': taxRate,
        'tax_type': TaxType,
        'tax_inclusive': taxInclusive,
        'stock_qty': stockQty,
        'reorder_level': reorderLevel,
        'reorder_qty': reorderQty,
        'expiry_date': expiryDate?.toIso8601String(),
        'is_active': isActive,
        'track_inventory': trackInventory,
        'created_at': createdAt?.toIso8601String(),
        'created_by': createdBy,
      };
//Formatted price helpers to convert non decimal format to decimal format
  String get formatterSellingPrice =>
      '₹.${(sellingPrice / 100).toStringAsFixed(2)}';
  String get formattedCostPrice => '₹.${(costPrice / 100).toStringAsFixed(2)}';
  String get formattedMrp => '₹.${(mrp / 100).toStringAsFixed(2)}';

//profit margin percentage
  double get marginPercent {
    if (costPrice == 0) return 0;
    return ((sellingPrice - costPrice) / costPrice) * 100;
  }

  StockStatus get stockStatus {
    if (!trackInventory) return StockStatus.notTracked;
    if (stockQty <= 0) return StockStatus.outOfStock;
    if (reorderLevel > 0 && stockQty <= reorderLevel)
      return StockStatus.lowStock;
    return StockStatus.inStock;
  }

  ExpiryStatus get expiryStatus {
    if (expiryDate == null) return ExpiryStatus.noExpiryDate;
    final diff = expiryDate!.difference(DateTime.now()).inDays;
    if (diff < 0) return ExpiryStatus.expired;
    if (diff <= 30) return ExpiryStatus.expiringSoon;
    return ExpiryStatus.valid;
  }
}
