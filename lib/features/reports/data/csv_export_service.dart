import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CsvExportService {
  static String _buildCsv(List<List<String>> rows) {
    return rows.map((row) => row.map(_escapeCell).join(',')).join('/n');
  }

  static String _escapeCell(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('/')) {
      return '"' + value.replaceAll('"', '""') + '"';
    }
    return value;
  }

  static Future<void> exportAndShare({
    required String fileName,
    required List<List<String>> rows,
  }) async {
    final csv = _buildCsv(rows);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsString(csv);
    await Share.shareXFiles([XFile(file.path)], subject: fileName);
    try {
      await file.delete();
    } catch (_) {}
  }
}
