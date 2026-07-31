import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/repository_providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../features/auth/application/auth_providers.dart';
import '../../features/business/application/business_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class _Tab {
  final String path, label;
  final IconData icon, activeIcon;
  const _Tab(
      {required this.path,
      required this.label,
      required this.icon,
      required this.activeIcon});
}

const _tabs = [
  _Tab(
      path: AppRoutes.dashboard,
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded),
  _Tab(
      path: AppRoutes.inventory,
      label: 'Inventory',
      icon: Icons.inventory_2_outlined,
      activeIcon: Icons.inventory_2_rounded),
  _Tab(
      path: AppRoutes.customers,
      label: 'Customers',
      icon: Icons.people_outline,
      activeIcon: Icons.people_rounded),
  _Tab(
      path: AppRoutes.invoices,
      label: 'Invoices',
      icon: Icons.receipt_outlined,
      activeIcon: Icons.receipt_rounded),
  _Tab(
      path: AppRoutes.reports,
      label: 'Reports',
      icon: Icons.bar_chart_outlined,
      activeIcon: Icons.bar_chart_rounded),
  _Tab(
      path: AppRoutes.admin,
      label: 'Settings',
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings_rounded),
];

class AppShell extends ConsumerWidget {
  final Widget child;
  const AppShell({super.key, required this.child});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizAsync = ref.watch(activeBusinessProvider);
    final bizName = bizAsync.valueOrNull?.name ?? 'TradeFlow';

//Current tab selection
    final location = GoRouterState.of(context).matchedLocation;
    int selected = _tabs.indexWhere((t) => location.startsWith(t.path));
    if (selected < 0) {
      selected = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(bizName),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.profile),
            icon: const Icon(Icons.account_circle_outlined),
          ),
          IconButton(
            onPressed: () async {
              //Audit layer : log logout before signing out
              //if we signout first audit write may fail
              final user = ref.read(currentAppUserProvider).asData?.value;
              final biz = ref.read(activeBusinessIdProvider) ?? '';
              if (user != null) {
                await ref.read(auditServiceProvider).logLogout(
                      userId: user.id,
                      userName: user.name,
                      businessId: biz,
                    );
              }
              //signout after audit is confirmed written
              await ref.read(loginNotifierProvider.notifier).signOut();
              //GoRouter redirect handles navigation to /login
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primary.withValues(alpha: 0.12),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (i) => context.go(_tabs[i].path),
        destinations: _tabs
            .map((t) => NavigationDestination(
                  icon: Icon(t.icon),
                  selectedIcon: Icon(t.activeIcon, color: AppColors.primary),
                  label: t.label,
                ))
            .toList(),
      ),
    );
  }
}
