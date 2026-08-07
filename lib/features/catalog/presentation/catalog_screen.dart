// lib/features/catalog/presentation/catalog_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:tradeflow/shared/widgets/barcode_handler.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/product.dart';
import '../../../shared/widgets/stock_badge.dart';
import '../application/catalog_providers.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});
  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ── FIX 1: Use activeBusinessProvider as single source of truth ──────
    final bizAsync = ref.watch(activeBusinessProvider);
    final biz = bizAsync.asData?.value;
    final bizId = biz?.id;

    // While business is loading show spinner
    if (bizAsync is AsyncLoading) {
      return Scaffold(
          appBar: AppBar(title: const Text('Products')),
          body: const Center(child: CircularProgressIndicator()));
    }

    // Business not found
    if (bizId == null) {
      return Scaffold(
          appBar: AppBar(title: const Text('Products')),
          body: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.business_outlined, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            const Text('No business found'),
            const SizedBox(height: 8),
            const Text('Complete onboarding first.',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () => ref.invalidate(activeBusinessProvider),
                child: const Text('Retry')),
          ])));
    }

    // ── FIX 3: Watch ONE products provider only ───────────────────────────
    final productsAsync = ref.watch(productListProvider);

    // Build category list from loaded products
    final allProducts = productsAsync.asData?.value ?? [];
    final categories = allProducts
        .map((p) => p.category)
        .whereType<String>()
        .toSet()
        .toList()
      ..sort();

    // Filter products locally — no separate provider needed
    final filtered = allProducts.where((p) {
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (p.sku?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (p.barcode?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);
      final matchesCategory =
          _selectedCategory == null || p.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      body: Column(children: [
        // ── SEARCH BAR ────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Row(children: [
            Expanded(
                child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                  hintText: 'Search name, SKU or barcode...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() => _searchQuery = '');
                          })
                      : null),
              onChanged: (v) => setState(() => _searchQuery = v),
            )),
            const SizedBox(width: 8),
            IconButton.filled(
                onPressed: () => BarcodeHandler.scanAndNavigate(
                    context: context, ref: ref, title: 'Scan Product'),
                icon: const Icon(Icons.qr_code_scanner)),
          ]),
        ),

        // ── CATEGORY FILTER CHIPS ─────────────────────────────────────────
        if (categories.isNotEmpty)
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                FilterChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (_) =>
                        setState(() => _selectedCategory = null)),
                const SizedBox(width: 8),
                ...categories.map((cat) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                          label: Text(cat),
                          selected: _selectedCategory == cat,
                          onSelected: (_) =>
                              setState(() => _selectedCategory = cat)),
                    )),
              ],
            ),
          ),

        // ── PRODUCT LIST ──────────────────────────────────────────────────
        Expanded(
            child: productsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            Text('Error: $e', textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: () => ref.invalidate(productListProvider),
                child: const Text('Retry')),
          ])),
          data: (_) => filtered.isEmpty
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Icon(Icons.inventory_2_outlined,
                          size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(_searchQuery.isNotEmpty
                          ? 'No products match "$_searchQuery"'
                          : 'No products yet'),
                      const Text('Tap + to add your first product',
                          style: TextStyle(color: Colors.grey)),
                    ]))
              : ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => _ProductTile(
                      product: filtered[i], bizId: bizId, ref: ref)),
        )),
      ]),

      // ── FIX 2: FAB always visible — no PermissionGuard wrapper ──────────
      // PermissionGuard hides it while permissions load at Day 17
      // Add PermissionGuard back in Day 36 when permission system is built
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addProduct),
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
    );
  }
}

// ── PRODUCT TILE ──────────────────────────────────────────────────────────────
class _ProductTile extends StatelessWidget {
  final Product product;
  final String bizId;
  final WidgetRef ref;
  const _ProductTile(
      {required this.product, required this.bizId, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Slidable(
        startActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
              onPressed: (_) =>
                  context.push(AppRoutes.editProduct, extra: product),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: Icons.edit_outlined,
              label: 'Edit'),
        ]),
        endActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
              onPressed: (_) => _archive(context),
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              icon: Icons.archive_outlined,
              label: 'Archive'),
        ]),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: product.imageUrl != null
                      ? Image.network(product.imageUrl!,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _placeholder())
                      : _placeholder()),
              title: Text(product.name,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.sku != null)
                      Text('SKU: ${product.sku}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    // Stock badge
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: product.stockQty <= 0
                                ? Colors.red.shade50
                                : product.stockQty <= product.reorderLevel
                                    ? Colors.orange.shade50
                                    : Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text('Stock: ${product.stockQty}',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: product.stockQty <= 0
                                    ? Colors.red
                                    : product.stockQty <= product.reorderLevel
                                        ? Colors.orange
                                        : Colors.green))),
                  ]),
              trailing: Text(
                  // ── FIX 4: sellingPrice is in paise — divide by 100
                  // or keep as int if your model stores full rupees
                  'Rs.${product.sellingPrice}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 15)),
              onTap: () => context.push(AppRoutes.editProduct, extra: product)),
        ));
  }

  Widget _placeholder() => Container(
      width: 56,
      height: 56,
      color: Colors.grey.shade100,
      child: const Icon(Icons.inventory_2_outlined, color: Colors.grey));

  Future<void> _archive(BuildContext context) async {
    final ok = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
                title: const Text('Archive Product?'),
                content: Text('${product.name} will be hidden.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Archive',
                          style: TextStyle(color: Colors.red))),
                ]));
    if (ok == true) {
      await ref
          .read(archiveProductNotifierProvider.notifier)
          .archive(bizId, product.id);
    }
  }
}

//commented on 4.08.2026 replaced full code with above code
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tradeflow/features/business/application/business_providers.dart';
// import '../../../core/constants/permission_keys.dart';
// import '../../../core/router/app_router.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../features/auth/application/auth_providers.dart';
// import '../../../shared/models/product.dart';
// import '../../../shared/widgets/permission_guard.dart';
// import '../../../shared/widgets/stock_badge.dart';
// import '../application/catalog_providers.dart';
// import '../../business/application/business_providers.dart';

// class CatalogScreen extends ConsumerStatefulWidget {
//   const CatalogScreen({super.key});
//   @override
//   ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
// }

// class _CatalogScreenState extends ConsumerState<CatalogScreen> {
//   final _searchCtrl = TextEditingController();
//   @override
//   void dispose() {
//     _searchCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productsAsync = ref.watch(filteredProductsProvider);
//     final selectedCat = ref.watch(selectedProductCategoryProvider);
//     final bizId =
//         ref.watch(userBusinessListProvider).asData?.value.firstOrNull?.id ?? '';
//     debugPrint('CatalogScreen bizId: $bizId');

//     // Full diagnostic — remove after fixing
//     final authUser = ref.watch(currentSupabaseUserProvider);
//     // final bizId     = ref.watch(activeBusinessIdProvider);
//     final bizAsync = ref.watch(activeBusinessProvider);

//     debugPrint('=== CATALOG DIAGNOSTIC ===');
//     debugPrint('Auth user ID  : ${authUser?.id}');
//     debugPrint('Auth user email: ${authUser?.email}');
//     debugPrint('activeBusinessId: $bizId');
//     debugPrint('activeBusinessAsync: $bizAsync');
//     debugPrint('==========================');

//     // rest of your build

//     final allProducts = ref.watch(productListProvider).asData?.value ?? [];
//     final categories = allProducts
//         .map((p) => p.category)
//         .whereType<String>()
//         .toSet()
//         .toList()
//       ..sort();

//     return Scaffold(
//       body: Column(children: [
//         // Search bar
//         Padding(
//           padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
//           child: Row(children: [
//             Expanded(
//                 child: TextField(
//               controller: _searchCtrl,
//               decoration: InputDecoration(
//                   hintText: 'Search name, SKU or barcode...',
//                   prefixIcon: const Icon(Icons.search),
//                   suffixIcon: _searchCtrl.text.isNotEmpty
//                       ? IconButton(
//                           icon: const Icon(Icons.clear),
//                           onPressed: () {
//                             _searchCtrl.clear();
//                             ref
//                                 .read(productSearchQueryProvider.notifier)
//                                 .clear();
//                           })
//                       : null),
//               onChanged: (v) =>
//                   ref.read(productSearchQueryProvider.notifier).set(v),
//             )),
//             const SizedBox(width: 8),
//             // Scan button - opens barcode scanner (Day 19)
//             IconButton.filled(
//                 onPressed: () => context.push(AppRoutes.barcodeScanner),
//                 icon: const Icon(Icons.qr_code_scanner)),
//           ]),
//         ),
//         // Category filter chips
//         if (categories.isNotEmpty)
//           SizedBox(
//             height: 48,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               children: [
//                 FilterChip(
//                     label: const Text('All'),
//                     selected: selectedCat == null,
//                     onSelected: (_) => ref
//                         .read(selectedProductCategoryProvider.notifier)
//                         .set(null)),
//                 const SizedBox(width: 8),
//                 ...categories.map((cat) => Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: FilterChip(
//                           label: Text(cat),
//                           selected: selectedCat == cat,
//                           onSelected: (_) => ref
//                               .read(selectedProductCategoryProvider.notifier)
//                               .set(cat)),
//                     )),
//               ],
//             ),
//           ),
//         // Product list
//         Expanded(
//             child: productsAsync.when(
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (e, _) => Center(child: Text('Error: $e')),
//           data: (products) => products.isEmpty
//               ? const Center(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                       Icon(Icons.inventory_2_outlined,
//                           size: 64, color: Colors.grey),
//                       SizedBox(height: 16),
//                       Text('No products yet'),
//                       Text('Tap + to add your first product',
//                           style: TextStyle(color: Colors.grey)),
//                     ]))
//               : ListView.builder(
//                   itemCount: products.length,
//                   itemBuilder: (_, i) => _ProductTile(
//                       product: products[i], bizId: bizId, ref: ref)),
//         )),
//       ]),
//       // Add floating action button - hidden from Salesperson if no create permission
//       floatingActionButton: PermissionGuard(
//         screenKey: AppScreenKeys.catalog,
//         action: PermissionAction.create,
//         child: FloatingActionButton.extended(
//           onPressed: () => context.push(AppRoutes.addProduct),
//           icon: const Icon(Icons.add),
//           label: const Text('Add Product'),
//         ),
//       ),
//     );
//   }
// }

// class _ProductTile extends StatelessWidget {
//   final Product product;
//   final String bizId;
//   final WidgetRef ref;
//   const _ProductTile(
//       {required this.product, required this.bizId, required this.ref});
//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//       startActionPane: ActionPane(motion: const DrawerMotion(), children: [
//         PermissionGuard(
//           screenKey: AppScreenKeys.catalog,
//           action: PermissionAction.edit,
//           child: SlidableAction(
//               onPressed: (_) =>
//                   context.push(AppRoutes.editProduct, extra: product),
//               backgroundColor: AppColors.primary,
//               foregroundColor: Colors.white,
//               icon: Icons.edit_outlined,
//               label: 'Edit'),
//         ),
//       ]),
//       endActionPane: ActionPane(motion: const DrawerMotion(), children: [
//         PermissionGuard(
//           screenKey: AppScreenKeys.catalog,
//           action: PermissionAction.delete,
//           child: SlidableAction(
//               onPressed: (_) => _archive(context),
//               backgroundColor: AppColors.error,
//               foregroundColor: Colors.white,
//               icon: Icons.archive_outlined,
//               label: 'Archive'),
//         ),
//       ]),
//       child: Card(
//         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//         child: ListTile(
//           leading: ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: product.imageUrl != null
//                 ? Image.network(product.imageUrl!,
//                     width: 56,
//                     height: 56,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => _placeholder())
//                 : _placeholder(),
//           ),
//           title: Text(product.name,
//               style: const TextStyle(fontWeight: FontWeight.w600)),
//           subtitle:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text('SKU: ${product.sku}',
//                 style: const TextStyle(fontSize: 12, color: Colors.grey)),
//             const SizedBox(height: 4),
//             Row(children: [
//               StockBadge(product: product),
//               const SizedBox(width: 6),
//               ExpiryBadge(product: product),
//             ]),
//           ]),
//           trailing: Text('\$${product.sellingPrice.toStringAsFixed(2)}',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primary,
//                   fontSize: 15)),
//           onTap: () => context.push(AppRoutes.editProduct, extra: product),
//         ),
//       ),
//     );
//   }

//   Widget _placeholder() => Container(
//       width: 56,
//       height: 56,
//       color: AppColors.surfaceVariant,
//       child: const Icon(Icons.inventory_2_outlined, color: Colors.grey));
//   Future<void> _archive(BuildContext context) async {
//     final ok = await showDialog<bool>(
//         context: context,
//         builder: (_) => AlertDialog(
//                 title: const Text('Archive Product?'),
//                 content: Text('${product.name} will be hidden.'),
//                 actions: [
//                   TextButton(
//                       onPressed: () => Navigator.pop(context, false),
//                       child: const Text('Cancel')),
//                   TextButton(
//                       onPressed: () => Navigator.pop(context, true),
//                       child: const Text('Archive',
//                           style: TextStyle(color: Colors.red))),
//                 ]));
//     if (ok == true)
//       await ref
//           .read(archiveProductNotifierProvider.notifier)
//           .archive(bizId, product.id);
//   }
// }
