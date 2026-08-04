import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/product.dart';

class StockBadge extends StatelessWidget {
  final Product product;
  const StockBadge({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    if (!product.trackInventory) return const SizedBox.shrink();
    final (label, color) = switch (product.stockStatus) {
      StockStatus.inStock => ('In Stock', AppColors.alertGreen),
      StockStatus.lowStock => (
          'Low: ${product.stockQty}',
          AppColors.alertAmber
        ),
      StockStatus.outOfStock => ('Out of Stock', AppColors.alertRed),
      StockStatus.notTracked => ('', Colors.grey),
    };
    if (label.isEmpty) return const SizedBox.shrink();
    return _Badge(label: label, color: color);
  }
}

class ExpiryBadge extends StatelessWidget {
  final Product product;
  const ExpiryBadge({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (product.expiryStatus) {
      ExpiryStatus.expired => ('Expired', AppColors.alertRed),
      ExpiryStatus.expiringSoon => ('Exp soon', AppColors.alertAmber),
      _ => ('', Colors.grey),
    };
    if (label.isEmpty) {
      return const SizedBox.shrink();
    }
    return _Badge(label: label, color: color);
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 11, color: color, fontWeight: FontWeight.w600)),
      );
}
