// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScreenPermission _$ScreenPermissionFromJson(Map<String, dynamic> json) {
  return _ScreenPermission.fromJson(json);
}

/// @nodoc
mixin _$ScreenPermission {
  String get screenKey => throw _privateConstructorUsedError;
  bool get canView => throw _privateConstructorUsedError;
  bool get canCreate => throw _privateConstructorUsedError;
  bool get canEdit => throw _privateConstructorUsedError;
  bool get canDelete => throw _privateConstructorUsedError;

  /// Serializes this ScreenPermission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScreenPermission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScreenPermissionCopyWith<ScreenPermission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenPermissionCopyWith<$Res> {
  factory $ScreenPermissionCopyWith(
          ScreenPermission value, $Res Function(ScreenPermission) then) =
      _$ScreenPermissionCopyWithImpl<$Res, ScreenPermission>;
  @useResult
  $Res call(
      {String screenKey,
      bool canView,
      bool canCreate,
      bool canEdit,
      bool canDelete});
}

/// @nodoc
class _$ScreenPermissionCopyWithImpl<$Res, $Val extends ScreenPermission>
    implements $ScreenPermissionCopyWith<$Res> {
  _$ScreenPermissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScreenPermission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screenKey = null,
    Object? canView = null,
    Object? canCreate = null,
    Object? canEdit = null,
    Object? canDelete = null,
  }) {
    return _then(_value.copyWith(
      screenKey: null == screenKey
          ? _value.screenKey
          : screenKey // ignore: cast_nullable_to_non_nullable
              as String,
      canView: null == canView
          ? _value.canView
          : canView // ignore: cast_nullable_to_non_nullable
              as bool,
      canCreate: null == canCreate
          ? _value.canCreate
          : canCreate // ignore: cast_nullable_to_non_nullable
              as bool,
      canEdit: null == canEdit
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      canDelete: null == canDelete
          ? _value.canDelete
          : canDelete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScreenPermissionImplCopyWith<$Res>
    implements $ScreenPermissionCopyWith<$Res> {
  factory _$$ScreenPermissionImplCopyWith(_$ScreenPermissionImpl value,
          $Res Function(_$ScreenPermissionImpl) then) =
      __$$ScreenPermissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String screenKey,
      bool canView,
      bool canCreate,
      bool canEdit,
      bool canDelete});
}

/// @nodoc
class __$$ScreenPermissionImplCopyWithImpl<$Res>
    extends _$ScreenPermissionCopyWithImpl<$Res, _$ScreenPermissionImpl>
    implements _$$ScreenPermissionImplCopyWith<$Res> {
  __$$ScreenPermissionImplCopyWithImpl(_$ScreenPermissionImpl _value,
      $Res Function(_$ScreenPermissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScreenPermission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screenKey = null,
    Object? canView = null,
    Object? canCreate = null,
    Object? canEdit = null,
    Object? canDelete = null,
  }) {
    return _then(_$ScreenPermissionImpl(
      screenKey: null == screenKey
          ? _value.screenKey
          : screenKey // ignore: cast_nullable_to_non_nullable
              as String,
      canView: null == canView
          ? _value.canView
          : canView // ignore: cast_nullable_to_non_nullable
              as bool,
      canCreate: null == canCreate
          ? _value.canCreate
          : canCreate // ignore: cast_nullable_to_non_nullable
              as bool,
      canEdit: null == canEdit
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      canDelete: null == canDelete
          ? _value.canDelete
          : canDelete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScreenPermissionImpl implements _ScreenPermission {
  const _$ScreenPermissionImpl(
      {required this.screenKey,
      this.canView = true,
      this.canCreate = false,
      this.canEdit = false,
      this.canDelete = false});

  factory _$ScreenPermissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScreenPermissionImplFromJson(json);

  @override
  final String screenKey;
  @override
  @JsonKey()
  final bool canView;
  @override
  @JsonKey()
  final bool canCreate;
  @override
  @JsonKey()
  final bool canEdit;
  @override
  @JsonKey()
  final bool canDelete;

  @override
  String toString() {
    return 'ScreenPermission(screenKey: $screenKey, canView: $canView, canCreate: $canCreate, canEdit: $canEdit, canDelete: $canDelete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScreenPermissionImpl &&
            (identical(other.screenKey, screenKey) ||
                other.screenKey == screenKey) &&
            (identical(other.canView, canView) || other.canView == canView) &&
            (identical(other.canCreate, canCreate) ||
                other.canCreate == canCreate) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit) &&
            (identical(other.canDelete, canDelete) ||
                other.canDelete == canDelete));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, screenKey, canView, canCreate, canEdit, canDelete);

  /// Create a copy of ScreenPermission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScreenPermissionImplCopyWith<_$ScreenPermissionImpl> get copyWith =>
      __$$ScreenPermissionImplCopyWithImpl<_$ScreenPermissionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScreenPermissionImplToJson(
      this,
    );
  }
}

abstract class _ScreenPermission implements ScreenPermission {
  const factory _ScreenPermission(
      {required final String screenKey,
      final bool canView,
      final bool canCreate,
      final bool canEdit,
      final bool canDelete}) = _$ScreenPermissionImpl;

  factory _ScreenPermission.fromJson(Map<String, dynamic> json) =
      _$ScreenPermissionImpl.fromJson;

  @override
  String get screenKey;
  @override
  bool get canView;
  @override
  bool get canCreate;
  @override
  bool get canEdit;
  @override
  bool get canDelete;

  /// Create a copy of ScreenPermission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScreenPermissionImplCopyWith<_$ScreenPermissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FieldPermission _$FieldPermissionFromJson(Map<String, dynamic> json) {
  return _FieldPermission.fromJson(json);
}

/// @nodoc
mixin _$FieldPermission {
  String get fieldKey =>
      throw _privateConstructorUsedError; // matches AppFieldKeys constant
  bool get canView =>
      throw _privateConstructorUsedError; // false = field hidden from this role
  bool get canEdit => throw _privateConstructorUsedError;

  /// Serializes this FieldPermission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FieldPermission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FieldPermissionCopyWith<FieldPermission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldPermissionCopyWith<$Res> {
  factory $FieldPermissionCopyWith(
          FieldPermission value, $Res Function(FieldPermission) then) =
      _$FieldPermissionCopyWithImpl<$Res, FieldPermission>;
  @useResult
  $Res call({String fieldKey, bool canView, bool canEdit});
}

/// @nodoc
class _$FieldPermissionCopyWithImpl<$Res, $Val extends FieldPermission>
    implements $FieldPermissionCopyWith<$Res> {
  _$FieldPermissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FieldPermission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldKey = null,
    Object? canView = null,
    Object? canEdit = null,
  }) {
    return _then(_value.copyWith(
      fieldKey: null == fieldKey
          ? _value.fieldKey
          : fieldKey // ignore: cast_nullable_to_non_nullable
              as String,
      canView: null == canView
          ? _value.canView
          : canView // ignore: cast_nullable_to_non_nullable
              as bool,
      canEdit: null == canEdit
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldPermissionImplCopyWith<$Res>
    implements $FieldPermissionCopyWith<$Res> {
  factory _$$FieldPermissionImplCopyWith(_$FieldPermissionImpl value,
          $Res Function(_$FieldPermissionImpl) then) =
      __$$FieldPermissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fieldKey, bool canView, bool canEdit});
}

/// @nodoc
class __$$FieldPermissionImplCopyWithImpl<$Res>
    extends _$FieldPermissionCopyWithImpl<$Res, _$FieldPermissionImpl>
    implements _$$FieldPermissionImplCopyWith<$Res> {
  __$$FieldPermissionImplCopyWithImpl(
      _$FieldPermissionImpl _value, $Res Function(_$FieldPermissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of FieldPermission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldKey = null,
    Object? canView = null,
    Object? canEdit = null,
  }) {
    return _then(_$FieldPermissionImpl(
      fieldKey: null == fieldKey
          ? _value.fieldKey
          : fieldKey // ignore: cast_nullable_to_non_nullable
              as String,
      canView: null == canView
          ? _value.canView
          : canView // ignore: cast_nullable_to_non_nullable
              as bool,
      canEdit: null == canEdit
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldPermissionImpl implements _FieldPermission {
  const _$FieldPermissionImpl(
      {required this.fieldKey, this.canView = true, this.canEdit = true});

  factory _$FieldPermissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldPermissionImplFromJson(json);

  @override
  final String fieldKey;
// matches AppFieldKeys constant
  @override
  @JsonKey()
  final bool canView;
// false = field hidden from this role
  @override
  @JsonKey()
  final bool canEdit;

  @override
  String toString() {
    return 'FieldPermission(fieldKey: $fieldKey, canView: $canView, canEdit: $canEdit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldPermissionImpl &&
            (identical(other.fieldKey, fieldKey) ||
                other.fieldKey == fieldKey) &&
            (identical(other.canView, canView) || other.canView == canView) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fieldKey, canView, canEdit);

  /// Create a copy of FieldPermission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldPermissionImplCopyWith<_$FieldPermissionImpl> get copyWith =>
      __$$FieldPermissionImplCopyWithImpl<_$FieldPermissionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldPermissionImplToJson(
      this,
    );
  }
}

abstract class _FieldPermission implements FieldPermission {
  const factory _FieldPermission(
      {required final String fieldKey,
      final bool canView,
      final bool canEdit}) = _$FieldPermissionImpl;

  factory _FieldPermission.fromJson(Map<String, dynamic> json) =
      _$FieldPermissionImpl.fromJson;

  @override
  String get fieldKey; // matches AppFieldKeys constant
  @override
  bool get canView; // false = field hidden from this role
  @override
  bool get canEdit;

  /// Create a copy of FieldPermission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FieldPermissionImplCopyWith<_$FieldPermissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RolePermissionSet _$RolePermissionSetFromJson(Map<String, dynamic> json) {
  return _RolePermissionSet.fromJson(json);
}

/// @nodoc
mixin _$RolePermissionSet {
  String get businessId => throw _privateConstructorUsedError;
  String get roleValue =>
      throw _privateConstructorUsedError; // 'admin', 'salesperson', 'accountant'
  List<ScreenPermission> get screens => throw _privateConstructorUsedError;
  List<FieldPermission> get fields => throw _privateConstructorUsedError;

  /// Serializes this RolePermissionSet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RolePermissionSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RolePermissionSetCopyWith<RolePermissionSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RolePermissionSetCopyWith<$Res> {
  factory $RolePermissionSetCopyWith(
          RolePermissionSet value, $Res Function(RolePermissionSet) then) =
      _$RolePermissionSetCopyWithImpl<$Res, RolePermissionSet>;
  @useResult
  $Res call(
      {String businessId,
      String roleValue,
      List<ScreenPermission> screens,
      List<FieldPermission> fields});
}

/// @nodoc
class _$RolePermissionSetCopyWithImpl<$Res, $Val extends RolePermissionSet>
    implements $RolePermissionSetCopyWith<$Res> {
  _$RolePermissionSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RolePermissionSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? businessId = null,
    Object? roleValue = null,
    Object? screens = null,
    Object? fields = null,
  }) {
    return _then(_value.copyWith(
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      roleValue: null == roleValue
          ? _value.roleValue
          : roleValue // ignore: cast_nullable_to_non_nullable
              as String,
      screens: null == screens
          ? _value.screens
          : screens // ignore: cast_nullable_to_non_nullable
              as List<ScreenPermission>,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<FieldPermission>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RolePermissionSetImplCopyWith<$Res>
    implements $RolePermissionSetCopyWith<$Res> {
  factory _$$RolePermissionSetImplCopyWith(_$RolePermissionSetImpl value,
          $Res Function(_$RolePermissionSetImpl) then) =
      __$$RolePermissionSetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String businessId,
      String roleValue,
      List<ScreenPermission> screens,
      List<FieldPermission> fields});
}

/// @nodoc
class __$$RolePermissionSetImplCopyWithImpl<$Res>
    extends _$RolePermissionSetCopyWithImpl<$Res, _$RolePermissionSetImpl>
    implements _$$RolePermissionSetImplCopyWith<$Res> {
  __$$RolePermissionSetImplCopyWithImpl(_$RolePermissionSetImpl _value,
      $Res Function(_$RolePermissionSetImpl) _then)
      : super(_value, _then);

  /// Create a copy of RolePermissionSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? businessId = null,
    Object? roleValue = null,
    Object? screens = null,
    Object? fields = null,
  }) {
    return _then(_$RolePermissionSetImpl(
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      roleValue: null == roleValue
          ? _value.roleValue
          : roleValue // ignore: cast_nullable_to_non_nullable
              as String,
      screens: null == screens
          ? _value._screens
          : screens // ignore: cast_nullable_to_non_nullable
              as List<ScreenPermission>,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<FieldPermission>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RolePermissionSetImpl implements _RolePermissionSet {
  const _$RolePermissionSetImpl(
      {required this.businessId,
      required this.roleValue,
      final List<ScreenPermission> screens = const [],
      final List<FieldPermission> fields = const []})
      : _screens = screens,
        _fields = fields;

  factory _$RolePermissionSetImpl.fromJson(Map<String, dynamic> json) =>
      _$$RolePermissionSetImplFromJson(json);

  @override
  final String businessId;
  @override
  final String roleValue;
// 'admin', 'salesperson', 'accountant'
  final List<ScreenPermission> _screens;
// 'admin', 'salesperson', 'accountant'
  @override
  @JsonKey()
  List<ScreenPermission> get screens {
    if (_screens is EqualUnmodifiableListView) return _screens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_screens);
  }

  final List<FieldPermission> _fields;
  @override
  @JsonKey()
  List<FieldPermission> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  String toString() {
    return 'RolePermissionSet(businessId: $businessId, roleValue: $roleValue, screens: $screens, fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RolePermissionSetImpl &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.roleValue, roleValue) ||
                other.roleValue == roleValue) &&
            const DeepCollectionEquality().equals(other._screens, _screens) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      businessId,
      roleValue,
      const DeepCollectionEquality().hash(_screens),
      const DeepCollectionEquality().hash(_fields));

  /// Create a copy of RolePermissionSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RolePermissionSetImplCopyWith<_$RolePermissionSetImpl> get copyWith =>
      __$$RolePermissionSetImplCopyWithImpl<_$RolePermissionSetImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RolePermissionSetImplToJson(
      this,
    );
  }
}

abstract class _RolePermissionSet implements RolePermissionSet {
  const factory _RolePermissionSet(
      {required final String businessId,
      required final String roleValue,
      final List<ScreenPermission> screens,
      final List<FieldPermission> fields}) = _$RolePermissionSetImpl;

  factory _RolePermissionSet.fromJson(Map<String, dynamic> json) =
      _$RolePermissionSetImpl.fromJson;

  @override
  String get businessId;
  @override
  String get roleValue; // 'admin', 'salesperson', 'accountant'
  @override
  List<ScreenPermission> get screens;
  @override
  List<FieldPermission> get fields;

  /// Create a copy of RolePermissionSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RolePermissionSetImplCopyWith<_$RolePermissionSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
