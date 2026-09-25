import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';

class GstComplianceScreen extends StatelessWidget {
  const GstComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xFF2F4F4F)),
            backgroundColor: Color(0xF0FFFFFF),
            title: const Text(
                style: TextStyle(color: Color(0xFF2F4F4F)), 'GST Compliance ')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          _tile(context,
              title: 'GSTR-1 - Outward Supplies',
              subtitle: 'B2B invoce-wise, B2C by tax rate',
              icon: Icons.receipt_long_outlined,
              onTap: () => context.push(AppRoutes.gstr1Report)),
          _tile(context,
              title: 'HSN/SAC Summary',
              subtitle: 'Quantity and tax by product code',
              icon: Icons.qr_code_2_outlined,
              onTap: () => context.push(AppRoutes.hsnSummary)),
          _tile(context,
              title: 'GSTR-3B - Tax Liability',
              subtitle: 'Period summary, outward tax only',
              icon: Icons.summarize_outlined,
              onTap: () => context.push(AppRoutes.gstr3bSummary)),
        ]));
  }

  Widget _tile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) =>
      Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
              leading: Icon(icon, color: AppColors.primary),
              title: Text(title),
              subtitle: Text(subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: onTap));
}
