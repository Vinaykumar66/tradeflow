// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rolePermissionsHash() => r'f134a3a6ff443d26b52e284af3b724e76ce480a5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [rolePermissions].
@ProviderFor(rolePermissions)
const rolePermissionsProvider = RolePermissionsFamily();

/// See also [rolePermissions].
class RolePermissionsFamily extends Family<AsyncValue<RolePermissionSet?>> {
  /// See also [rolePermissions].
  const RolePermissionsFamily();

  /// See also [rolePermissions].
  RolePermissionsProvider call(
    String businessId,
    String roleValue,
  ) {
    return RolePermissionsProvider(
      businessId,
      roleValue,
    );
  }

  @override
  RolePermissionsProvider getProviderOverride(
    covariant RolePermissionsProvider provider,
  ) {
    return call(
      provider.businessId,
      provider.roleValue,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'rolePermissionsProvider';
}

/// See also [rolePermissions].
class RolePermissionsProvider
    extends AutoDisposeStreamProvider<RolePermissionSet?> {
  /// See also [rolePermissions].
  RolePermissionsProvider(
    String businessId,
    String roleValue,
  ) : this._internal(
          (ref) => rolePermissions(
            ref as RolePermissionsRef,
            businessId,
            roleValue,
          ),
          from: rolePermissionsProvider,
          name: r'rolePermissionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$rolePermissionsHash,
          dependencies: RolePermissionsFamily._dependencies,
          allTransitiveDependencies:
              RolePermissionsFamily._allTransitiveDependencies,
          businessId: businessId,
          roleValue: roleValue,
        );

  RolePermissionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.businessId,
    required this.roleValue,
  }) : super.internal();

  final String businessId;
  final String roleValue;

  @override
  Override overrideWith(
    Stream<RolePermissionSet?> Function(RolePermissionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RolePermissionsProvider._internal(
        (ref) => create(ref as RolePermissionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        businessId: businessId,
        roleValue: roleValue,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<RolePermissionSet?> createElement() {
    return _RolePermissionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RolePermissionsProvider &&
        other.businessId == businessId &&
        other.roleValue == roleValue;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, businessId.hashCode);
    hash = _SystemHash.combine(hash, roleValue.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RolePermissionsRef on AutoDisposeStreamProviderRef<RolePermissionSet?> {
  /// The parameter `businessId` of this provider.
  String get businessId;

  /// The parameter `roleValue` of this provider.
  String get roleValue;
}

class _RolePermissionsProviderElement
    extends AutoDisposeStreamProviderElement<RolePermissionSet?>
    with RolePermissionsRef {
  _RolePermissionsProviderElement(super.provider);

  @override
  String get businessId => (origin as RolePermissionsProvider).businessId;
  @override
  String get roleValue => (origin as RolePermissionsProvider).roleValue;
}

String _$currentRolePermissionsHash() =>
    r'99fe5884b6f15c844a585a4ed130d0262be98dc7';

/// See also [currentRolePermissions].
@ProviderFor(currentRolePermissions)
final currentRolePermissionsProvider =
    AutoDisposeStreamProvider<RolePermissionSet?>.internal(
  currentRolePermissions,
  name: r'currentRolePermissionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentRolePermissionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentRolePermissionsRef
    = AutoDisposeStreamProviderRef<RolePermissionSet?>;
String _$hasScreenPermissionHash() =>
    r'c131262610ec6bdce0da2d64db4b089611f9d7e8';

/// See also [hasScreenPermission].
@ProviderFor(hasScreenPermission)
const hasScreenPermissionProvider = HasScreenPermissionFamily();

/// See also [hasScreenPermission].
class HasScreenPermissionFamily extends Family<bool> {
  /// See also [hasScreenPermission].
  const HasScreenPermissionFamily();

  /// See also [hasScreenPermission].
  HasScreenPermissionProvider call(
    String screenKey,
    PermissionAction action,
  ) {
    return HasScreenPermissionProvider(
      screenKey,
      action,
    );
  }

  @override
  HasScreenPermissionProvider getProviderOverride(
    covariant HasScreenPermissionProvider provider,
  ) {
    return call(
      provider.screenKey,
      provider.action,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hasScreenPermissionProvider';
}

/// See also [hasScreenPermission].
class HasScreenPermissionProvider extends AutoDisposeProvider<bool> {
  /// See also [hasScreenPermission].
  HasScreenPermissionProvider(
    String screenKey,
    PermissionAction action,
  ) : this._internal(
          (ref) => hasScreenPermission(
            ref as HasScreenPermissionRef,
            screenKey,
            action,
          ),
          from: hasScreenPermissionProvider,
          name: r'hasScreenPermissionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hasScreenPermissionHash,
          dependencies: HasScreenPermissionFamily._dependencies,
          allTransitiveDependencies:
              HasScreenPermissionFamily._allTransitiveDependencies,
          screenKey: screenKey,
          action: action,
        );

  HasScreenPermissionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.screenKey,
    required this.action,
  }) : super.internal();

  final String screenKey;
  final PermissionAction action;

  @override
  Override overrideWith(
    bool Function(HasScreenPermissionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HasScreenPermissionProvider._internal(
        (ref) => create(ref as HasScreenPermissionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        screenKey: screenKey,
        action: action,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _HasScreenPermissionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HasScreenPermissionProvider &&
        other.screenKey == screenKey &&
        other.action == action;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenKey.hashCode);
    hash = _SystemHash.combine(hash, action.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HasScreenPermissionRef on AutoDisposeProviderRef<bool> {
  /// The parameter `screenKey` of this provider.
  String get screenKey;

  /// The parameter `action` of this provider.
  PermissionAction get action;
}

class _HasScreenPermissionProviderElement
    extends AutoDisposeProviderElement<bool> with HasScreenPermissionRef {
  _HasScreenPermissionProviderElement(super.provider);

  @override
  String get screenKey => (origin as HasScreenPermissionProvider).screenKey;
  @override
  PermissionAction get action => (origin as HasScreenPermissionProvider).action;
}

String _$canViewFieldHash() => r'ce326c8e23dd95cbcd4942cd9b2b1251a329c43f';

/// See also [canViewField].
@ProviderFor(canViewField)
const canViewFieldProvider = CanViewFieldFamily();

/// See also [canViewField].
class CanViewFieldFamily extends Family<bool> {
  /// See also [canViewField].
  const CanViewFieldFamily();

  /// See also [canViewField].
  CanViewFieldProvider call(
    String fieldKey,
  ) {
    return CanViewFieldProvider(
      fieldKey,
    );
  }

  @override
  CanViewFieldProvider getProviderOverride(
    covariant CanViewFieldProvider provider,
  ) {
    return call(
      provider.fieldKey,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'canViewFieldProvider';
}

/// See also [canViewField].
class CanViewFieldProvider extends AutoDisposeProvider<bool> {
  /// See also [canViewField].
  CanViewFieldProvider(
    String fieldKey,
  ) : this._internal(
          (ref) => canViewField(
            ref as CanViewFieldRef,
            fieldKey,
          ),
          from: canViewFieldProvider,
          name: r'canViewFieldProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$canViewFieldHash,
          dependencies: CanViewFieldFamily._dependencies,
          allTransitiveDependencies:
              CanViewFieldFamily._allTransitiveDependencies,
          fieldKey: fieldKey,
        );

  CanViewFieldProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fieldKey,
  }) : super.internal();

  final String fieldKey;

  @override
  Override overrideWith(
    bool Function(CanViewFieldRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CanViewFieldProvider._internal(
        (ref) => create(ref as CanViewFieldRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fieldKey: fieldKey,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _CanViewFieldProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CanViewFieldProvider && other.fieldKey == fieldKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fieldKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CanViewFieldRef on AutoDisposeProviderRef<bool> {
  /// The parameter `fieldKey` of this provider.
  String get fieldKey;
}

class _CanViewFieldProviderElement extends AutoDisposeProviderElement<bool>
    with CanViewFieldRef {
  _CanViewFieldProviderElement(super.provider);

  @override
  String get fieldKey => (origin as CanViewFieldProvider).fieldKey;
}

String _$canEditFieldHash() => r'010138839043e477613738fc548a4d54829c0161';

/// See also [canEditField].
@ProviderFor(canEditField)
const canEditFieldProvider = CanEditFieldFamily();

/// See also [canEditField].
class CanEditFieldFamily extends Family<bool> {
  /// See also [canEditField].
  const CanEditFieldFamily();

  /// See also [canEditField].
  CanEditFieldProvider call(
    String fieldKey,
  ) {
    return CanEditFieldProvider(
      fieldKey,
    );
  }

  @override
  CanEditFieldProvider getProviderOverride(
    covariant CanEditFieldProvider provider,
  ) {
    return call(
      provider.fieldKey,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'canEditFieldProvider';
}

/// See also [canEditField].
class CanEditFieldProvider extends AutoDisposeProvider<bool> {
  /// See also [canEditField].
  CanEditFieldProvider(
    String fieldKey,
  ) : this._internal(
          (ref) => canEditField(
            ref as CanEditFieldRef,
            fieldKey,
          ),
          from: canEditFieldProvider,
          name: r'canEditFieldProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$canEditFieldHash,
          dependencies: CanEditFieldFamily._dependencies,
          allTransitiveDependencies:
              CanEditFieldFamily._allTransitiveDependencies,
          fieldKey: fieldKey,
        );

  CanEditFieldProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fieldKey,
  }) : super.internal();

  final String fieldKey;

  @override
  Override overrideWith(
    bool Function(CanEditFieldRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CanEditFieldProvider._internal(
        (ref) => create(ref as CanEditFieldRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fieldKey: fieldKey,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _CanEditFieldProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CanEditFieldProvider && other.fieldKey == fieldKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fieldKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CanEditFieldRef on AutoDisposeProviderRef<bool> {
  /// The parameter `fieldKey` of this provider.
  String get fieldKey;
}

class _CanEditFieldProviderElement extends AutoDisposeProviderElement<bool>
    with CanEditFieldRef {
  _CanEditFieldProviderElement(super.provider);

  @override
  String get fieldKey => (origin as CanEditFieldProvider).fieldKey;
}

String _$savePermissionsNotifierHash() =>
    r'df87e061b51e9d20e9dc8ad12294b5533958f7fd';

/// See also [SavePermissionsNotifier].
@ProviderFor(SavePermissionsNotifier)
final savePermissionsNotifierProvider = AutoDisposeNotifierProvider<
    SavePermissionsNotifier, AsyncValue<void>>.internal(
  SavePermissionsNotifier.new,
  name: r'savePermissionsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$savePermissionsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SavePermissionsNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
