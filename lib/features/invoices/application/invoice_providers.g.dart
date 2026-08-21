// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$invoiceListHash() => r'2138c6b9b9e53ccefa65a46573e4eaf48bd5a3e4';

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

/// See also [invoiceList].
@ProviderFor(invoiceList)
const invoiceListProvider = InvoiceListFamily();

/// See also [invoiceList].
class InvoiceListFamily extends Family<AsyncValue<List<Invoice>>> {
  /// See also [invoiceList].
  const InvoiceListFamily();

  /// See also [invoiceList].
  InvoiceListProvider call({
    String? status,
  }) {
    return InvoiceListProvider(
      status: status,
    );
  }

  @override
  InvoiceListProvider getProviderOverride(
    covariant InvoiceListProvider provider,
  ) {
    return call(
      status: provider.status,
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
  String? get name => r'invoiceListProvider';
}

/// See also [invoiceList].
class InvoiceListProvider extends AutoDisposeStreamProvider<List<Invoice>> {
  /// See also [invoiceList].
  InvoiceListProvider({
    String? status,
  }) : this._internal(
          (ref) => invoiceList(
            ref as InvoiceListRef,
            status: status,
          ),
          from: invoiceListProvider,
          name: r'invoiceListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$invoiceListHash,
          dependencies: InvoiceListFamily._dependencies,
          allTransitiveDependencies:
              InvoiceListFamily._allTransitiveDependencies,
          status: status,
        );

  InvoiceListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final String? status;

  @override
  Override overrideWith(
    Stream<List<Invoice>> Function(InvoiceListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvoiceListProvider._internal(
        (ref) => create(ref as InvoiceListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Invoice>> createElement() {
    return _InvoiceListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvoiceListProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InvoiceListRef on AutoDisposeStreamProviderRef<List<Invoice>> {
  /// The parameter `status` of this provider.
  String? get status;
}

class _InvoiceListProviderElement
    extends AutoDisposeStreamProviderElement<List<Invoice>>
    with InvoiceListRef {
  _InvoiceListProviderElement(super.provider);

  @override
  String? get status => (origin as InvoiceListProvider).status;
}

String _$invoiceDetailHash() => r'7c4d10c2f908ee338a92781cde3ebc2d6469c29b';

/// See also [invoiceDetail].
@ProviderFor(invoiceDetail)
const invoiceDetailProvider = InvoiceDetailFamily();

/// See also [invoiceDetail].
class InvoiceDetailFamily extends Family<AsyncValue<Invoice?>> {
  /// See also [invoiceDetail].
  const InvoiceDetailFamily();

  /// See also [invoiceDetail].
  InvoiceDetailProvider call(
    String invoiceId,
  ) {
    return InvoiceDetailProvider(
      invoiceId,
    );
  }

  @override
  InvoiceDetailProvider getProviderOverride(
    covariant InvoiceDetailProvider provider,
  ) {
    return call(
      provider.invoiceId,
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
  String? get name => r'invoiceDetailProvider';
}

/// See also [invoiceDetail].
class InvoiceDetailProvider extends AutoDisposeFutureProvider<Invoice?> {
  /// See also [invoiceDetail].
  InvoiceDetailProvider(
    String invoiceId,
  ) : this._internal(
          (ref) => invoiceDetail(
            ref as InvoiceDetailRef,
            invoiceId,
          ),
          from: invoiceDetailProvider,
          name: r'invoiceDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$invoiceDetailHash,
          dependencies: InvoiceDetailFamily._dependencies,
          allTransitiveDependencies:
              InvoiceDetailFamily._allTransitiveDependencies,
          invoiceId: invoiceId,
        );

  InvoiceDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.invoiceId,
  }) : super.internal();

  final String invoiceId;

  @override
  Override overrideWith(
    FutureOr<Invoice?> Function(InvoiceDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvoiceDetailProvider._internal(
        (ref) => create(ref as InvoiceDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        invoiceId: invoiceId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Invoice?> createElement() {
    return _InvoiceDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvoiceDetailProvider && other.invoiceId == invoiceId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, invoiceId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InvoiceDetailRef on AutoDisposeFutureProviderRef<Invoice?> {
  /// The parameter `invoiceId` of this provider.
  String get invoiceId;
}

class _InvoiceDetailProviderElement
    extends AutoDisposeFutureProviderElement<Invoice?> with InvoiceDetailRef {
  _InvoiceDetailProviderElement(super.provider);

  @override
  String get invoiceId => (origin as InvoiceDetailProvider).invoiceId;
}

String _$invoiceStatusFilterHash() =>
    r'02a1f7d0fab979d987903b195b5354e8aa523f97';

/// See also [InvoiceStatusFilter].
@ProviderFor(InvoiceStatusFilter)
final invoiceStatusFilterProvider =
    AutoDisposeNotifierProvider<InvoiceStatusFilter, String?>.internal(
  InvoiceStatusFilter.new,
  name: r'invoiceStatusFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$invoiceStatusFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InvoiceStatusFilter = AutoDisposeNotifier<String?>;
String _$saveInvoiceNotifierHash() =>
    r'f34cfdf1ad82a90888a9b443acdddb2104c04c64';

/// See also [SaveInvoiceNotifier].
@ProviderFor(SaveInvoiceNotifier)
final saveInvoiceNotifierProvider = AutoDisposeNotifierProvider<
    SaveInvoiceNotifier, AsyncValue<Invoice?>>.internal(
  SaveInvoiceNotifier.new,
  name: r'saveInvoiceNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveInvoiceNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SaveInvoiceNotifier = AutoDisposeNotifier<AsyncValue<Invoice?>>;
String _$updateInvoiceStatusNotifierHash() =>
    r'0c3f917c8784ec7e30602d9ce2cb096723a24d03';

/// See also [UpdateInvoiceStatusNotifier].
@ProviderFor(UpdateInvoiceStatusNotifier)
final updateInvoiceStatusNotifierProvider = AutoDisposeNotifierProvider<
    UpdateInvoiceStatusNotifier, AsyncValue<void>>.internal(
  UpdateInvoiceStatusNotifier.new,
  name: r'updateInvoiceStatusNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateInvoiceStatusNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateInvoiceStatusNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
