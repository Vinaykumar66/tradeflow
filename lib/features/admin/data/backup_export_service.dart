import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import '../../../core/supabase/supabase_client.dart';

class BackupExportService {
  static const _tables = [
    'customers',
    'vendors',
    'products',
    'invoices',
    'invoice_items',
    'purchase_bills',
    'purchase_bill_items',
    'payments',
    'vendor_payments',
  ];

  static Future<void> exportAll(String businessId, String businessName) async {
    final data = <String, dynamic>{
      'exported_at': DateTime.now().toIso8601String(),
      'business_id': businessId,
    };
    for (final table in _tables) {
      final rows =
          await supabase.from(table).select().eq('business_id', businessId);
      data[table] = rows;
    }
    final json = const JsonEncoder.withIndent(' ').convert(data);
    final tempDir = await getTemporaryDirectory();
    final safeBizName = businessName.replaceAll(RegExp(r'[^\w\s]'), '');
    final file = File('${tempDir.path}/TradeFlow_Backup_$safeBizName.json');
    await file.writeAsString(json);
    await Share.shareXFiles([XFile(file.path)],
        subject: 'TradeFlow data backup - $businessName');

    try {
      await file.delete();
    } catch (_) {}
  }
}
