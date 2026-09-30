import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../application/vendor_providers.dart';
import '../../../core/router/app_router.dart';

class VendorsScreen extends ConsumerWidget {
  const VendorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendorsAsync = ref.watch(vendorListProvider);

    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFFA9A9A9)),
          title: const Text(
              style: TextStyle(color: Color(0xFFA9A9A9)), 'Vendors')),
      body: vendorsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (vendors) => vendors.isEmpty
            ? const Center(
                child: Text('No vendor yet. Tap + to add one.',
                    style: TextStyle(color: Colors.grey)))
            : ListView.builder(
                itemCount: vendors.length,
                itemBuilder: (_, i) {
                  final v = vendors[i];
                  return ListTile(
                      leading: CircleAvatar(
                          child: Text(v.name.isNotEmpty
                              ? v.name[0].toUpperCase()
                              : '?')),
                      title: Text(v.name),
                      subtitle: Text(
                          v.outstanding > 0
                              ? 'Outstanding: Rs.${(v.outstanding / 100).toStringAsFixed(2)}'
                              : v.phone ?? 'No phone',
                          style: TextStyle(
                              color: v.outstanding > 0 ? Colors.orange : null,
                              fontWeight:
                                  v.outstanding > 0 ? FontWeight.w600 : null)),
                      // Only shown when money is actually owed — same gating condition
                      // used for Record Payment on Invoice Detail (balanceDue > 0).
                      trailing: v.outstanding > 0
                          ? TextButton(
                              onPressed: () =>
                                  context.push(AppRoutes.payVendor, extra: v),
                              child: const Text('Pay'))
                          : null,
                      onTap: () =>
                          context.push(AppRoutes.editVendor, extra: v));
                }),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(AppRoutes.addVendor),
          icon: const Icon(Icons.add),
          label: const Text('Add Vendor')),
    );
  }
}
