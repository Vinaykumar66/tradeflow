import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tradeflow/core/router/app_router.dart';
import 'package:tradeflow/features/business/application/business_providers.dart'
    as activeBusinessProvider;
import 'package:tradeflow/shared/models/business.dart';
import 'package:tradeflow/shared/models/license_tier.dart';
import '../../../core/config/app_config.dart';
import '../../../core/constants/permission_keys.dart';
import '../../../core/di/repository_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/auth/application/auth_providers.dart' as AuthProvider;
import '../../../shared/models/product.dart';
import '../../../shared/models/tax_code.dart';
import '../../../shared/widgets/field_guard.dart';
import '../../../shared/widgets/storage_guard.dart';
import '../application/catalog_providers.dart';
import 'package:go_router/go_router.dart';
import '../../admin/application/tax_code_providers.dart';

class AddEditProductScreen extends ConsumerStatefulWidget {
  final Product? product;
  final String? initialBarcode;
  const AddEditProductScreen(
      {super.key, required this.product, this.initialBarcode});
  @override
  ConsumerState<AddEditProductScreen> createState() =>
      _AddEditProductScreenState();
}

class _AddEditProductScreenState extends ConsumerState<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _skuCtrl = TextEditingController();
  final _barcodeCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();
  final _brandCtrl = TextEditingController();
  final _unitCtrl = TextEditingController(text: 'pcs');
  final _costCtrl = TextEditingController(text: '0.00');
  final _sellCtrl = TextEditingController(text: '0.00');
  final _mrpCtrl = TextEditingController(text: '0.00');
  final _taxCtrl = TextEditingController(text: '18');
  final _stockCtrl = TextEditingController(text: '0');
  final _reorderCtrl = TextEditingController(text: '10');
  final _descCtrl = TextEditingController();
  final _hsnSacCtrl = TextEditingController();
  final _commodityCtrl = TextEditingController();
  String? _selectedTaxCodeId;
  bool _taxInclusive = false;

  File? _pickedImage;
  String? _existingImageUrl;
  double _uploadProgress = 0;
  bool _uploading = false;
  bool _trackInventory = true;
  DateTime? _expiryDate;
  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) _prefill(widget.product!);
    // Pre-fill barcode when scanning adds a new product
    // widget.initialBarcode comes from extra: code in BarcodeHandler
    if (widget.initialBarcode != null)
      _barcodeCtrl.text = widget.initialBarcode!;
  }

  void _prefill(Product p) {
    _nameCtrl.text = p.name;
    _skuCtrl.text = p.sku;
    _barcodeCtrl.text = p.barcode ?? '';
    _categoryCtrl.text = p.category ?? '';
    _brandCtrl.text = p.brand ?? '';
    _unitCtrl.text = p.unit ?? 'pcs';
    _costCtrl.text = (p.costPrice / 100).toStringAsFixed(2);
    _sellCtrl.text = (p.sellingPrice / 100).toStringAsFixed(2);
    _mrpCtrl.text = (p.mrp / 100).toStringAsFixed(2);
    _taxCtrl.text = p.taxRate.toString();
    _stockCtrl.text = p.stockQty.toString();
    _reorderCtrl.text = p.reorderLevel.toString();
    _descCtrl.text = p.description ?? '';
    _trackInventory = p.trackInventory;
    _expiryDate = p.expiryDate;
    _existingImageUrl = p.imageUrl;
    _hsnSacCtrl.text = p.hsnSacCode ?? '';
    _commodityCtrl.text = p.commodityCode ?? '';
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtrl,
      _skuCtrl,
      _barcodeCtrl,
      _categoryCtrl,
      _brandCtrl,
      _unitCtrl,
      _costCtrl,
      _sellCtrl,
      _mrpCtrl,
      _taxCtrl,
      _stockCtrl,
      _reorderCtrl,
      _descCtrl,
      _hsnSacCtrl,
      _commodityCtrl
    ]) c.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(
        source: source, maxWidth: 800, maxHeight: 800, imageQuality: 85);
    if (picked != null) setState(() => _pickedImage = File(picked.path));
  }

  Future<String?> _uploadImage(String bizId) async {
    if (_pickedImage == null) return _existingImageUrl;
    final bytes;
    Uint8List? _selectedImageBytes;

    if (kIsWeb) _selectedImageBytes = await _pickedImage!.readAsBytes();
    bytes = await _pickedImage!.readAsBytes();
    final uid = ref.read(AuthProvider.currentSupabaseUserProvider)?.id ?? '';

    // STORAGE CHECK: verify quota before uploading
    final biz =
        ref.read(activeBusinessProvider.activeBusinessProvider).asData?.value;
    if (biz != null) {
      final ok = await ref.read(storageTrackingServiceProvider).hasQuota(
            businessId: bizId,
            limitBytes: biz.licenseTier.storageLimitBytes,
            newFileSizeBytes: bytes.length,
          );
      if (!ok) {
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text('Storage full. Upgrade your plan to upload photos.'),
              backgroundColor: AppColors.error));
        return _existingImageUrl;
      }
    }

    setState(() {
      _uploading = true;
      _uploadProgress = 0;
    });
    try {
      // UPLOAD to Cloudflare R2
      final result = await ref.read(storageServiceProvider).uploadFile(
            bucket: AppConfig.bucketProductImages,
            bytes: kIsWeb ? _selectedImageBytes : bytes,
            mimeType: 'image/jpeg',
          );

      // RECORD USAGE for storage quota tracking
      await ref.read(storageTrackingServiceProvider).recordUpload(
            businessId: bizId,
            uploadedBy: uid,
            bucket: AppConfig.bucketProductImages,
            filePath: result.url.split('/').last,
            fileName: '${_nameCtrl.text.trim()}_photo.jpg',
            fileSizeBytes: result.fileSizeBytes,
            fileType: 'image',
            entityType: 'product',
          );

      return result.url;
    } finally {
      setState(() => _uploading = false);
    }
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    // ── FIX 1: Get bizId safely from already-loaded provider ─────────────
    final biz =
        ref.read(activeBusinessProvider.activeBusinessProvider).asData?.value;
    final bizId = biz?.id ?? '';

    // Guard: never save with empty bizId — will be blocked by RLS silently
    if (bizId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Business not found. Please restart the app.'),
          backgroundColor: Colors.red));
      return;
    }

    final uid = ref.read(AuthProvider.currentSupabaseUserProvider)?.id ?? '';

    // Upload image — only runs if user picked one
    final String? imageUrl = await _uploadImage(bizId);

    // Convert Rs. display values back to paise for storage
    final cost = ((double.tryParse(_costCtrl.text) ?? 0) * 100).toInt();
    final sell = ((double.tryParse(_sellCtrl.text) ?? 0) * 100).toInt();
    final mrp = ((double.tryParse(_mrpCtrl.text) ?? 0) * 100).toInt();

    final product = Product(
      id: _isEditing ? widget.product!.id : '',
      businessId: bizId,
      name: _nameCtrl.text.trim(),
      sku: _skuCtrl.text.trim(),
      barcode:
          _barcodeCtrl.text.trim().isEmpty ? null : _barcodeCtrl.text.trim(),
      category:
          _categoryCtrl.text.trim().isEmpty ? null : _categoryCtrl.text.trim(),
      brand: _brandCtrl.text.trim().isEmpty ? null : _brandCtrl.text.trim(),
      unit: _unitCtrl.text.trim(),
      costPrice: cost,
      sellingPrice: sell,
      mrp: mrp,
      taxRate: double.tryParse(_taxCtrl.text) ?? 18.0,
      stockQty: int.tryParse(_stockCtrl.text) ?? 0,
      reorderLevel: int.tryParse(_reorderCtrl.text) ?? 10,
      description: _descCtrl.text.trim().isEmpty ? '' : _descCtrl.text.trim(),
      imageUrl: imageUrl,
      trackInventory: _trackInventory,
      expiryDate: _expiryDate,
      createdAt: widget.product?.createdAt ?? DateTime.now(),
      createdBy: widget.product?.createdBy ?? uid,
      taxCodeId: _selectedTaxCodeId ?? '',
      hsnSacCode:
          _hsnSacCtrl.text.trim().isEmpty ? null : _hsnSacCtrl.text.trim(),
      commodityCode: _commodityCtrl.text.trim().isEmpty
          ? null
          : _commodityCtrl.text.trim(),
    );

    debugPrint('Saving product: ${product.name} for bizId: $bizId');

    // ── FIX 2: Wrap save in try/catch so errors are shown to user ────────
    try {
      await ref.read(saveProductNotifierProvider.notifier).save(product);
      debugPrint('Product saved successfully');
      // if (mounted) Navigator.pop(context);
      if (mounted) context.go(AppRoutes.catalog);
    } catch (e) {
      debugPrint('Product save error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to save product: $e'),
            backgroundColor: Colors.red));
      }
    }
  }

  // Future<void> _onSubmit() async {
  //   if (!_formKey.currentState!.validate()) {
  //     return;
  //   }
  //   final bizId = ref
  //           .read(activeBusinessProvider.activeBusinessProvider)
  //           .asData
  //           ?.value
  //           ?.id ??
  //       '';
  //   final uid = ref.read(AuthProvider.currentSupabaseUserProvider)?.id ?? '';
  //   final String? imageUrl = await _uploadImage(bizId);

  //   // Convert Rs. display values back to paise for storage
  //   final cost = ((double.tryParse(_costCtrl.text) ?? 0) * 100).toInt();
  //   final sell = ((double.tryParse(_sellCtrl.text) ?? 0) * 100).toInt();
  //   final mrp = ((double.tryParse(_mrpCtrl.text) ?? 0) * 100).toInt();

  //   final product = Product(
  //     id: _isEditing ? widget.product!.id : '',
  //     businessId: bizId,
  //     name: _nameCtrl.text.trim(),
  //     sku: _skuCtrl.text.trim(),
  //     barcode:
  //         _barcodeCtrl.text.trim().isEmpty ? null : _barcodeCtrl.text.trim(),
  //     category:
  //         _categoryCtrl.text.trim().isEmpty ? null : _categoryCtrl.text.trim(),
  //     brand: _brandCtrl.text.trim().isEmpty ? null : _brandCtrl.text.trim(),
  //     unit: _unitCtrl.text.trim(),
  //     costPrice: cost,
  //     sellingPrice: sell,
  //     mrp: mrp,
  //     taxRate: double.tryParse(_taxCtrl.text) ?? 18.0,
  //     stockQty: int.tryParse(_stockCtrl.text) ?? 0,
  //     reorderLevel: int.tryParse(_reorderCtrl.text) ?? 10,
  //     description: _descCtrl.text.trim().isEmpty ? ' ' : _descCtrl.text.trim(),
  //     imageUrl: imageUrl,
  //     trackInventory: _trackInventory,
  //     expiryDate: _expiryDate,
  //     createdAt: widget.product?.createdAt ?? DateTime.now(),
  //     createdBy: widget.product?.createdBy ?? uid,
  //   );
  //   await ref.read(saveProductNotifierProvider.notifier).save(product);
  //   if (mounted) Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    final isSaving = ref.watch(saveProductNotifierProvider) is AsyncLoading;
    final sym = ref
            .watch(activeBusinessProvider.activeBusinessProvider)
            .asData
            ?.value
            ?.currencySymbol ??
        'Rs.';
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF0E4375), // Changes only the back button color
        ),
        // foregroundColor:  ,
        backgroundColor: Color(0xF0FFFFFF),
        title: Text(
            // style: TextStyle(color: Color(0xFF0E4375)),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
            _isEditing ? 'Edit Product' : 'Add Product'),
        actions: [
          TextButton(
              onPressed: (isSaving || _uploading) ? null : _onSubmit,
              child: (isSaving || _uploading)
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : Text('SAVE',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.primary))
              // style: TextStyle(
              //     color: ., fontWeight: FontWeight.bold)),
              )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          // StorageGuard wraps the photo picker
          StorageGuard(
            child: GestureDetector(
              onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (_) => SafeArea(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                        ListTile(
                            leading: const Icon(Icons.camera_alt_outlined),
                            title: const Text('Take a photo'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);
                            }),
                        ListTile(
                            leading: const Icon(Icons.photo_library_outlined),
                            title: const Text('Choose from gallery'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);
                            }),
                      ]))),
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border)),
                clipBehavior: Clip.antiAlias,
                child: _uploading
                    ? Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            CircularProgressIndicator(value: _uploadProgress),
                            const SizedBox(height: 8),
                            Text('${(_uploadProgress * 100).toInt()}%'),
                          ]))
                    : _pickedImage != null
                        ? Image.file(_pickedImage!,
                            fit: BoxFit.cover, width: double.infinity)
                        : _existingImageUrl != null
                            ? Image.network(_existingImageUrl!,
                                fit: BoxFit.cover, width: double.infinity)
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Icon(Icons.add_photo_alternate_outlined,
                                        size: 48, color: Colors.grey),
                                    Text('Tap to add photo',
                                        style: TextStyle(color: Colors.grey)),
                                  ]),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Basic fields
          Text('Basic Details', style: AppTextStyles.h3),
          const SizedBox(height: 12),
          _f(_nameCtrl, 'Product Name *',
              validator: (v) => v!.trim().isEmpty ? 'Name required' : null),
          _f(_skuCtrl, 'SKU *',
              validator: (v) => v!.trim().isEmpty ? 'SKU required' : null),
          _f(_barcodeCtrl, 'Barcode (optional)'),
          _f(_categoryCtrl, 'Category (optional)'),
          _f(_brandCtrl, 'Brand (optional)'),
          _f(_unitCtrl, 'Unit (pcs/kg/litre/box)'),
          const SizedBox(height: 20),

          // Pricing
          // Text('Pricing (Rs.)', style: AppTextStyles.h3),
          Text('Pricing ($sym)', style: AppTextStyles.h3),
          const SizedBox(height: 12),

          // Cost price - FieldGuard hides from Salesperson
          // logSensitiveView() when Admin taps this field
          FieldGuard(
            fieldKey: AppFieldKeys.productCostPrice,
            readOnlyChild: ListTile(
                title: const Text('Cost Price'),
                // trailing: Text('Rs. ${_costCtrl.text}',
                trailing: Text('$sym. ${_costCtrl.text}',
                    style: const TextStyle(color: Colors.grey))),
            child: GestureDetector(
              onTap: () async {
                // AUDIT: log when sensitive cost price field is accessed
                final user =
                    ref.read(AuthProvider.currentAppUserProvider).asData?.value;
                final biz = ref
                        .read(activeBusinessProvider.activeBusinessProvider)
                        .asData
                        ?.value
                        ?.id ??
                    '';
                '';
                if (user != null && widget.product != null) {
                  await ref.read(auditServiceProvider).logSensitiveView(
                        userId: user.id,
                        userName: user.name,
                        businessId: biz,
                        tableName: 'products',
                        recordId: widget.product!.id,
                        fieldName: AppFieldKeys.productCostPrice,
                      );
                }
              },
              child:
                  // _f(_costCtrl, 'Cost Price (Rs.)', type: TextInputType.number),
                  _f(_costCtrl, 'Cost Price ($sym.)',
                      type: TextInputType.number),
            ),
          ),
          // _f(_sellCtrl, 'Selling Price (Rs.) *',
          _f(_sellCtrl, 'Selling Price ($sym.) *',
              type: TextInputType.number,
              validator: (v) =>
                  v!.trim().isEmpty ? 'Selling price required' : null),
          _f(_mrpCtrl, 'MRP ($sym.)', type: TextInputType.number),
          const SizedBox(height: 20),

          // Tax
          //commenting to fetch the available tax code in the data base configured by the admin
          //if there is no tax code found it falls back to free field
          // Text('Tax', style: AppTextStyles.h3),
          // const SizedBox(height: 12),
          // FieldGuard(
          //   fieldKey: AppFieldKeys.productTaxRate,
          //   child: _f(_taxCtrl, 'Tax Rate % (0/5/12/18/28)',
          //       type: TextInputType.number),
          //   readOnlyChild: ListTile(
          //       title: const Text('Tax Rate'),
          //       trailing: Text('${_taxCtrl.text}%',
          //           style: const TextStyle(color: Colors.grey))),
          // ),

          //commenting to fetch the available tax code in the data base configured by the admin

          Consumer(builder: (context, ref, _) {
            final codes = ref.watch(taxCodeListProvider).asData?.value ?? [];
            final biz = ref
                .watch(activeBusinessProvider.activeBusinessProvider)
                .asData
                ?.value;
            if (codes.isEmpty) {
              //No tax codes configured - keep the original manual field

              return _f(_taxCtrl, 'Tax Rate % (0/5/12/18/28)',
                  type: TextInputType.number);
            }

            if (biz?.countryCode != 'IN') {
              return _f(_commodityCtrl, 'Commodity Code', validator: null);
            }

            if (biz?.countryCode == 'IN') {
              return _f(_hsnSacCtrl, 'HSN/SAC Code', validator: null);
            }

            return DropdownButtonFormField<String>(
                initialValue: _selectedTaxCodeId,
                decoration: const InputDecoration(labelText: 'Tax Code'),
                items: codes
                    .map((c) => DropdownMenuItem(
                        value: c.id, child: Text(c.displayLabel)))
                    .toList(),
                onChanged: (id) {
                  final c = codes.firstWhere((c) => c.id == id);
                  setState(() {
                    _selectedTaxCodeId = id;
                    _taxCtrl.text = c.rate.toString();
                    _taxInclusive = c.isInclusive;
                  });
                });
          }),

          const SizedBox(height: 20),

          // Inventory
          Text('Inventory', style: AppTextStyles.h3),
          const SizedBox(height: 12),
          SwitchListTile(
              title: const Text('Track Inventory'),
              subtitle: const Text('Turn off for services'),
              value: _trackInventory,
              onChanged: (v) => setState(() => _trackInventory = v)),
          if (_trackInventory) ...[
            _f(_stockCtrl, 'Current Stock Quantity',
                type: TextInputType.number),
            _f(_reorderCtrl, 'Reorder Alert Level', type: TextInputType.number),
            ListTile(
                leading: const Icon(Icons.calendar_today_outlined),
                title: Text(_expiryDate == null
                    ? 'Set Expiry Date (optional)'
                    : 'Expiry: ${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}'),
                onTap: () async {
                  final d = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.now().add(const Duration(days: 365)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 3650)));
                  if (d != null) setState(() => _expiryDate = d);
                },
                trailing: _expiryDate != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _expiryDate = null))
                    : null),
          ],
          const SizedBox(height: 20),

          // Description
          Text('Description (optional)', style: AppTextStyles.h3),
          const SizedBox(height: 12),
          TextFormField(
              controller: _descCtrl,
              maxLines: 4,
              decoration:
                  const InputDecoration(hintText: 'Product description...')),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }

  Widget _f(TextEditingController ctrl, String label,
          {TextInputType type = TextInputType.text,
          String? Function(String?)? validator}) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
              controller: ctrl,
              keyboardType: type,
              validator: validator,
              decoration: InputDecoration(labelText: label)));
}

//***************************************************** */

// import 'package:flutter/material.dart';
// import '../../../shared/models/product.dart';

// class AddEditProductScreen extends StatelessWidget {
//   final Product? product;
//   final String? initialBarcode;
//   const AddEditProductScreen({
//     super.key,
//     required this.product,
//     required this.initialBarcode,
//   });

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//             title: Text(product == null ? 'Add Product' : 'Edit Product')),
//         body: const Center(child: Text('Coming soon')),
//       );
// }
