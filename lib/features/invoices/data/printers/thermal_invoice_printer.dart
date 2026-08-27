import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeflow/shared/models/invoice.dart';
import '../../../../core/interfaces/i_invoice_printer.dart';

const _kPrefKeyPairedPrinter = 'thermal_printer_mac_address';

class ThermalInvoicePrinter implements IInvoicePrinter {
  @override
  String get formatKey => kPrintFormatThermal;
  @override
  String get displayName => 'Thermal Receipt';
  @override
  String get iconAssetHint => 'receipt_log_outlined';

  @override
  Future<void> print(InvoicePrintJob job) async {
    final prefs = await SharedPreferences.getInstance();
    final mac = prefs.getString(_kPrefKeyPairedPrinter);
    if (mac == null) {
      throw Exception(
          'No thermal printer paired. Open Thermal Printer settings first.');
    }

    final connected =
        await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    if (!connected) {
      throw Exception('Could not connect to the paired thrmal printer.');
    }
    final bytes = await _buildReceipt(job);
    await PrintBluetoothThermal.writeBytes(bytes);
  }

  Future<List<int>> _buildReceipt(InvoicePrintJob job) async {
    final inv = job.invoice;
    final biz = job.business;
//80mm paper
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    var bytes = <int>[];

    bytes += generator.text(biz.name,
        styles: const PosStyles(
            align: PosAlign.center,
            bold: true,
            height: PosTextSize.size2,
            width: PosTextSize.size2));
    if (biz.address != null) {
      bytes += generator.text(biz.address!,
          styles: const PosStyles(align: PosAlign.center));
    }
    bytes += generator.hr();

    bytes +=
        generator.text(inv.invoiceNumber, styles: const PosStyles(bold: true));
    bytes += generator.hr();

    for (final item in inv.items) {
      bytes += generator.text(item.name);
      bytes += generator.row([
        PosColumn(
            text: '${item.quantity} * ${inv.fmt(item.unitPrice)}', width: 8),
        PosColumn(
            text: inv.fmt(item.lineTotal),
            width: 4,
            styles: const PosStyles(align: PosAlign.right))
      ]);
    }
    bytes += generator.hr();
//totals
    bytes += generator.row([
      PosColumn(text: 'TOTAL', width: 6, styles: const PosStyles(bold: true)),
      PosColumn(
          text: inv.formattedTotal,
          width: 6,
          styles: const PosStyles(bold: true, align: PosAlign.right)),
    ]);
    if (inv.balanceDue > 0) {
      bytes += generator.row([
        PosColumn(text: 'Balance Due', width: 6),
        PosColumn(
            text: inv.formattedBalanceDue,
            width: 6,
            styles: const PosStyles(align: PosAlign.right)),
      ]);
    }
    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }
}
