import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/repository_providers.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../shared/models/customer.dart';
import '../../business/application/business_providers.dart';

part 'customer_providers.g.dart';

@riverpod
Stream<List<Customer>> customerList(CustomerListRef ref) async* {
  final bizAsync = ref.watch(activeBusinessProvider);
  final bizId = bizAsync.asData?.value?.id;

  if (bizId == null) {
    // Emit empty list immediately instead of never emitting
    // This moves provider to AsyncData([]) not AsyncLoading
    yield [];
    return;
  }

  // Stream all products for this business
  // Supabase realtime — updates when products are added/edited
  yield* ref.read(customerRepositoryProvider).streamCustomers(bizId);
  //   return const Stream.empty();
  // return ref.watch(customerRepositoryProvider).streamCustomers(biz);
}

@riverpod
Stream<List<Customer>> overdueCustomers(OverdueCustomersRef ref) {
  final biz = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (biz == null) return const Stream.empty();
  return ref.watch(customerRepositoryProvider).streamOverdueCustomers(biz);
}

@riverpod
class CustomerSearchQuery extends _$CustomerSearchQuery {
  @override
  String build() => '';
  void set(String q) => state = q;
  void clear() => state = '';
}

@riverpod
class ShowOverdueOnly extends _$ShowOverdueOnly {
  @override
  bool build() => false;
  void toggle() => state = !state;
  void set(bool v) => state = v;
}

@riverpod
AsyncValue<List<Customer>> filteredCustomers(FilteredCustomersRef ref) {
  final all = ref.watch(customerListProvider);
  final q = ref.watch(customerSearchQueryProvider).toLowerCase();
  final overdueOnly = ref.watch(showOverdueOnlyProvider);
  if (!all.hasValue) return all;
  var list = all.requireValue;
  if (overdueOnly) list = list.where((c) => c.isOverCreditLimit).toList();
  if (q.isNotEmpty)
    list = list
        .where((c) =>
            c.name.toLowerCase().contains(q) ||
            (c.phone?.contains(q) ?? false) ||
            (c.gstin?.toLowerCase().contains(q) ?? false))
        .toList();
  return AsyncData(list);
}

@riverpod
class SaveCustomerNotifier extends _$SaveCustomerNotifier {
  @override
  AsyncValue<Customer?> build() => const AsyncValue.data(null);
  Future<Customer?> save(Customer c) async {
    state = const AsyncValue.loading();
    final repo = ref.read(customerRepositoryProvider);
    final result = await AsyncValue.guard<Customer?>(() async {
      if (c.id.isEmpty) return repo.createCustomer(c);
      await repo.updateCustomer(c);
      return c;
    });
    state = result;
    return result.asData?.value;
  }
}
