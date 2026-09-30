// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VendorPayment _$VendorPaymentFromJson(Map<String, dynamic> json) {
  return _VendorPayment.fromJson(json);
}

/// @nodoc
mixin _$VendorPayment {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_id')
  String get vendorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_bill_id')
  String? get purchaseBillId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_at')
  DateTime? get paidAt => throw _privateConstructorUsedError;

  /// Serializes this VendorPayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VendorPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VendorPaymentCopyWith<VendorPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VendorPaymentCopyWith<$Res> {
  factory $VendorPaymentCopyWith(
          VendorPayment value, $Res Function(VendorPayment) then) =
      _$VendorPaymentCopyWithImpl<$Res, VendorPayment>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'vendor_id') String vendorId,
      @JsonKey(name: 'purchase_bill_id') String? purchaseBillId,
      int amount,
      String method,
      String? reference,
      @JsonKey(name: 'paid_at') DateTime? paidAt});
}

/// @nodoc
class _$VendorPaymentCopyWithImpl<$Res, $Val extends VendorPayment>
    implements $VendorPaymentCopyWith<$Res> {
  _$VendorPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VendorPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? vendorId = null,
    Object? purchaseBillId = freezed,
    Object? amount = null,
    Object? method = null,
    Object? reference = freezed,
    Object? paidAt = freezed,
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
      vendorId: null == vendorId
          ? _value.vendorId
          : vendorId // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseBillId: freezed == purchaseBillId
          ? _value.purchaseBillId
          : purchaseBillId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VendorPaymentImplCopyWith<$Res>
    implements $VendorPaymentCopyWith<$Res> {
  factory _$$VendorPaymentImplCopyWith(
          _$VendorPaymentImpl value, $Res Function(_$VendorPaymentImpl) then) =
      __$$VendorPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'vendor_id') String vendorId,
      @JsonKey(name: 'purchase_bill_id') String? purchaseBillId,
      int amount,
      String method,
      String? reference,
      @JsonKey(name: 'paid_at') DateTime? paidAt});
}

/// @nodoc
class __$$VendorPaymentImplCopyWithImpl<$Res>
    extends _$VendorPaymentCopyWithImpl<$Res, _$VendorPaymentImpl>
    implements _$$VendorPaymentImplCopyWith<$Res> {
  __$$VendorPaymentImplCopyWithImpl(
      _$VendorPaymentImpl _value, $Res Function(_$VendorPaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of VendorPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? vendorId = null,
    Object? purchaseBillId = freezed,
    Object? amount = null,
    Object? method = null,
    Object? reference = freezed,
    Object? paidAt = freezed,
  }) {
    return _then(_$VendorPaymentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      vendorId: null == vendorId
          ? _value.vendorId
          : vendorId // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseBillId: freezed == purchaseBillId
          ? _value.purchaseBillId
          : purchaseBillId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VendorPaymentImpl implements _VendorPayment {
  const _$VendorPaymentImpl(
      {required this.id,
      @JsonKey(name: 'business_id') required this.businessId,
      @JsonKey(name: 'vendor_id') required this.vendorId,
      @JsonKey(name: 'purchase_bill_id') this.purchaseBillId,
      required this.amount,
      this.method = 'cash',
      this.reference,
      @JsonKey(name: 'paid_at') this.paidAt});

  factory _$VendorPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$VendorPaymentImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  @JsonKey(name: 'vendor_id')
  final String vendorId;
  @override
  @JsonKey(name: 'purchase_bill_id')
  final String? purchaseBillId;
  @override
  final int amount;
  @override
  @JsonKey()
  final String method;
  @override
  final String? reference;
  @override
  @JsonKey(name: 'paid_at')
  final DateTime? paidAt;

  @override
  String toString() {
    return 'VendorPayment(id: $id, businessId: $businessId, vendorId: $vendorId, purchaseBillId: $purchaseBillId, amount: $amount, method: $method, reference: $reference, paidAt: $paidAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VendorPaymentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.vendorId, vendorId) ||
                other.vendorId == vendorId) &&
            (identical(other.purchaseBillId, purchaseBillId) ||
                other.purchaseBillId == purchaseBillId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, businessId, vendorId,
      purchaseBillId, amount, method, reference, paidAt);

  /// Create a copy of VendorPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VendorPaymentImplCopyWith<_$VendorPaymentImpl> get copyWith =>
      __$$VendorPaymentImplCopyWithImpl<_$VendorPaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VendorPaymentImplToJson(
      this,
    );
  }
}

abstract class _VendorPayment implements VendorPayment {
  const factory _VendorPayment(
      {required final String id,
      @JsonKey(name: 'business_id') required final String businessId,
      @JsonKey(name: 'vendor_id') required final String vendorId,
      @JsonKey(name: 'purchase_bill_id') final String? purchaseBillId,
      required final int amount,
      final String method,
      final String? reference,
      @JsonKey(name: 'paid_at') final DateTime? paidAt}) = _$VendorPaymentImpl;

  factory _VendorPayment.fromJson(Map<String, dynamic> json) =
      _$VendorPaymentImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  @JsonKey(name: 'vendor_id')
  String get vendorId;
  @override
  @JsonKey(name: 'purchase_bill_id')
  String? get purchaseBillId;
  @override
  int get amount;
  @override
  String get method;
  @override
  String? get reference;
  @override
  @JsonKey(name: 'paid_at')
  DateTime? get paidAt;

  /// Create a copy of VendorPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VendorPaymentImplCopyWith<_$VendorPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
