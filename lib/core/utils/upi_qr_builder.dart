import '../../shared/models/business.dart';
import '../../shared/models/invoice.dart';

class UpiQrBuilder {
  static final _vpaPatter = RegExp(r'^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$');
  static bool isValidVpa(String vpa) => _vpaPatter.hasMatch(vpa.trim());
  static bool shouldShow(Business biz, Invoice inv) =>
      biz.countryCode == 'IN' &&
      inv.currencyCode == 'INR' &&
      biz.showUpiQr &&
      biz.upiId != null &&
      isValidVpa(biz.upiId!) &&
      inv.documentType == kDocTypeInvoice &&
      inv.status != kStatusCancelled &&
      inv.balanceDue > 0;

  //QR for the balance due, not the invoice total, so partly paid invoice never asks the customer for money already received. As payment amout is not editable
  static String? forInvoice(Business biz, Invoice inv) {
    if (!shouldShow(biz, inv)) return null;
    return build(
      vpa: biz.upiId!,
      payeeName: biz.name,
      amountPaise: inv.balanceDue,
      note: 'Invoice ${inv.invoiceNumber}',
    );
  }

  static String build({
    required String vpa,
    required String payeeName,
    required int amountPaise,
    String? note,
  }) {
    final q = <String>[
      'pa=${vpa.trim()}',
      'pn=${Uri.encodeComponent(payeeName)}',
      'am=${(amountPaise / 100).toStringAsFixed(2)}',
      'cu=INR',
      if (note != null && note.isNotEmpty) 'tn=${Uri.encodeComponent(note)}',
    ];
    return 'upi://pay?${q.join('&')}';
  }
}
