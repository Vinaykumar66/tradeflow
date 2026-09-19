// import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tradeflow/core/di/repository_providers.dart';
import 'package:tradeflow/core/router/app_router.dart';
import 'package:tradeflow/shared/models/business.dart';
import 'package:tradeflow/shared/models/license_tier.dart';
import '../../../core/config/app_config.dart';
import '../../../core/config/country_tax_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/widgets/storage_guard.dart';

class BusinessSettingsScreen extends ConsumerStatefulWidget {
  const BusinessSettingsScreen({super.key});
  @override
  ConsumerState<BusinessSettingsScreen> createState() =>
      _BusinessSettingsScreenState();
}

class _BusinessSettingsScreenState
    extends ConsumerState<BusinessSettingsScreen> {
  XFile? _pickedLogo;
  bool _uploading = false;

  Future<void> _pickAndUploadLogo() async {
    final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 90);
    if (picked == null) return;

    // else if (fileName.endsWith('.gif')) {
    //   resolvedMimeType = 'image/gif';
    // } else if (fileName.endsWith('.heic')) {
    //   resolvedMimeType = 'image/heic';
    // }
    final biz = ref.read(activeBusinessProvider).asData?.value;

    if (biz == null) return;
    setState(() {
      _pickedLogo = XFile(picked.path);
      _uploading = true;
    });
    try {
      final bytes = await _pickedLogo!.readAsBytes();
      final String fileName = picked.name.toLowerCase();
      String resolvedMimeType = 'image/jpeg';
      if (fileName.endsWith('.png')) {
        resolvedMimeType = 'image/png';
      } else if (fileName.endsWith('.jpg')) {
        resolvedMimeType = 'image/jpg';
      }
      final ok = await ref.read(storageTrackingServiceProvider).hasQuota(
          businessId: biz.id,
          limitBytes: biz.licenseTier.storageLimitBytes,
          newFileSizeBytes: bytes.length);
      if (!ok) {
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Storage full. Upgrade to upload a logo.')));
        return;
      }
      final result = await ref.read(storageServiceProvider).uploadFile(
          bucket: AppConfig.bucketBusinessLogos,
          bytes: bytes,
          // mimeType: 'image/png');
          mimeType: resolvedMimeType);
      await ref.read(storageTrackingServiceProvider).recordUpload(
          businessId: biz.id,
          uploadedBy: biz.ownerUid ?? '',
          bucket: AppConfig.bucketBusinessLogos,
          filePath: result.url.split('/').last,
          // fileName: 'business_logo.png',
          fileName: 'scaled_shiva wallpaper.png',
          fileSizeBytes: result.fileSizeBytes,
          fileType: 'image',
          entityType: 'business_logo');

      await ref
          .read(updateBusinessNotifierProvider.notifier)
          .update(biz.copyWith(logoUrl: result.url));
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted)
        setState(() {
          _uploading = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;
    final taxCfg = CountryTaxRegistry.forCountry(biz?.countryCode);

    return Scaffold(
      appBar: AppBar(title: const Text('Business Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Business Logo', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          StorageGuard(
              child: GestureDetector(
                  onTap: _uploading ? null : _pickAndUploadLogo,
                  child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border)),
                      clipBehavior: Clip.antiAlias,
                      child: _uploading
                          ? const Center(child: CircularProgressIndicator())
                          : (biz?.logoUrl != null)
                              ? Image.network(biz!.logoUrl!, fit: BoxFit.cover)
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 36,
                                        color: Colors.grey,
                                      ),
                                      Text('Add Logo',
                                          style: TextStyle(color: Colors.grey)),
                                    ])))),
          const SizedBox(height: 24),
          Text('Tax Identification',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ListTile(
            title: Text(taxCfg.taxIdLabel),
            subtitle: Text(biz?.gstin ?? 'Not set'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.taxCodes),
          ),
          const SizedBox(height: 24),
          Text('Compliance', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          SwitchListTile(
              title: const Text('E-invoicing (IRN)'),
              subtitle: const Text('Requires a GSP account to go live'),
              value: biz?.einvoiceEnabled ?? false,
              onChanged: (v) => ref
                  .read(updateBusinessNotifierProvider.notifier)
                  .update(biz!.copyWith(ewayBillEnabled: v))),
          if (biz?.ewayBillEnabled == true)
            ListTile(
                title: const Text('E-way Bill Threshold'),
                subtitle: Text(
                    'Rs.${((biz?.ewayBillThreshold ?? 5000000) / 100).toStringAsFixed(0)}'),
                trailing: const Icon(Icons.edit_outlined),
                onTap: () async {
                  final ctrl = TextEditingController(
                      text: ((biz?.ewayBillThreshold ?? 5000000) / 100)
                          .toStringAsFixed(0));
                  final result = await showDialog<String>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                              title: const Text('E-Way Bill Threshold (Rs.)'),
                              content: TextField(
                                  controller: ctrl,
                                  keyboardType: TextInputType.number),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text('Cancel')),
                                ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(ctx, ctrl.text),
                                    child: const Text('Save')),
                              ]));

                  if (result != null && biz != null) {
                    final paise =
                        ((double.tryParse(result) ?? 500) * 100).round();
                    ref
                        .read(updateBusinessNotifierProvider.notifier)
                        .update(biz.copyWith(ewayBillThreshold: paise));
                  }
                }),
        ],
      ),
    );
  }
}
