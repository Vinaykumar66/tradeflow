// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_code_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taxCodeListHash() => r'2907000cbbcb395c2af021977b89044200166c73';

/// See also [taxCodeList].
@ProviderFor(taxCodeList)
final taxCodeListProvider = AutoDisposeStreamProvider<List<TaxCode>>.internal(
  taxCodeList,
  name: r'taxCodeListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taxCodeListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaxCodeListRef = AutoDisposeStreamProviderRef<List<TaxCode>>;
String _$saveTaxCodeNotifierHash() =>
    r'0941d83ecdbd9964fb94ed4cf8eab25d21a22547';

/// See also [SaveTaxCodeNotifier].
@ProviderFor(SaveTaxCodeNotifier)
final saveTaxCodeNotifierProvider =
    AutoDisposeNotifierProvider<SaveTaxCodeNotifier, AsyncValue<void>>.internal(
  SaveTaxCodeNotifier.new,
  name: r'saveTaxCodeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveTaxCodeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SaveTaxCodeNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
