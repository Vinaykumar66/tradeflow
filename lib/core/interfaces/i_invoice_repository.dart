import '../../shared/models/invoice.dart';

abstract interface class IInvoiceRepository {
  Future<Invoice> createInvoice(Invoice inv, List<InvoiceItem> items);
  Future<Invoice?> getInvoice(String businessId, String invoiceId);
  Stream<List<Invoice>> streamInvoices(String businessId, {String? status});
  Future<void> updateInvoice(Invoice inv);
  Future<void> updateStatus(String invoiceId, String status);
  Future<List<InvoiceItem>> getItems(String invoiceId);
  Future<void> cancelInvoice(String invoiceId);
  Future<Invoice> convertToInvoice(Invoice source);
  Future<List<Invoice>> getInvoicesForPeriod(
      String businessId, DateTime start, DateTime end);
}
