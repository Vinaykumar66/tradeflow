// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PurchaseBillItem _$PurchaseBillItemFromJson(Map<String, dynamic> json) {
  return _PurchaseBillItem.fromJson(json);
}

/// @nodoc
mixin _$PurchaseBillItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_bill_id')
  String get purchaseBillId => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  String? get productId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  int get unitPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_rate')
  double get taxRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'cgst_amount')
  int get cgstAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sgst_amount')
  int get sgstAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'igst_amount')
  int get igstAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'ugst_amount')
  int get ugstAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'line_total')
  int get lineTotal => throw _privateConstructorUsedError;

  /// Serializes this PurchaseBillItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseBillItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseBillItemCopyWith<PurchaseBillItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseBillItemCopyWith<$Res> {
  factory $PurchaseBillItemCopyWith(
          PurchaseBillItem value, $Res Function(PurchaseBillItem) then) =
      _$PurchaseBillItemCopyWithImpl<$Res, PurchaseBillItem>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'purchase_bill_id') String purchaseBillId,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'product_id') String? productId,
      String name,
      double quantity,
      @JsonKey(name: 'unit_price') int unitPrice,
      @JsonKey(name: 'tax_rate') double taxRate,
      @JsonKey(name: 'cgst_amount') int cgstAmount,
      @JsonKey(name: 'sgst_amount') int sgstAmount,
      @JsonKey(name: 'igst_amount') int igstAmount,
      @JsonKey(name: 'ugst_amount') int ugstAmount,
      @JsonKey(name: 'line_total') int lineTotal});
}

/// @nodoc
class _$PurchaseBillItemCopyWithImpl<$Res, $Val extends PurchaseBillItem>
    implements $PurchaseBillItemCopyWith<$Res> {
  _$PurchaseBillItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseBillItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? purchaseBillId = null,
    Object? businessId = null,
    Object? productId = freezed,
    Object? name = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? taxRate = null,
    Object? cgstAmount = null,
    Object? sgstAmount = null,
    Object? igstAmount = null,
    Object? ugstAmount = null,
    Object? lineTotal = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseBillId: null == purchaseBillId
          ? _value.purchaseBillId
          : purchaseBillId // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as int,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      cgstAmount: null == cgstAmount
          ? _value.cgstAmount
          : cgstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      sgstAmount: null == sgstAmount
          ? _value.sgstAmount
          : sgstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      igstAmount: null == igstAmount
          ? _value.igstAmount
          : igstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      ugstAmount: null == ugstAmount
          ? _value.ugstAmount
          : ugstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      lineTotal: null == lineTotal
          ? _value.lineTotal
          : lineTotal // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseBillItemImplCopyWith<$Res>
    implements $PurchaseBillItemCopyWith<$Res> {
  factory _$$PurchaseBillItemImplCopyWith(_$PurchaseBillItemImpl value,
          $Res Function(_$PurchaseBillItemImpl) then) =
      __$$PurchaseBillItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'purchase_bill_id') String purchaseBillId,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'product_id') String? productId,
      String name,
      double quantity,
      @JsonKey(name: 'unit_price') int unitPrice,
      @JsonKey(name: 'tax_rate') double taxRate,
      @JsonKey(name: 'cgst_amount') int cgstAmount,
      @JsonKey(name: 'sgst_amount') int sgstAmount,
      @JsonKey(name: 'igst_amount') int igstAmount,
      @JsonKey(name: 'ugst_amount') int ugstAmount,
      @JsonKey(name: 'line_total') int lineTotal});
}

/// @nodoc
class __$$PurchaseBillItemImplCopyWithImpl<$Res>
    extends _$PurchaseBillItemCopyWithImpl<$Res, _$PurchaseBillItemImpl>
    implements _$$PurchaseBillItemImplCopyWith<$Res> {
  __$$PurchaseBillItemImplCopyWithImpl(_$PurchaseBillItemImpl _value,
      $Res Function(_$PurchaseBillItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseBillItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? purchaseBillId = null,
    Object? businessId = null,
    Object? productId = freezed,
    Object? name = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? taxRate = null,
    Object? cgstAmount = null,
    Object? sgstAmount = null,
    Object? igstAmount = null,
    Object? ugstAmount = null,
    Object? lineTotal = null,
  }) {
    return _then(_$PurchaseBillItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseBillId: null == purchaseBillId
          ? _value.purchaseBillId
          : purchaseBillId // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as int,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      cgstAmount: null == cgstAmount
          ? _value.cgstAmount
          : cgstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      sgstAmount: null == sgstAmount
          ? _value.sgstAmount
          : sgstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      igstAmount: null == igstAmount
          ? _value.igstAmount
          : igstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      ugstAmount: null == ugstAmount
          ? _value.ugstAmount
          : ugstAmount // ignore: cast_nullable_to_non_nullable
              as int,
      lineTotal: null == lineTotal
          ? _value.lineTotal
          : lineTotal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseBillItemImpl implements _PurchaseBillItem {
  const _$PurchaseBillItemImpl(
      {required this.id,
      @JsonKey(name: 'purchase_bill_id') required this.purchaseBillId,
      @JsonKey(name: 'business_id') required this.businessId,
      @JsonKey(name: 'product_id') this.productId,
      required this.name,
      this.quantity = 1.0,
      @JsonKey(name: 'unit_price') this.unitPrice = 0,
      @JsonKey(name: 'tax_rate') this.taxRate = 0.0,
      @JsonKey(name: 'cgst_amount') this.cgstAmount = 0,
      @JsonKey(name: 'sgst_amount') this.sgstAmount = 0,
      @JsonKey(name: 'igst_amount') this.igstAmount = 0,
      @JsonKey(name: 'ugst_amount') this.ugstAmount = 0,
      @JsonKey(name: 'line_total') this.lineTotal = 0});

  factory _$PurchaseBillItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseBillItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'purchase_bill_id')
  final String purchaseBillId;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  @JsonKey(name: 'product_id')
  final String? productId;
  @override
  final String name;
  @override
  @JsonKey()
  final double quantity;
  @override
  @JsonKey(name: 'unit_price')
  final int unitPrice;
  @override
  @JsonKey(name: 'tax_rate')
  final double taxRate;
  @override
  @JsonKey(name: 'cgst_amount')
  final int cgstAmount;
  @override
  @JsonKey(name: 'sgst_amount')
  final int sgstAmount;
  @override
  @JsonKey(name: 'igst_amount')
  final int igstAmount;
  @override
  @JsonKey(name: 'ugst_amount')
  final int ugstAmount;
  @override
  @JsonKey(name: 'line_total')
  final int lineTotal;

  @override
  String toString() {
    return 'PurchaseBillItem(id: $id, purchaseBillId: $purchaseBillId, businessId: $businessId, productId: $productId, name: $name, quantity: $quantity, unitPrice: $unitPrice, taxRate: $taxRate, cgstAmount: $cgstAmount, sgstAmount: $sgstAmount, igstAmount: $igstAmount, ugstAmount: $ugstAmount, lineTotal: $lineTotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseBillItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.purchaseBillId, purchaseBillId) ||
                other.purchaseBillId == purchaseBillId) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.cgstAmount, cgstAmount) ||
                other.cgstAmount == cgstAmount) &&
            (identical(other.sgstAmount, sgstAmount) ||
                other.sgstAmount == sgstAmount) &&
            (identical(other.igstAmount, igstAmount) ||
                other.igstAmount == igstAmount) &&
            (identical(other.ugstAmount, ugstAmount) ||
                other.ugstAmount == ugstAmount) &&
            (identical(other.lineTotal, lineTotal) ||
                other.lineTotal == lineTotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      purchaseBillId,
      businessId,
      productId,
      name,
      quantity,
      unitPrice,
      taxRate,
      cgstAmount,
      sgstAmount,
      igstAmount,
      ugstAmount,
      lineTotal);

  /// Create a copy of PurchaseBillItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseBillItemImplCopyWith<_$PurchaseBillItemImpl> get copyWith =>
      __$$PurchaseBillItemImplCopyWithImpl<_$PurchaseBillItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseBillItemImplToJson(
      this,
    );
  }
}

abstract class _PurchaseBillItem implements PurchaseBillItem {
  const factory _PurchaseBillItem(
      {required final String id,
      @JsonKey(name: 'purchase_bill_id') required final String purchaseBillId,
      @JsonKey(name: 'business_id') required final String businessId,
      @JsonKey(name: 'product_id') final String? productId,
      required final String name,
      final double quantity,
      @JsonKey(name: 'unit_price') final int unitPrice,
      @JsonKey(name: 'tax_rate') final double taxRate,
      @JsonKey(name: 'cgst_amount') final int cgstAmount,
      @JsonKey(name: 'sgst_amount') final int sgstAmount,
      @JsonKey(name: 'igst_amount') final int igstAmount,
      @JsonKey(name: 'ugst_amount') final int ugstAmount,
      @JsonKey(name: 'line_total')
      final int lineTotal}) = _$PurchaseBillItemImpl;

  factory _PurchaseBillItem.fromJson(Map<String, dynamic> json) =
      _$PurchaseBillItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'purchase_bill_id')
  String get purchaseBillId;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  @JsonKey(name: 'product_id')
  String? get productId;
  @override
  String get name;
  @override
  double get quantity;
  @override
  @JsonKey(name: 'unit_price')
  int get unitPrice;
  @override
  @JsonKey(name: 'tax_rate')
  double get taxRate;
  @override
  @JsonKey(name: 'cgst_amount')
  int get cgstAmount;
  @override
  @JsonKey(name: 'sgst_amount')
  int get sgstAmount;
  @override
  @JsonKey(name: 'igst_amount')
  int get igstAmount;
  @override
  @JsonKey(name: 'ugst_amount')
  int get ugstAmount;
  @override
  @JsonKey(name: 'line_total')
  int get lineTotal;

  /// Create a copy of PurchaseBillItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseBillItemImplCopyWith<_$PurchaseBillItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchaseBill _$PurchaseBillFromJson(Map<String, dynamic> json) {
  return _PurchaseBill.fromJson(json);
}

/// @nodoc
mixin _$PurchaseBill {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_id')
  String? get vendorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'bill_number')
  String get billNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'bill_date')
  DateTime get billDate => throw _privateConstructorUsedError;
  int get subtotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'cgst_total')
  int get cgstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'sgst_total')
  int get sgstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'igst_total')
  int get igstTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'ugst_total')
  int get ugstTotal => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<PurchaseBillItem> get items => throw _privateConstructorUsedError;

  /// Serializes this PurchaseBill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseBill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseBillCopyWith<PurchaseBill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseBillCopyWith<$Res> {
  factory $PurchaseBillCopyWith(
          PurchaseBill value, $Res Function(PurchaseBill) then) =
      _$PurchaseBillCopyWithImpl<$Res, PurchaseBill>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'vendor_id') String? vendorId,
      @JsonKey(name: 'bill_number') String billNumber,
      @JsonKey(name: 'bill_date') DateTime billDate,
      int subtotal,
      @JsonKey(name: 'cgst_total') int cgstTotal,
      @JsonKey(name: 'sgst_total') int sgstTotal,
      @JsonKey(name: 'igst_total') int igstTotal,
      @JsonKey(name: 'ugst_total') int ugstTotal,
      int total,
      String status,
      String? notes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<PurchaseBillItem> items});
}

/// @nodoc
class _$PurchaseBillCopyWithImpl<$Res, $Val extends PurchaseBill>
    implements $PurchaseBillCopyWith<$Res> {
  _$PurchaseBillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseBill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? vendorId = freezed,
    Object? billNumber = null,
    Object? billDate = null,
    Object? subtotal = null,
    Object? cgstTotal = null,
    Object? sgstTotal = null,
    Object? igstTotal = null,
    Object? ugstTotal = null,
    Object? total = null,
    Object? status = null,
    Object? notes = freezed,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      vendorId: freezed == vendorId
          ? _value.vendorId
          : vendorId // ignore: cast_nullable_to_non_nullable
              as String?,
      billNumber: null == billNumber
          ? _value.billNumber
          : billNumber // ignore: cast_nullable_to_non_nullable
              as String,
      billDate: null == billDate
          ? _value.billDate
          : billDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as int,
      cgstTotal: null == cgstTotal
          ? _value.cgstTotal
          : cgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      sgstTotal: null == sgstTotal
          ? _value.sgstTotal
          : sgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      igstTotal: null == igstTotal
          ? _value.igstTotal
          : igstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      ugstTotal: null == ugstTotal
          ? _value.ugstTotal
          : ugstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PurchaseBillItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseBillImplCopyWith<$Res>
    implements $PurchaseBillCopyWith<$Res> {
  factory _$$PurchaseBillImplCopyWith(
          _$PurchaseBillImpl value, $Res Function(_$PurchaseBillImpl) then) =
      __$$PurchaseBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'vendor_id') String? vendorId,
      @JsonKey(name: 'bill_number') String billNumber,
      @JsonKey(name: 'bill_date') DateTime billDate,
      int subtotal,
      @JsonKey(name: 'cgst_total') int cgstTotal,
      @JsonKey(name: 'sgst_total') int sgstTotal,
      @JsonKey(name: 'igst_total') int igstTotal,
      @JsonKey(name: 'ugst_total') int ugstTotal,
      int total,
      String status,
      String? notes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<PurchaseBillItem> items});
}

/// @nodoc
class __$$PurchaseBillImplCopyWithImpl<$Res>
    extends _$PurchaseBillCopyWithImpl<$Res, _$PurchaseBillImpl>
    implements _$$PurchaseBillImplCopyWith<$Res> {
  __$$PurchaseBillImplCopyWithImpl(
      _$PurchaseBillImpl _value, $Res Function(_$PurchaseBillImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseBill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? vendorId = freezed,
    Object? billNumber = null,
    Object? billDate = null,
    Object? subtotal = null,
    Object? cgstTotal = null,
    Object? sgstTotal = null,
    Object? igstTotal = null,
    Object? ugstTotal = null,
    Object? total = null,
    Object? status = null,
    Object? notes = freezed,
    Object? items = null,
  }) {
    return _then(_$PurchaseBillImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      vendorId: freezed == vendorId
          ? _value.vendorId
          : vendorId // ignore: cast_nullable_to_non_nullable
              as String?,
      billNumber: null == billNumber
          ? _value.billNumber
          : billNumber // ignore: cast_nullable_to_non_nullable
              as String,
      billDate: null == billDate
          ? _value.billDate
          : billDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as int,
      cgstTotal: null == cgstTotal
          ? _value.cgstTotal
          : cgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      sgstTotal: null == sgstTotal
          ? _value.sgstTotal
          : sgstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      igstTotal: null == igstTotal
          ? _value.igstTotal
          : igstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      ugstTotal: null == ugstTotal
          ? _value.ugstTotal
          : ugstTotal // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PurchaseBillItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseBillImpl implements _PurchaseBill {
  const _$PurchaseBillImpl(
      {required this.id,
      @JsonKey(name: 'business_id') required this.businessId,
      @JsonKey(name: 'vendor_id') this.vendorId,
      @JsonKey(name: 'bill_number') required this.billNumber,
      @JsonKey(name: 'bill_date') required this.billDate,
      this.subtotal = 0,
      @JsonKey(name: 'cgst_total') this.cgstTotal = 0,
      @JsonKey(name: 'sgst_total') this.sgstTotal = 0,
      @JsonKey(name: 'igst_total') this.igstTotal = 0,
      @JsonKey(name: 'ugst_total') this.ugstTotal = 0,
      this.total = 0,
      this.status = 'received',
      this.notes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<PurchaseBillItem> items = const []})
      : _items = items;

  factory _$PurchaseBillImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseBillImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  @JsonKey(name: 'vendor_id')
  final String? vendorId;
  @override
  @JsonKey(name: 'bill_number')
  final String billNumber;
  @override
  @JsonKey(name: 'bill_date')
  final DateTime billDate;
  @override
  @JsonKey()
  final int subtotal;
  @override
  @JsonKey(name: 'cgst_total')
  final int cgstTotal;
  @override
  @JsonKey(name: 'sgst_total')
  final int sgstTotal;
  @override
  @JsonKey(name: 'igst_total')
  final int igstTotal;
  @override
  @JsonKey(name: 'ugst_total')
  final int ugstTotal;
  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final String status;
  @override
  final String? notes;
  final List<PurchaseBillItem> _items;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<PurchaseBillItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PurchaseBill(id: $id, businessId: $businessId, vendorId: $vendorId, billNumber: $billNumber, billDate: $billDate, subtotal: $subtotal, cgstTotal: $cgstTotal, sgstTotal: $sgstTotal, igstTotal: $igstTotal, ugstTotal: $ugstTotal, total: $total, status: $status, notes: $notes, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseBillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.vendorId, vendorId) ||
                other.vendorId == vendorId) &&
            (identical(other.billNumber, billNumber) ||
                other.billNumber == billNumber) &&
            (identical(other.billDate, billDate) ||
                other.billDate == billDate) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.cgstTotal, cgstTotal) ||
                other.cgstTotal == cgstTotal) &&
            (identical(other.sgstTotal, sgstTotal) ||
                other.sgstTotal == sgstTotal) &&
            (identical(other.igstTotal, igstTotal) ||
                other.igstTotal == igstTotal) &&
            (identical(other.ugstTotal, ugstTotal) ||
                other.ugstTotal == ugstTotal) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      businessId,
      vendorId,
      billNumber,
      billDate,
      subtotal,
      cgstTotal,
      sgstTotal,
      igstTotal,
      ugstTotal,
      total,
      status,
      notes,
      const DeepCollectionEquality().hash(_items));

  /// Create a copy of PurchaseBill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseBillImplCopyWith<_$PurchaseBillImpl> get copyWith =>
      __$$PurchaseBillImplCopyWithImpl<_$PurchaseBillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseBillImplToJson(
      this,
    );
  }
}

abstract class _PurchaseBill implements PurchaseBill {
  const factory _PurchaseBill(
      {required final String id,
      @JsonKey(name: 'business_id') required final String businessId,
      @JsonKey(name: 'vendor_id') final String? vendorId,
      @JsonKey(name: 'bill_number') required final String billNumber,
      @JsonKey(name: 'bill_date') required final DateTime billDate,
      final int subtotal,
      @JsonKey(name: 'cgst_total') final int cgstTotal,
      @JsonKey(name: 'sgst_total') final int sgstTotal,
      @JsonKey(name: 'igst_total') final int igstTotal,
      @JsonKey(name: 'ugst_total') final int ugstTotal,
      final int total,
      final String status,
      final String? notes,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<PurchaseBillItem> items}) = _$PurchaseBillImpl;

  factory _PurchaseBill.fromJson(Map<String, dynamic> json) =
      _$PurchaseBillImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  @JsonKey(name: 'vendor_id')
  String? get vendorId;
  @override
  @JsonKey(name: 'bill_number')
  String get billNumber;
  @override
  @JsonKey(name: 'bill_date')
  DateTime get billDate;
  @override
  int get subtotal;
  @override
  @JsonKey(name: 'cgst_total')
  int get cgstTotal;
  @override
  @JsonKey(name: 'sgst_total')
  int get sgstTotal;
  @override
  @JsonKey(name: 'igst_total')
  int get igstTotal;
  @override
  @JsonKey(name: 'ugst_total')
  int get ugstTotal;
  @override
  int get total;
  @override
  String get status;
  @override
  String? get notes;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<PurchaseBillItem> get items;

  /// Create a copy of PurchaseBill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseBillImplCopyWith<_$PurchaseBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
