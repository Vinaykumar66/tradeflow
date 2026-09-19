import '../../shared/models/eway_bill.dart';

class EwayBillResult {
  final String ebn;
  final DateTime validUntil;
  const EwayBillResult({required this.ebn, required this.validUntil});
}

abstract interface class IEwayBillProvider {
  Future<EwayBillResult> generate(EwayBill draft);
  Future<void> cancel(String ebn, String reason);
}
