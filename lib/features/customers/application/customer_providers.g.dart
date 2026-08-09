// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerListHash() => r'355123fc3dad496f063fb7707932339b0cc8966d';

/// See also [customerList].
@ProviderFor(customerList)
final customerListProvider = AutoDisposeStreamProvider<List<Customer>>.internal(
  customerList,
  name: r'customerListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$customerListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CustomerListRef = AutoDisposeStreamProviderRef<List<Customer>>;
String _$overdueCustomersHash() => r'3461203a40fe4b16468c02d6909c7588263bb586';

/// See also [overdueCustomers].
@ProviderFor(overdueCustomers)
final overdueCustomersProvider =
    AutoDisposeStreamProvider<List<Customer>>.internal(
  overdueCustomers,
  name: r'overdueCustomersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$overdueCustomersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OverdueCustomersRef = AutoDisposeStreamProviderRef<List<Customer>>;
String _$filteredCustomersHash() => r'4143864f8da543815ec914771056c7078708ef50';

/// See also [filteredCustomers].
@ProviderFor(filteredCustomers)
final filteredCustomersProvider =
    AutoDisposeProvider<AsyncValue<List<Customer>>>.internal(
  filteredCustomers,
  name: r'filteredCustomersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredCustomersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredCustomersRef
    = AutoDisposeProviderRef<AsyncValue<List<Customer>>>;
String _$customerSearchQueryHash() =>
    r'276b55956bd928e8a5fad1e534af17b3229865f7';

/// See also [CustomerSearchQuery].
@ProviderFor(CustomerSearchQuery)
final customerSearchQueryProvider =
    AutoDisposeNotifierProvider<CustomerSearchQuery, String>.internal(
  CustomerSearchQuery.new,
  name: r'customerSearchQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerSearchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomerSearchQuery = AutoDisposeNotifier<String>;
String _$showOverdueOnlyHash() => r'bdce8de582244d1a872f048934a1467f94e94065';

/// See also [ShowOverdueOnly].
@ProviderFor(ShowOverdueOnly)
final showOverdueOnlyProvider =
    AutoDisposeNotifierProvider<ShowOverdueOnly, bool>.internal(
  ShowOverdueOnly.new,
  name: r'showOverdueOnlyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$showOverdueOnlyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShowOverdueOnly = AutoDisposeNotifier<bool>;
String _$saveCustomerNotifierHash() =>
    r'86460c82dabd633061202ffaf60fafce0375945b';

/// See also [SaveCustomerNotifier].
@ProviderFor(SaveCustomerNotifier)
final saveCustomerNotifierProvider = AutoDisposeNotifierProvider<
    SaveCustomerNotifier, AsyncValue<Customer?>>.internal(
  SaveCustomerNotifier.new,
  name: r'saveCustomerNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saveCustomerNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SaveCustomerNotifier = AutoDisposeNotifier<AsyncValue<Customer?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
