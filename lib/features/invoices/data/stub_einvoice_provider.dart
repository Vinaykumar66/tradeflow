import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/interfaces/i_einvoice_provider.dart';
import '../../../shared/models/invoice.dart';

class StubEInvoiceProvider implements IEInvoiceProvider {
  @override
  Future<EInvoiceResult> generateIrn(Invoice invoice) async {
    await Future.delayed(const Duration(seconds: 1));
    final tempIrn =
        List.generate(64, (_) => Random().nextInt(16).toRadixString(16)).join();
    return EInvoiceResult(
      irn: tempIrn,
      ackNumber: 'STUB-${DateTime.now().millisecondsSinceEpoch}',
      ackDate: DateTime.now(),
      signedQrCode: 'STUB_QR:${invoice.invoiceNumber}',
    );
  }

  @override
  Future<void> cancelIrn(String irn, String reason) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

@riverpod
IEInvoiceProvider einvoiceProvider(Ref ref) => StubEInvoiceProvider();
