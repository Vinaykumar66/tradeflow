// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get gstin =>
      throw _privateConstructorUsedError; // Credit limit in paise - e.g. 10,000 = 1000000 (currency fetched from businesses.currency_symbol)
  @JsonKey(name: 'credit_limit')
  int get creditLimit =>
      throw _privateConstructorUsedError; // Outstanding balance in paise - auto-updated by SQL trigger
  @JsonKey(name: 'outstanding')
  int get outstanding =>
      throw _privateConstructorUsedError; // Payment terms in days - 0 = cash on delivery
  @JsonKey(name: 'payment_terms')
  int get paymentTerms => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Customer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res, Customer>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      String name,
      String? email,
      String? phone,
      String? address,
      String? city,
      String? state,
      String? gstin,
      @JsonKey(name: 'credit_limit') int creditLimit,
      @JsonKey(name: 'outstanding') int outstanding,
      @JsonKey(name: 'payment_terms') int paymentTerms,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res, $Val extends Customer>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? name = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? gstin = freezed,
    Object? creditLimit = null,
    Object? outstanding = null,
    Object? paymentTerms = null,
    Object? isActive = null,
    Object? createdAt = null,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      gstin: freezed == gstin
          ? _value.gstin
          : gstin // ignore: cast_nullable_to_non_nullable
              as String?,
      creditLimit: null == creditLimit
          ? _value.creditLimit
          : creditLimit // ignore: cast_nullable_to_non_nullable
              as int,
      outstanding: null == outstanding
          ? _value.outstanding
          : outstanding // ignore: cast_nullable_to_non_nullable
              as int,
      paymentTerms: null == paymentTerms
          ? _value.paymentTerms
          : paymentTerms // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerImplCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$$CustomerImplCopyWith(
          _$CustomerImpl value, $Res Function(_$CustomerImpl) then) =
      __$$CustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      String name,
      String? email,
      String? phone,
      String? address,
      String? city,
      String? state,
      String? gstin,
      @JsonKey(name: 'credit_limit') int creditLimit,
      @JsonKey(name: 'outstanding') int outstanding,
      @JsonKey(name: 'payment_terms') int paymentTerms,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$CustomerImplCopyWithImpl<$Res>
    extends _$CustomerCopyWithImpl<$Res, _$CustomerImpl>
    implements _$$CustomerImplCopyWith<$Res> {
  __$$CustomerImplCopyWithImpl(
      _$CustomerImpl _value, $Res Function(_$CustomerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? name = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? gstin = freezed,
    Object? creditLimit = null,
    Object? outstanding = null,
    Object? paymentTerms = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_$CustomerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      gstin: freezed == gstin
          ? _value.gstin
          : gstin // ignore: cast_nullable_to_non_nullable
              as String?,
      creditLimit: null == creditLimit
          ? _value.creditLimit
          : creditLimit // ignore: cast_nullable_to_non_nullable
              as int,
      outstanding: null == outstanding
          ? _value.outstanding
          : outstanding // ignore: cast_nullable_to_non_nullable
              as int,
      paymentTerms: null == paymentTerms
          ? _value.paymentTerms
          : paymentTerms // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerImpl implements _Customer {
  const _$CustomerImpl(
      {required this.id,
      @JsonKey(name: 'business_id') required this.businessId,
      required this.name,
      this.email,
      this.phone,
      this.address,
      this.city,
      this.state,
      this.gstin,
      @JsonKey(name: 'credit_limit') this.creditLimit = 0,
      @JsonKey(name: 'outstanding') this.outstanding = 0,
      @JsonKey(name: 'payment_terms') this.paymentTerms = 0,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$CustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  final String name;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? gstin;
// Credit limit in paise - e.g. 10,000 = 1000000 (currency fetched from businesses.currency_symbol)
  @override
  @JsonKey(name: 'credit_limit')
  final int creditLimit;
// Outstanding balance in paise - auto-updated by SQL trigger
  @override
  @JsonKey(name: 'outstanding')
  final int outstanding;
// Payment terms in days - 0 = cash on delivery
  @override
  @JsonKey(name: 'payment_terms')
  final int paymentTerms;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'Customer(id: $id, businessId: $businessId, name: $name, email: $email, phone: $phone, address: $address, city: $city, state: $state, gstin: $gstin, creditLimit: $creditLimit, outstanding: $outstanding, paymentTerms: $paymentTerms, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.gstin, gstin) || other.gstin == gstin) &&
            (identical(other.creditLimit, creditLimit) ||
                other.creditLimit == creditLimit) &&
            (identical(other.outstanding, outstanding) ||
                other.outstanding == outstanding) &&
            (identical(other.paymentTerms, paymentTerms) ||
                other.paymentTerms == paymentTerms) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      businessId,
      name,
      email,
      phone,
      address,
      city,
      state,
      gstin,
      creditLimit,
      outstanding,
      paymentTerms,
      isActive,
      createdAt);

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      __$$CustomerImplCopyWithImpl<_$CustomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerImplToJson(
      this,
    );
  }
}

abstract class _Customer implements Customer {
  const factory _Customer(
          {required final String id,
          @JsonKey(name: 'business_id') required final String businessId,
          required final String name,
          final String? email,
          final String? phone,
          final String? address,
          final String? city,
          final String? state,
          final String? gstin,
          @JsonKey(name: 'credit_limit') final int creditLimit,
          @JsonKey(name: 'outstanding') final int outstanding,
          @JsonKey(name: 'payment_terms') final int paymentTerms,
          @JsonKey(name: 'is_active') final bool isActive,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$CustomerImpl;

  factory _Customer.fromJson(Map<String, dynamic> json) =
      _$CustomerImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  String get name;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get address;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String?
      get gstin; // Credit limit in paise - e.g. 10,000 = 1000000 (currency fetched from businesses.currency_symbol)
  @override
  @JsonKey(name: 'credit_limit')
  int get creditLimit; // Outstanding balance in paise - auto-updated by SQL trigger
  @override
  @JsonKey(name: 'outstanding')
  int get outstanding; // Payment terms in days - 0 = cash on delivery
  @override
  @JsonKey(name: 'payment_terms')
  int get paymentTerms;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
