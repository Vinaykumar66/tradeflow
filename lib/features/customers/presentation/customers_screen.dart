import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/constants/permission_keys.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../shared/models/customer.dart';
import '../../../shared/widgets/permission_guard.dart';
import '../application/customer_providers.dart';
import '../data/customer_repository.dart';

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return CustomerRepository();
});

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});
  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  final _searchCtrl = TextEditingController();
  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(filteredCustomersProvider);
    final overdueList = ref.watch(overdueCustomersProvider).valueOrNull ?? [];
    final showOverdue = ref.watch(showOverdueOnlyProvider);
    final bizId = ref.watch(activeBusinessIdProvider) ?? '';

    return Scaffold(
      body: Column(children: [
        // Overdue alert banner
        if (overdueList.isNotEmpty)
          GestureDetector(
            onTap: () => ref.read(showOverdueOnlyProvider.notifier).toggle(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.alertRed.withValues(alpha: 0.1),
              child: Row(children: [
                const Icon(Icons.warning_amber_rounded,
                    color: AppColors.alertRed, size: 18),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(
                        '${overdueList.length} customer(s) over credit limit',
                        style: const TextStyle(
                            color: AppColors.alertRed,
                            fontSize: 13,
                            fontWeight: FontWeight.w500))),
                Text(showOverdue ? 'Show All' : 'View',
                    style: const TextStyle(
                        color: AppColors.alertRed,
                        fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
                hintText: 'Search by name, phone or GSTIN...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          ref
                              .read(customerSearchQueryProvider.notifier)
                              .clear();
                        })
                    : null),
            onChanged: (v) =>
                ref.read(customerSearchQueryProvider.notifier).set(v),
          ),
        ),
        // Customer list
        Expanded(
            child: customersAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (customers) => customers.isEmpty
              ? const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.people_outline, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No customers yet'),
                      Text('Tap + to add your first customer',
                          style: TextStyle(color: Colors.grey)),
                    ]))
              : ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (_, i) => _CustomerTile(
                      customer: customers[i], bizId: bizId, ref: ref)),
        )),
      ]),
      floatingActionButton: PermissionGuard(
        screenKey: AppScreenKeys.customers,
        action: PermissionAction.create,
        child: FloatingActionButton.extended(
          onPressed: () => context.push(AppRoutes.addCustomer),
          icon: const Icon(Icons.person_add_outlined),
          label: const Text('Add Customer'),
        ),
      ),
    );
  }
}

class _CustomerTile extends StatelessWidget {
  final Customer customer;
  final String bizId;
  final WidgetRef ref;
  const _CustomerTile(
      {required this.customer, required this.bizId, required this.ref});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const DrawerMotion(), children: [
        PermissionGuard(
          screenKey: AppScreenKeys.customers,
          action: PermissionAction.delete,
          child: SlidableAction(
              onPressed: (_) => _archive(context),
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              icon: Icons.archive_outlined,
              label: 'Archive'),
        ),
      ]),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: customer.isOverCreditLimit
                ? AppColors.alertRed.withValues(alpha: 0.15)
                : AppColors.primary.withValues(alpha: 0.1),
            child: Text(customer.name.substring(0, 1).toUpperCase(),
                style: TextStyle(
                    color: customer.isOverCreditLimit
                        ? AppColors.alertRed
                        : AppColors.primary,
                    fontWeight: FontWeight.bold)),
          ),
          title: Text(customer.name,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (customer.phone != null)
              Text(customer.phone!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            if (customer.hasOutstanding)
              Text('Outstanding: ${customer.formattedOutstanding}',
                  style: TextStyle(
                      fontSize: 12,
                      color: customer.isOverCreditLimit
                          ? AppColors.alertRed
                          : AppColors.textSecondary,
                      fontWeight: customer.isOverCreditLimit
                          ? FontWeight.bold
                          : FontWeight.normal)),
          ]),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(AppRoutes.customerDetail, extra: customer),
        ),
      ),
    );
  }

  Future<void> _archive(BuildContext context) async {
    final ok = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
                title: const Text('Archive Customer?'),
                content: Text('${customer.name} will be hidden from the list.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Archive',
                          style: TextStyle(color: Colors.red))),
                ]));
    if (ok == true)
      await ref
          .read(customerRepositoryProvider)
          .archiveCustomer(bizId, customer.id);
  }
}

// import 'package:flutter/material.dart';

// class CustomersScreen extends StatelessWidget {
//   const CustomersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xF0FFFFFF),
//         title: const Text(
//             style: TextStyle(color: Colors.black), 'Customer screen'),
//       ),
//       body: Center(
//         child: Text('Customer screen - coming soon'),
//       ),
//     );
//   }
// }
