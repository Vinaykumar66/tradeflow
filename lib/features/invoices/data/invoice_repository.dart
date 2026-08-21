import 'package:uuid/uuid.dart';
import '../../../core/constants/table_constants.dart';
import '../../../core/interfaces/i_invoice_repository.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../core/utils/invoice_number_generator.dart';
import '../../../shared/models/invoice.dart';

class InvoiceRepository implements IInvoiceRepository {
  final _uuid = const Uuid();
  @override
  Future<Invoice> createInvoice(Invoice inv, List<InvoiceItem> items) async {
    final int seq;
    final String prefix;
    const format = '{PREFIX}/{YEAR}/{SEQ:4}';

    if (inv.documentType == kDocTypeInvoice) {
      // Real tax invoices — existing counter, completely untouched.
      final seqResult = await supabase.rpc('get_next_invoice_number',
          params: {'p_business_id': inv.businessId});
      seq = (seqResult as int?) ?? 1;

      final bizRow = await supabase
          .from(SupabaseTables.businesses)
          .select('invoice_prefix')
          .eq('id', inv.businessId)
          .single();
      prefix = (bizRow['invoice_prefix'] as String?) ?? 'INV';
    } else {
      // Proforma / Estimate / Quotation — separate counter per type,
      // never touches the tax invoice sequence.
      prefix = switch (inv.documentType) {
        kDocTypeProforma => 'PRO',
        kDocTypeEstimate => 'EST',
        kDocTypeQuotation => 'QUO',
        _ => 'DOC',
      };
      final seqResult = await supabase.rpc('get_next_document_number', params: {
        'p_business_id': inv.businessId,
        'p_document_type': inv.documentType,
        'p_default_prefix': prefix,
      });
      seq = (seqResult as int?) ?? 1;
    }

    final documentNumber = InvoiceNumberGenerator.generate(
        format: format, prefix: prefix, sequence: seq);

    final id = _uuid.v4();
    final map = {
      'id': id,
      'business_id': inv.businessId,
      'customer_id': inv.customerId,
      'invoice_number': documentNumber,
      'document_type': inv.documentType,
      'status': inv.status,
      'issue_date': inv.issueDate.toIso8601String(),
      'due_date': inv.dueDate?.toIso8601String(),
      'subtotal': inv.subtotal,
      'discount_amount': inv.discountAmount,
      'tax_amount': inv.taxAmount,
      'total': inv.total,
      'currency_code': inv.currencyCode,
      'currency_symbol': inv.currencySymbol,
      'use_lakh_format': inv.useLakhFormat,
      'notes': inv.notes,
      'terms': inv.terms,
      'created_by': inv.createdBy,
    };
    await supabase.from(SupabaseTables.invoices).insert(map);

    if (items.isNotEmpty) {
      final itemMaps = items
          .asMap()
          .entries
          .map((e) => e.value
              .copyWith(sortOrder: e.key)
              .toInsertMap(id, inv.businessId))
          .toList();
      await supabase.from(SupabaseTables.invoiceItems).insert(itemMaps);
    }
    return inv.copyWith(id: id, invoiceNumber: documentNumber, items: items);
  }

  // Future<Invoice> createInvoice(Invoice inv, List<InvoiceItem> items) async {
  //   // 1. get next invoice number atomically from DB, to avoid duplicate invoices generated from diff sessions
  //   final seqResult = await supabase.rpc('get_next_invoice_number',
  //       params: {'p_business_id': inv.businessId});
  //   final seq = (seqResult as int?) ?? 1;

  //   //2. fetch format + prefix from businesses
  //   final bizRow = await supabase
  //       .from(SupabaseTables.businesses)
  //       .select('invoice_prefix, invoice_number_format')
  //       .eq('id', inv.businessId)
  //       .single();
  //   final format =
  //       (bizRow['invoice_number_format'] as String?) ?? '{PREFIX}/{YEAR}/SEQ:4';
  //   final prefix = (bizRow['invoice_prefix'] as String?) ?? 'INV';

  //   //3. generate formatted invoice number
  //   final invoiceNumber = InvoiceNumberGenerator.generate(
  //       format: format, prefix: prefix, sequence: seq);

  //   //4. Insert invoice row
  //   final id = _uuid.v4();
  //   final map = {
  //     'id': id,
  //     'business_id': inv.businessId,
  //     'customer_id': inv.customerId,
  //     'invoice_number': invoiceNumber,
  //     'status': inv.status,
  //     'issue_date': inv.issueDate.toIso8601String(),
  //     'due_date': inv.dueDate?.toIso8601String(),
  //     'subtotal': inv.subtotal,
  //     'discount_amount': inv.discountAmount,
  //     'tax_amount': inv.taxAmount,
  //     'total': inv.total,
  //     'currency_code': inv.currencyCode,
  //     'currency_symbol': inv.currencySymbol,
  //     'use_lakh_format': inv.useLakhFormat,
  //     'notes': inv.notes,
  //     'terms': inv.terms,
  //     'created_by': inv.createdBy,
  //   };
  //   await supabase.from(SupabaseTables.invoices).insert(map);

  //   //5. insert all line items
  //   if (items.isNotEmpty) {
  //     final itemMaps = items
  //         .asMap()
  //         .entries
  //         .map((e) => e.value
  //             .copyWith(sortOrder: e.key)
  //             .toInsertMap(id, inv.businessId))
  //         .toList();
  //     await supabase.from(SupabaseTables.invoiceItems).insert(itemMaps);
  //   }
  //   return inv.copyWith(id: id, invoiceNumber: invoiceNumber, items: items);
  // }

  @override
  Stream<List<Invoice>> streamInvoices(String businessId, {String? status}) {
    var q = supabase
        .from(SupabaseTables.invoices)
        .stream(primaryKey: ['id'])
        .eq('business_id', businessId)
        .order('created_at', ascending: false);
    return q.map((rows) {
      var list = rows.map((r) => Invoice.fromJson(r)).toList();
      if (status != null) list = list.where((i) => i.status == status).toList();
      return list;
    });
  }

  @override
  Future<void> updateStatus(String invoiceId, String status) async {
    await supabase.from(SupabaseTables.invoices).update({
      'status': status,
      'updated_at': DateTime.now().toIso8601String()
    }).eq('id', invoiceId);
  }

  @override
  Future<List<InvoiceItem>> getItems(String invoiceId) async {
    final rows = await supabase
        .from(SupabaseTables.invoiceItems)
        .select()
        .eq('invoice_id', invoiceId)
        .order('sort_order');
    return rows.map((r) => InvoiceItem.fromJson(r)).toList();
  }

  @override
  Future<void> cancelInvoice(String invoiceId) =>
      updateStatus(invoiceId, kStatusCancelled);

  @override
  Future<Invoice?> getInvoice(String businessId, String invoiceId) async {
    final row = await supabase
        .from(SupabaseTables.invoices)
        .select()
        .eq('business_id', businessId)
        .eq('id', invoiceId)
        .maybeSingle();
    if (row == null) return null;
    final inv = Invoice.fromJson(row);
    final items = await getItems(invoiceId);
    return inv.copyWith(items: items);
  }

  Future<void> updateInvoice(Invoice inv) async {
    await supabase.from(SupabaseTables.invoices).update({
      'status': inv.status,
      'due_date': inv.dueDate?.toIso8601String(),
      'subtotal': inv.subtotal,
      'discount_amount': inv.discountAmount,
      'tax_amount': inv.taxAmount,
      'total': inv.total,
      'notes': inv.notes,
      'terms': inv.terms,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', inv.id);
  }
}
