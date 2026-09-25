// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$vendorListHash() => r'af496414d85594e7b835617eb7176b7cd83f2f6c';

/// See also [vendorList].
@ProviderFor(vendorList)
final vendorListProvider = AutoDisposeStreamProvider<List<Vendor>>.internal(
  vendorList,
  name: r'vendorListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$vendorListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VendorListRef = AutoDisposeStreamProviderRef<List<Vendor>>;
String _$saveVendorNotifierHash() =>
    r'20852bb09d0e5f54e4c14cb638b12ccdfa5dfdc8';

/// See also [SaveVendorNotifier].
@ProviderFor(SaveVendorNotifier)
final saveVendorNotifierProvider =
    AutoDisposeNotifierProvider<SaveVendorNotifier, AsyncValue<void>>.internal(
  SaveVendorNotifier.new,
  name: r'saveVendorNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveVendorNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SaveVendorNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
