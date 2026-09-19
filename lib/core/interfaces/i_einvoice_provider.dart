import '../../shared/models/invoice.dart';

class EInvoiceResult {
  final String irn;
  final String ackNumber;
  final DateTime ackDate;
  final String signedQrCode;
  const EInvoiceResult({
    required this.irn,
    required this.ackNumber,
    required this.ackDate,
    required this.signedQrCode,
  });
}

abstract interface class IEInvoiceProvider {
  Future<EInvoiceResult> generateIrn(Invoice invoice);
  Future<void> cancelIrn(String irn, String reason);
}
