// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gst_report_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$outwardSuppliesHash() => r'c6babd1a394be26c4fb67c976cd0cc6763b9ceac';

/// See also [outwardSupplies].
@ProviderFor(outwardSupplies)
final outwardSuppliesProvider =
    AutoDisposeFutureProvider<List<Invoice>>.internal(
  outwardSupplies,
  name: r'outwardSuppliesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$outwardSuppliesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OutwardSuppliesRef = AutoDisposeFutureProviderRef<List<Invoice>>;
String _$inputPurchasesHash() => r'56cea294a1d87020c942518330e102c64534302d';

/// See also [inputPurchases].
@ProviderFor(inputPurchases)
final inputPurchasesProvider =
    AutoDisposeFutureProvider<List<PurchaseBill>>.internal(
  inputPurchases,
  name: r'inputPurchasesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inputPurchasesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InputPurchasesRef = AutoDisposeFutureProviderRef<List<PurchaseBill>>;
String _$creditNotesHash() => r'1bb61e6cd618e8ec2e7e12be6a387016de74af39';

/// See also [creditNotes].
@ProviderFor(creditNotes)
final creditNotesProvider = AutoDisposeFutureProvider<List<Invoice>>.internal(
  creditNotes,
  name: r'creditNotesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$creditNotesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreditNotesRef = AutoDisposeFutureProviderRef<List<Invoice>>;
String _$gstr3bDataHash() => r'8cd433f50d2da630994d7771bc15d0687196aaaa';

/// See also [gstr3bData].
@ProviderFor(gstr3bData)
final gstr3bDataProvider = AutoDisposeFutureProvider<Gstr3bData>.internal(
  gstr3bData,
  name: r'gstr3bDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gstr3bDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef Gstr3bDataRef = AutoDisposeFutureProviderRef<Gstr3bData>;
String _$gstReportPeriodNotifierHash() =>
    r'490437140c8efc0829f6b07cd04025826b83e98f';

/// See also [GstReportPeriodNotifier].
@ProviderFor(GstReportPeriodNotifier)
final gstReportPeriodNotifierProvider =
    AutoDisposeNotifierProvider<GstReportPeriodNotifier, GstPeriod>.internal(
  GstReportPeriodNotifier.new,
  name: r'gstReportPeriodNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gstReportPeriodNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GstReportPeriodNotifier = AutoDisposeNotifier<GstPeriod>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
