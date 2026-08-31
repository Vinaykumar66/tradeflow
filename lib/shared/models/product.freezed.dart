// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get unit =>
      throw _privateConstructorUsedError; // Prices in paise (integer) — e.g. 99.50 = 9950
// Currency symbol comes from businesses.currency_symbol
  @JsonKey(name: 'cost_price')
  int get costPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'selling_price')
  int get sellingPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'mrp')
  int get mrp => throw _privateConstructorUsedError; // Tax
  @JsonKey(name: 'tax_Id')
  String get taxCodeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_rate')
  double get taxRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_type')
  String get taxType => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_inclusive')
  bool get taxInclusive => throw _privateConstructorUsedError; // Inventory
  @JsonKey(name: 'stock_qty')
  int get stockQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'reorder_level')
  int get reorderLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'reorder_qty')
  int get reorderQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiry_date')
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'track_inventory')
  bool get trackInventory => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'hsn_sac_code')
  String? get hsnSacCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'commodity_code')
  String? get commodityCode => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'business_id') String businessId,
      String sku,
      String? category,
      String? barcode,
      String? brand,
      String description,
      @JsonKey(name: 'image_url') String? imageUrl,
      String? unit,
      @JsonKey(name: 'cost_price') int costPrice,
      @JsonKey(name: 'selling_price') int sellingPrice,
      @JsonKey(name: 'mrp') int mrp,
      @JsonKey(name: 'tax_Id') String taxCodeId,
      @JsonKey(name: 'tax_rate') double taxRate,
      @JsonKey(name: 'tax_type') String taxType,
      @JsonKey(name: 'tax_inclusive') bool taxInclusive,
      @JsonKey(name: 'stock_qty') int stockQty,
      @JsonKey(name: 'reorder_level') int reorderLevel,
      @JsonKey(name: 'reorder_qty') int reorderQty,
      @JsonKey(name: 'expiry_date') DateTime? expiryDate,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'track_inventory') bool trackInventory,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'hsn_sac_code') String? hsnSacCode,
      @JsonKey(name: 'commodity_code') String? commodityCode});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? businessId = null,
    Object? sku = null,
    Object? category = freezed,
    Object? barcode = freezed,
    Object? brand = freezed,
    Object? description = null,
    Object? imageUrl = freezed,
    Object? unit = freezed,
    Object? costPrice = null,
    Object? sellingPrice = null,
    Object? mrp = null,
    Object? taxCodeId = null,
    Object? taxRate = null,
    Object? taxType = null,
    Object? taxInclusive = null,
    Object? stockQty = null,
    Object? reorderLevel = null,
    Object? reorderQty = null,
    Object? expiryDate = freezed,
    Object? isActive = null,
    Object? trackInventory = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? createdBy = freezed,
    Object? hsnSacCode = freezed,
    Object? commodityCode = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      costPrice: null == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as int,
      sellingPrice: null == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as int,
      mrp: null == mrp
          ? _value.mrp
          : mrp // ignore: cast_nullable_to_non_nullable
              as int,
      taxCodeId: null == taxCodeId
          ? _value.taxCodeId
          : taxCodeId // ignore: cast_nullable_to_non_nullable
              as String,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      taxType: null == taxType
          ? _value.taxType
          : taxType // ignore: cast_nullable_to_non_nullable
              as String,
      taxInclusive: null == taxInclusive
          ? _value.taxInclusive
          : taxInclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      stockQty: null == stockQty
          ? _value.stockQty
          : stockQty // ignore: cast_nullable_to_non_nullable
              as int,
      reorderLevel: null == reorderLevel
          ? _value.reorderLevel
          : reorderLevel // ignore: cast_nullable_to_non_nullable
              as int,
      reorderQty: null == reorderQty
          ? _value.reorderQty
          : reorderQty // ignore: cast_nullable_to_non_nullable
              as int,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      trackInventory: null == trackInventory
          ? _value.trackInventory
          : trackInventory // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      hsnSacCode: freezed == hsnSacCode
          ? _value.hsnSacCode
          : hsnSacCode // ignore: cast_nullable_to_non_nullable
              as String?,
      commodityCode: freezed == commodityCode
          ? _value.commodityCode
          : commodityCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'business_id') String businessId,
      String sku,
      String? category,
      String? barcode,
      String? brand,
      String description,
      @JsonKey(name: 'image_url') String? imageUrl,
      String? unit,
      @JsonKey(name: 'cost_price') int costPrice,
      @JsonKey(name: 'selling_price') int sellingPrice,
      @JsonKey(name: 'mrp') int mrp,
      @JsonKey(name: 'tax_Id') String taxCodeId,
      @JsonKey(name: 'tax_rate') double taxRate,
      @JsonKey(name: 'tax_type') String taxType,
      @JsonKey(name: 'tax_inclusive') bool taxInclusive,
      @JsonKey(name: 'stock_qty') int stockQty,
      @JsonKey(name: 'reorder_level') int reorderLevel,
      @JsonKey(name: 'reorder_qty') int reorderQty,
      @JsonKey(name: 'expiry_date') DateTime? expiryDate,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'track_inventory') bool trackInventory,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'hsn_sac_code') String? hsnSacCode,
      @JsonKey(name: 'commodity_code') String? commodityCode});
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? businessId = null,
    Object? sku = null,
    Object? category = freezed,
    Object? barcode = freezed,
    Object? brand = freezed,
    Object? description = null,
    Object? imageUrl = freezed,
    Object? unit = freezed,
    Object? costPrice = null,
    Object? sellingPrice = null,
    Object? mrp = null,
    Object? taxCodeId = null,
    Object? taxRate = null,
    Object? taxType = null,
    Object? taxInclusive = null,
    Object? stockQty = null,
    Object? reorderLevel = null,
    Object? reorderQty = null,
    Object? expiryDate = freezed,
    Object? isActive = null,
    Object? trackInventory = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? createdBy = freezed,
    Object? hsnSacCode = freezed,
    Object? commodityCode = freezed,
  }) {
    return _then(_$ProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      costPrice: null == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as int,
      sellingPrice: null == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as int,
      mrp: null == mrp
          ? _value.mrp
          : mrp // ignore: cast_nullable_to_non_nullable
              as int,
      taxCodeId: null == taxCodeId
          ? _value.taxCodeId
          : taxCodeId // ignore: cast_nullable_to_non_nullable
              as String,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      taxType: null == taxType
          ? _value.taxType
          : taxType // ignore: cast_nullable_to_non_nullable
              as String,
      taxInclusive: null == taxInclusive
          ? _value.taxInclusive
          : taxInclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      stockQty: null == stockQty
          ? _value.stockQty
          : stockQty // ignore: cast_nullable_to_non_nullable
              as int,
      reorderLevel: null == reorderLevel
          ? _value.reorderLevel
          : reorderLevel // ignore: cast_nullable_to_non_nullable
              as int,
      reorderQty: null == reorderQty
          ? _value.reorderQty
          : reorderQty // ignore: cast_nullable_to_non_nullable
              as int,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      trackInventory: null == trackInventory
          ? _value.trackInventory
          : trackInventory // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      hsnSacCode: freezed == hsnSacCode
          ? _value.hsnSacCode
          : hsnSacCode // ignore: cast_nullable_to_non_nullable
              as String?,
      commodityCode: freezed == commodityCode
          ? _value.commodityCode
          : commodityCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'business_id') required this.businessId,
      required this.sku,
      this.category,
      this.barcode,
      this.brand,
      required this.description,
      @JsonKey(name: 'image_url') this.imageUrl,
      this.unit,
      @JsonKey(name: 'cost_price') this.costPrice = 0,
      @JsonKey(name: 'selling_price') this.sellingPrice = 0,
      @JsonKey(name: 'mrp') this.mrp = 0,
      @JsonKey(name: 'tax_Id') this.taxCodeId = 'GSTIN',
      @JsonKey(name: 'tax_rate') this.taxRate = 18.0,
      @JsonKey(name: 'tax_type') this.taxType = 'GST',
      @JsonKey(name: 'tax_inclusive') this.taxInclusive = false,
      @JsonKey(name: 'stock_qty') this.stockQty = 0,
      @JsonKey(name: 'reorder_level') this.reorderLevel = 0,
      @JsonKey(name: 'reorder_qty') this.reorderQty = 0,
      @JsonKey(name: 'expiry_date') this.expiryDate,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'track_inventory') this.trackInventory = true,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'hsn_sac_code') this.hsnSacCode,
      @JsonKey(name: 'commodity_code') this.commodityCode});

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  final String sku;
  @override
  final String? category;
  @override
  final String? barcode;
  @override
  final String? brand;
  @override
  final String description;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  final String? unit;
// Prices in paise (integer) — e.g. 99.50 = 9950
// Currency symbol comes from businesses.currency_symbol
  @override
  @JsonKey(name: 'cost_price')
  final int costPrice;
  @override
  @JsonKey(name: 'selling_price')
  final int sellingPrice;
  @override
  @JsonKey(name: 'mrp')
  final int mrp;
// Tax
  @override
  @JsonKey(name: 'tax_Id')
  final String taxCodeId;
  @override
  @JsonKey(name: 'tax_rate')
  final double taxRate;
  @override
  @JsonKey(name: 'tax_type')
  final String taxType;
  @override
  @JsonKey(name: 'tax_inclusive')
  final bool taxInclusive;
// Inventory
  @override
  @JsonKey(name: 'stock_qty')
  final int stockQty;
  @override
  @JsonKey(name: 'reorder_level')
  final int reorderLevel;
  @override
  @JsonKey(name: 'reorder_qty')
  final int reorderQty;
  @override
  @JsonKey(name: 'expiry_date')
  final DateTime? expiryDate;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'track_inventory')
  final bool trackInventory;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'hsn_sac_code')
  final String? hsnSacCode;
  @override
  @JsonKey(name: 'commodity_code')
  final String? commodityCode;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, businessId: $businessId, sku: $sku, category: $category, barcode: $barcode, brand: $brand, description: $description, imageUrl: $imageUrl, unit: $unit, costPrice: $costPrice, sellingPrice: $sellingPrice, mrp: $mrp, taxCodeId: $taxCodeId, taxRate: $taxRate, taxType: $taxType, taxInclusive: $taxInclusive, stockQty: $stockQty, reorderLevel: $reorderLevel, reorderQty: $reorderQty, expiryDate: $expiryDate, isActive: $isActive, trackInventory: $trackInventory, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, hsnSacCode: $hsnSacCode, commodityCode: $commodityCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice) &&
            (identical(other.mrp, mrp) || other.mrp == mrp) &&
            (identical(other.taxCodeId, taxCodeId) ||
                other.taxCodeId == taxCodeId) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.taxType, taxType) || other.taxType == taxType) &&
            (identical(other.taxInclusive, taxInclusive) ||
                other.taxInclusive == taxInclusive) &&
            (identical(other.stockQty, stockQty) ||
                other.stockQty == stockQty) &&
            (identical(other.reorderLevel, reorderLevel) ||
                other.reorderLevel == reorderLevel) &&
            (identical(other.reorderQty, reorderQty) ||
                other.reorderQty == reorderQty) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.trackInventory, trackInventory) ||
                other.trackInventory == trackInventory) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.hsnSacCode, hsnSacCode) ||
                other.hsnSacCode == hsnSacCode) &&
            (identical(other.commodityCode, commodityCode) ||
                other.commodityCode == commodityCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        businessId,
        sku,
        category,
        barcode,
        brand,
        description,
        imageUrl,
        unit,
        costPrice,
        sellingPrice,
        mrp,
        taxCodeId,
        taxRate,
        taxType,
        taxInclusive,
        stockQty,
        reorderLevel,
        reorderQty,
        expiryDate,
        isActive,
        trackInventory,
        createdAt,
        updatedAt,
        createdBy,
        hsnSacCode,
        commodityCode
      ]);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
          {required final String id,
          required final String name,
          @JsonKey(name: 'business_id') required final String businessId,
          required final String sku,
          final String? category,
          final String? barcode,
          final String? brand,
          required final String description,
          @JsonKey(name: 'image_url') final String? imageUrl,
          final String? unit,
          @JsonKey(name: 'cost_price') final int costPrice,
          @JsonKey(name: 'selling_price') final int sellingPrice,
          @JsonKey(name: 'mrp') final int mrp,
          @JsonKey(name: 'tax_Id') final String taxCodeId,
          @JsonKey(name: 'tax_rate') final double taxRate,
          @JsonKey(name: 'tax_type') final String taxType,
          @JsonKey(name: 'tax_inclusive') final bool taxInclusive,
          @JsonKey(name: 'stock_qty') final int stockQty,
          @JsonKey(name: 'reorder_level') final int reorderLevel,
          @JsonKey(name: 'reorder_qty') final int reorderQty,
          @JsonKey(name: 'expiry_date') final DateTime? expiryDate,
          @JsonKey(name: 'is_active') final bool isActive,
          @JsonKey(name: 'track_inventory') final bool trackInventory,
          @JsonKey(name: 'created_at') required final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt,
          @JsonKey(name: 'created_by') final String? createdBy,
          @JsonKey(name: 'hsn_sac_code') final String? hsnSacCode,
          @JsonKey(name: 'commodity_code') final String? commodityCode}) =
      _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  String get sku;
  @override
  String? get category;
  @override
  String? get barcode;
  @override
  String? get brand;
  @override
  String get description;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  String? get unit; // Prices in paise (integer) — e.g. 99.50 = 9950
// Currency symbol comes from businesses.currency_symbol
  @override
  @JsonKey(name: 'cost_price')
  int get costPrice;
  @override
  @JsonKey(name: 'selling_price')
  int get sellingPrice;
  @override
  @JsonKey(name: 'mrp')
  int get mrp; // Tax
  @override
  @JsonKey(name: 'tax_Id')
  String get taxCodeId;
  @override
  @JsonKey(name: 'tax_rate')
  double get taxRate;
  @override
  @JsonKey(name: 'tax_type')
  String get taxType;
  @override
  @JsonKey(name: 'tax_inclusive')
  bool get taxInclusive; // Inventory
  @override
  @JsonKey(name: 'stock_qty')
  int get stockQty;
  @override
  @JsonKey(name: 'reorder_level')
  int get reorderLevel;
  @override
  @JsonKey(name: 'reorder_qty')
  int get reorderQty;
  @override
  @JsonKey(name: 'expiry_date')
  DateTime? get expiryDate;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'track_inventory')
  bool get trackInventory;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'hsn_sac_code')
  String? get hsnSacCode;
  @override
  @JsonKey(name: 'commodity_code')
  String? get commodityCode;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
