import 'package:uuid/uuid.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/purchase_bill.dart';

class PurchaseBillRepository {
  final _uuid = const Uuid();

  Future<PurchaseBill> create(
      PurchaseBill bill, List<PurchaseBillItem> items) async {
    final id = _uuid.v4();
    await supabase.from('purchase_bills').insert({
      'id': id,
      'business_id': bill.businessId,
      'vendor_id': bill.vendorId,
      'bill_number': bill.billNumber,
      'bill_date': bill.billDate.toIso8601String(),
      'subtotal': bill.subtotal,
      'cgst_total': bill.cgstTotal,
      'sgst_total': bill.sgstTotal,
      'igst_total': bill.igstTotal,
      'ugst_total': bill.ugstTotal,
      'total': bill.total,
      'notes': bill.notes,
    });
    if (items.isNotEmpty) {
      final itemMaps =
          items.map((i) => i.toInsertMap(id, bill.businessId)).toList();
      await supabase.from('purchase_bill_items').insert(itemMaps);
    }
    return bill.copyWith(id: id, items: items);
  }

  Stream<List<PurchaseBill>> streamForPeriod(
      String businessId, DateTime start, DateTime end) {
    return supabase
        .from('purchase_bills')
        .stream(primaryKey: ['id'])
        .eq('business_id', businessId)
        .order('bill_date', ascending: false)
        .map((rows) => rows
            .map((r) => PurchaseBill.fromJson(r))
            .where(
                (b) => !b.billDate.isBefore(start) && !b.billDate.isAfter(end))
            .toList());
  }
}
