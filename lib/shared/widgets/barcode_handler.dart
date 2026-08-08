import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tradeflow/features/business/application/business_providers.dart';
import '../../core/di/repository_providers.dart';
import '../../core/router/app_router.dart';
import '../../features/auth/application/auth_providers.dart';
import 'barcode_scanner_screen.dart';

class BarcodeHandler {
  static Future<void> scanAndNavigate({
    required BuildContext context,
    required WidgetRef ref,
    String title = 'Scan Product',
  }) async {
    final code = await context.push<String?>(AppRoutes.barcodeScanner);
    if (code == null || !context.mounted) return;

    // final scanned = await Navigator.push<String>(context,
    //     MaterialPageRoute(builder: (_) => BarcodeScannerScreen(title: title)));
    // if (scanned == null || !context.mounted) {
    //   return;
    // }

    final bizId = ref.read(activeBusinessProvider).asData?.value?.id;
    if (bizId == null || bizId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Business not found. Please restart.')));
      return;
    }

    final product = await ref
        .read(productRepositoryProvider)
        .getProductByBarcode(bizId, code);

    if (!context.mounted) {
      return;
    }
    if (product != null) {
      // Product found - open Edit screen
      context.push(AppRoutes.editProduct, extra: product);
    } else {
      // Not found - open Add screen with barcode pre-filled
      context.push(AppRoutes.addProduct, extra: code);
    }
  }
}
