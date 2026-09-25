import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/country_tax_config.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/vendor.dart';
import '../application/vendor_providers.dart';

class AddEditVendorScreen extends ConsumerStatefulWidget {
  final Vendor? vendor;
  const AddEditVendorScreen({super.key, this.vendor});

  @override
  ConsumerState<AddEditVendorScreen> createState() =>
      _AddEditVendorScreenState();
}

class _AddEditVendorScreenState extends ConsumerState<AddEditVendorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  bool get _isEditing => widget.vendor != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final v = widget.vendor!;
      _nameCtrl.text = v.name;
      _phoneCtrl.text = v.phone ?? '';
      _emailCtrl.text = v.email ?? '';
      _gstinCtrl.text = v.gstin ?? '';
    }
  }

  @override
  void dispose() {
    for (final c in [_nameCtrl, _phoneCtrl, _emailCtrl, _gstinCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final biz = ref.read(activeBusinessProvider).asData?.value;
    if (biz == null) return;

    final vendor = Vendor(
      id: _isEditing ? widget.vendor!.id : '',
      businessId: biz.id,
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
      email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      gstin: _gstinCtrl.text.trim().isEmpty ? null : _gstinCtrl.text.trim(),
    );
    await ref.read(saveVendorNotifierProvider.notifier).save(vendor);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;
    final taxConfig = CountryTaxRegistry.forCountry(biz?.countryCode);

    return Scaffold(
      appBar: AppBar(
          title: Text(_isEditing ? 'Edit Vendor' : 'Add. Vendor'),
          actions: [
            TextButton(
                onPressed: _save,
                child: const Text('SAVE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ]),
      body: Form(
          key: _formKey,
          child: ListView(padding: const EdgeInsets.all(16), children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Vendor Name *'),
              validator: (v) => v!.trim().isEmpty ? 'Name required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: 'Phone')),
            const SizedBox(height: 12),
            TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            TextFormField(
                controller: _gstinCtrl,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                    labelText: '${taxConfig.taxIdLabel}(optional)',
                    hintText: taxConfig.taxIdHint),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final validator = taxConfig.taxIdValidator;
                  if (validator != null && !validator.hasMatch(v.trim())) {
                    return 'Invalid ${taxConfig.taxIdLabel} format';
                  }
                  return null;
                }),
          ])),
    );
  }
}
