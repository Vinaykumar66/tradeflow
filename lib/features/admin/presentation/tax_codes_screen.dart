import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/country_tax_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/tax_code.dart';
import '../application/tax_code_providers.dart';

class TaxCodesScreen extends ConsumerWidget {
  const TaxCodesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;
    final codes = ref.watch(taxCodeListProvider).asData?.value ?? [];

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xF0FFFFFF),
          iconTheme: const IconThemeData(color: Color(0xFF2F4F4F)),
          title: const Text(
              style: TextStyle(color: Color(0xFF2F4F4F)), 'Tax Codes')),
      body: codes.isEmpty
          ? Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.receipt_long_outlined,
                  size: 56, color: Colors.grey),
              const SizedBox(height: 12),
              const Text('No tax codes yet.'),
              const SizedBox(height: 4),
              Text(
                  'Tap + to add your first ${CountryTaxRegistry.forCountry(biz?.countryCode).taxLabel} rate.',
                  style: const TextStyle(color: Colors.grey)),
            ]))
          : ListView.builder(
              itemCount: codes.length,
              itemBuilder: (_, i) {
                final c = codes[i];
                return ListTile(
                    leading: Icon(c.isDefault ? Icons.star : Icons.star_border,
                        color: c.isDefault ? AppColors.primary : Colors.grey),
                    title: Text(c.displayLabel),
                    subtitle: Text(c.isDefault
                        ? 'Default for new products'
                        : 'Tap to set as default'),
                    onTap: () => ref
                        .read(saveTaxCodeNotifierProvider.notifier)
                        .setDefault(biz!.id, c.id),
                    trailing: IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        onPressed: () =>
                            _showEditor(context, ref, biz!, code: c)));
              }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showEditor(context, ref, biz!),
          icon: const Icon(Icons.add),
          label: const Text('Add Tax Code')),
    );
  }

  void _showEditor(BuildContext context, WidgetRef ref, dynamic biz,
      {TaxCode? code}) {
    final cfg = CountryTaxRegistry.forCountry(biz.countryCode);
    final nameCtrl = TextEditingController(text: code?.name ?? cfg.taxLabel);
    final rateCtrl =
        TextEditingController(text: (code?.rate ?? cfg.defaultRate).toString());
    var inclusive = code?.isInclusive ?? false;

    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
            builder: (ctx, setState) => AlertDialog(
                    title:
                        Text(code == null ? 'Add Tax Code' : 'Edit Tax Code'),
                    content: Column(mainAxisSize: MainAxisSize.min, children: [
                      TextField(
                          controller: nameCtrl,
                          decoration: const InputDecoration(labelText: 'Name')),
                      SizedBox(height: 10),
                      TextField(
                          controller: rateCtrl,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: 'Rate %')),
                      SizedBox(height: 10),
                      SwitchListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        title: const Text('Tax inclusive'),
                        value: inclusive,
                        onChanged: (v) => setState(() => inclusive = v),
                      ),
                    ]),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: () {
                            final tc = TaxCode(
                                id: code?.id ?? '',
                                businessId: biz.id,
                                name: nameCtrl.text.trim(),
                                rate: double.tryParse(rateCtrl.text) ?? 0,
                                isInclusive: inclusive,
                                isDefault: code?.isDefault ?? false);
                            ref
                                .read(saveTaxCodeNotifierProvider.notifier)
                                .save(tc);
                            Navigator.pop(ctx);
                          },
                          child: const Text('Save')),
                    ])));
  }
}
