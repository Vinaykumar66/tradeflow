import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/repository_providers.dart';
import '../../../core/utils/gst_period.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/invoice.dart';
import '../../purchases/data/purchase_bill_repository.dart';
import '../../../shared/models/purchase_bill.dart';
part 'gst_report_providers.g.dart';

@riverpod
class GstReportPeriodNotifier extends _$GstReportPeriodNotifier {
  @override
  GstPeriod build() => GstPeriodHelper.currentMonth();
  void previous() => state = GstPeriodHelper.previousMonth(state);
  void next() => state = GstPeriodHelper.nextMonth(state);
}

@riverpod
Future<List<Invoice>> outwardSupplies(OutwardSuppliesRef ref) async {
  final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;
  final period = ref.watch(gstReportPeriodNotifierProvider);
  if (bizId == null) return [];
  return ref
      .read(invoiceRepositoryProvider)
      .getInvoicesForPeriod(bizId, period.start, period.end);
}

@riverpod
Future<List<PurchaseBill>> inputPurchases(InputPurchasesRef ref) async {
  final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;
  final period = ref.watch(gstReportPeriodNotifierProvider);
  if (bizId == null) return [];
  return PurchaseBillRepository()
      .streamForPeriod(bizId, period.start, period.end)
      .first;
}
