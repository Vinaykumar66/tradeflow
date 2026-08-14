// lib/features/customers/presentation/customer_picker_screen.dart
//
// Used from Create Invoice screen — returns the selected Customer
// via context.pop(customer), or null if the user backs out.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/models/customer.dart';
import '../application/customer_providers.dart';

class CustomerPickerScreen extends ConsumerStatefulWidget {
  const CustomerPickerScreen({super.key});

  @override
  ConsumerState<CustomerPickerScreen> createState() =>
      _CustomerPickerScreenState();
}

class _CustomerPickerScreenState extends ConsumerState<CustomerPickerScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final all = ref.watch(customerListProvider).asData?.value ?? [];

    final filtered = _query.isEmpty
        ? all
        : all
            .where((c) =>
                c.name.toLowerCase().contains(_query.toLowerCase()) ||
                (c.phone?.contains(_query) ?? false))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Customer'),
        leading: IconButton(
            icon: const Icon(Icons.close), onPressed: () => context.pop(null)),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
              controller: _searchCtrl,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: 'Search name or phone...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() {
                                _searchCtrl.clear();
                                _query = '';
                              }))
                      : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (v) => setState(() => _query = v)),
        ),
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Icon(Icons.people_outline,
                          size: 48, color: Colors.grey),
                      const SizedBox(height: 12),
                      Text(
                          _query.isEmpty
                              ? 'No customers yet'
                              : 'No match for "$_query"',
                          style: const TextStyle(color: Colors.grey)),
                    ]))
              : ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, i) {
                    final c = filtered[i];
                    return ListTile(
                        leading: CircleAvatar(
                            child: Text(c.name.isNotEmpty
                                ? c.name[0].toUpperCase()
                                : '?')),
                        title: Text(c.name),
                        subtitle: Text(c.phone ?? 'No phone'),
                        onTap: () => context.pop(c));
                  }),
        ),
      ]),
    );
  }
}
