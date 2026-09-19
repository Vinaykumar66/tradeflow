import '../../../core/interfaces/i_eway_bill_provider.dart';
import '../../../shared/models/eway_bill.dart';

class StubEwayBillProvider implements IEwayBillProvider {
  @override
  Future<EwayBillResult> generate(EwayBill draft) async {
    await Future.delayed(const Duration(seconds: 1));
    return EwayBillResult(
        ebn: 'STUB-EBN-${DateTime.now().millisecondsSinceEpoch}',
        validUntil: DateTime.now().add(const Duration(days: 1)));
  }

  @override
  Future<void> cancel(String ebn, String reason) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
