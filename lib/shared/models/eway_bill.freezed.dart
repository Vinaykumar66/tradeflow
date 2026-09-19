// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eway_bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EwayBill _$EwayBillFromJson(Map<String, dynamic> json) {
  return _EwayBill.fromJson(json);
}

/// @nodoc
mixin _$EwayBill {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_id')
  String get invoiceId => throw _privateConstructorUsedError;
  String? get ebn => throw _privateConstructorUsedError;
  @JsonKey(name: 'transporter_name')
  String? get transporterName => throw _privateConstructorUsedError;
  @JsonKey(name: 'transporter_gstin')
  String? get transporterGstin => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_number')
  String? get vehicleNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'transport_mode')
  String get transportMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance_km')
  int? get distanceKm => throw _privateConstructorUsedError;
  @JsonKey(name: 'valid_until')
  DateTime? get validUntil => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this EwayBill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EwayBill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EwayBillCopyWith<EwayBill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EwayBillCopyWith<$Res> {
  factory $EwayBillCopyWith(EwayBill value, $Res Function(EwayBill) then) =
      _$EwayBillCopyWithImpl<$Res, EwayBill>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'invoice_id') String invoiceId,
      String? ebn,
      @JsonKey(name: 'transporter_name') String? transporterName,
      @JsonKey(name: 'transporter_gstin') String? transporterGstin,
      @JsonKey(name: 'vehicle_number') String? vehicleNumber,
      @JsonKey(name: 'transport_mode') String transportMode,
      @JsonKey(name: 'distance_km') int? distanceKm,
      @JsonKey(name: 'valid_until') DateTime? validUntil,
      String status});
}

/// @nodoc
class _$EwayBillCopyWithImpl<$Res, $Val extends EwayBill>
    implements $EwayBillCopyWith<$Res> {
  _$EwayBillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EwayBill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? invoiceId = null,
    Object? ebn = freezed,
    Object? transporterName = freezed,
    Object? transporterGstin = freezed,
    Object? vehicleNumber = freezed,
    Object? transportMode = null,
    Object? distanceKm = freezed,
    Object? validUntil = freezed,
    Object? status = null,
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
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      ebn: freezed == ebn
          ? _value.ebn
          : ebn // ignore: cast_nullable_to_non_nullable
              as String?,
      transporterName: freezed == transporterName
          ? _value.transporterName
          : transporterName // ignore: cast_nullable_to_non_nullable
              as String?,
      transporterGstin: freezed == transporterGstin
          ? _value.transporterGstin
          : transporterGstin // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleNumber: freezed == vehicleNumber
          ? _value.vehicleNumber
          : vehicleNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      transportMode: null == transportMode
          ? _value.transportMode
          : transportMode // ignore: cast_nullable_to_non_nullable
              as String,
      distanceKm: freezed == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as int?,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EwayBillImplCopyWith<$Res>
    implements $EwayBillCopyWith<$Res> {
  factory _$$EwayBillImplCopyWith(
          _$EwayBillImpl value, $Res Function(_$EwayBillImpl) then) =
      __$$EwayBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'invoice_id') String invoiceId,
      String? ebn,
      @JsonKey(name: 'transporter_name') String? transporterName,
      @JsonKey(name: 'transporter_gstin') String? transporterGstin,
      @JsonKey(name: 'vehicle_number') String? vehicleNumber,
      @JsonKey(name: 'transport_mode') String transportMode,
      @JsonKey(name: 'distance_km') int? distanceKm,
      @JsonKey(name: 'valid_until') DateTime? validUntil,
      String status});
}

/// @nodoc
class __$$EwayBillImplCopyWithImpl<$Res>
    extends _$EwayBillCopyWithImpl<$Res, _$EwayBillImpl>
    implements _$$EwayBillImplCopyWith<$Res> {
  __$$EwayBillImplCopyWithImpl(
      _$EwayBillImpl _value, $Res Function(_$EwayBillImpl) _then)
      : super(_value, _then);

  /// Create a copy of EwayBill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? invoiceId = null,
    Object? ebn = freezed,
    Object? transporterName = freezed,
    Object? transporterGstin = freezed,
    Object? vehicleNumber = freezed,
    Object? transportMode = null,
    Object? distanceKm = freezed,
    Object? validUntil = freezed,
    Object? status = null,
  }) {
    return _then(_$EwayBillImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      ebn: freezed == ebn
          ? _value.ebn
          : ebn // ignore: cast_nullable_to_non_nullable
              as String?,
      transporterName: freezed == transporterName
          ? _value.transporterName
          : transporterName // ignore: cast_nullable_to_non_nullable
              as String?,
      transporterGstin: freezed == transporterGstin
          ? _value.transporterGstin
          : transporterGstin // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleNumber: freezed == vehicleNumber
          ? _value.vehicleNumber
          : vehicleNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      transportMode: null == transportMode
          ? _value.transportMode
          : transportMode // ignore: cast_nullable_to_non_nullable
              as String,
      distanceKm: freezed == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as int?,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EwayBillImpl implements _EwayBill {
  const _$EwayBillImpl(
      {required this.id,
      @JsonKey(name: 'business_id') required this.businessId,
      @JsonKey(name: 'invoice_id') required this.invoiceId,
      this.ebn,
      @JsonKey(name: 'transporter_name') this.transporterName,
      @JsonKey(name: 'transporter_gstin') this.transporterGstin,
      @JsonKey(name: 'vehicle_number') this.vehicleNumber,
      @JsonKey(name: 'transport_mode') this.transportMode = 'road',
      @JsonKey(name: 'distance_km') this.distanceKm,
      @JsonKey(name: 'valid_until') this.validUntil,
      this.status = 'not_generated'});

  factory _$EwayBillImpl.fromJson(Map<String, dynamic> json) =>
      _$$EwayBillImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  @JsonKey(name: 'invoice_id')
  final String invoiceId;
  @override
  final String? ebn;
  @override
  @JsonKey(name: 'transporter_name')
  final String? transporterName;
  @override
  @JsonKey(name: 'transporter_gstin')
  final String? transporterGstin;
  @override
  @JsonKey(name: 'vehicle_number')
  final String? vehicleNumber;
  @override
  @JsonKey(name: 'transport_mode')
  final String transportMode;
  @override
  @JsonKey(name: 'distance_km')
  final int? distanceKm;
  @override
  @JsonKey(name: 'valid_until')
  final DateTime? validUntil;
  @override
  @JsonKey()
  final String status;

  @override
  String toString() {
    return 'EwayBill(id: $id, businessId: $businessId, invoiceId: $invoiceId, ebn: $ebn, transporterName: $transporterName, transporterGstin: $transporterGstin, vehicleNumber: $vehicleNumber, transportMode: $transportMode, distanceKm: $distanceKm, validUntil: $validUntil, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EwayBillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.ebn, ebn) || other.ebn == ebn) &&
            (identical(other.transporterName, transporterName) ||
                other.transporterName == transporterName) &&
            (identical(other.transporterGstin, transporterGstin) ||
                other.transporterGstin == transporterGstin) &&
            (identical(other.vehicleNumber, vehicleNumber) ||
                other.vehicleNumber == vehicleNumber) &&
            (identical(other.transportMode, transportMode) ||
                other.transportMode == transportMode) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      businessId,
      invoiceId,
      ebn,
      transporterName,
      transporterGstin,
      vehicleNumber,
      transportMode,
      distanceKm,
      validUntil,
      status);

  /// Create a copy of EwayBill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EwayBillImplCopyWith<_$EwayBillImpl> get copyWith =>
      __$$EwayBillImplCopyWithImpl<_$EwayBillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EwayBillImplToJson(
      this,
    );
  }
}

abstract class _EwayBill implements EwayBill {
  const factory _EwayBill(
      {required final String id,
      @JsonKey(name: 'business_id') required final String businessId,
      @JsonKey(name: 'invoice_id') required final String invoiceId,
      final String? ebn,
      @JsonKey(name: 'transporter_name') final String? transporterName,
      @JsonKey(name: 'transporter_gstin') final String? transporterGstin,
      @JsonKey(name: 'vehicle_number') final String? vehicleNumber,
      @JsonKey(name: 'transport_mode') final String transportMode,
      @JsonKey(name: 'distance_km') final int? distanceKm,
      @JsonKey(name: 'valid_until') final DateTime? validUntil,
      final String status}) = _$EwayBillImpl;

  factory _EwayBill.fromJson(Map<String, dynamic> json) =
      _$EwayBillImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  @JsonKey(name: 'invoice_id')
  String get invoiceId;
  @override
  String? get ebn;
  @override
  @JsonKey(name: 'transporter_name')
  String? get transporterName;
  @override
  @JsonKey(name: 'transporter_gstin')
  String? get transporterGstin;
  @override
  @JsonKey(name: 'vehicle_number')
  String? get vehicleNumber;
  @override
  @JsonKey(name: 'transport_mode')
  String get transportMode;
  @override
  @JsonKey(name: 'distance_km')
  int? get distanceKm;
  @override
  @JsonKey(name: 'valid_until')
  DateTime? get validUntil;
  @override
  String get status;

  /// Create a copy of EwayBill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EwayBillImplCopyWith<_$EwayBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
