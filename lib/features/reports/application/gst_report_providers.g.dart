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
