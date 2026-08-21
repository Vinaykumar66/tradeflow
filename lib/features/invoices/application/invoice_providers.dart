import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/repository_providers.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/invoice.dart';

part 'invoice_providers.g.dart';

@riverpod
Stream<List<Invoice>> invoiceList(InvoiceListRef ref, {String? status}) async* {
  final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (bizId == null) {
    yield [];
    return;
  }
  yield* ref
      .read(invoiceRepositoryProvider)
      .streamInvoices(bizId, status: status);
}

//Filter state
@riverpod
class InvoiceStatusFilter extends _$InvoiceStatusFilter {
  @override
  String? build() => null; //null = all
  void set(String? s) => state = s;
}

@riverpod
class SaveInvoiceNotifier extends _$SaveInvoiceNotifier {
  @override
  AsyncValue<Invoice?> build() => const AsyncValue.data(null);

  Future<Invoice?> save(Invoice inv, List<InvoiceItem> item) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard<Invoice?>(() async {
      if (inv.id.isEmpty) {
        return ref.read(invoiceRepositoryProvider).createInvoice(inv, item);
      } else {
        await ref.read(invoiceRepositoryProvider).updateInvoice(inv);
        return inv;
      }
    });
    state = result;
    return result.asData?.value;
  }
}

//get saved invoice detail
@riverpod
Future<Invoice?> invoiceDetail(InvoiceDetailRef ref, String invoiceId) async {
  final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (bizId == null) return null;
  return ref.read(invoiceRepositoryProvider).getInvoice(bizId, invoiceId);
}

//Update status notifier

@riverpod
class UpdateInvoiceStatusNotifier extends _$UpdateInvoiceStatusNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);
  Future<void> update(String id, String status) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(invoiceRepositoryProvider).updateStatus(id, status));
  }
}
