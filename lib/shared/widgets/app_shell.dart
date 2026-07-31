import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tradeflow/shared/models/permission.dart';
import '../../core/constants/permission_keys.dart';
import '../../core/di/repository_providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../features/admin/application/permission_providers.dart';
import '../../features/auth/application/auth_providers.dart';
import '../../features/business/application/business_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class _Tab {
  final String path, label, screenKey;
  final IconData icon, activeIcon;
  const _Tab(
      {required this.path,
      required this.label,
      required this.screenKey,
      required this.icon,
      required this.activeIcon});
}

const _allTabs = [
  _Tab(
      path: AppRoutes.dashboard,
      label: 'Home',
      screenKey: AppScreenKeys.dashboard,
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded),
  _Tab(
      path: AppRoutes.inventory,
      label: 'Inventory',
      screenKey: AppRoutes.inventory,
      icon: Icons.inventory_2_outlined,
      activeIcon: Icons.inventory_2_rounded),
  _Tab(
      path: AppRoutes.customers,
      label: 'Customers',
      screenKey: AppRoutes.customers,
      icon: Icons.people_outline,
      activeIcon: Icons.people_rounded),
  _Tab(
      path: AppRoutes.invoices,
      label: 'Invoices',
      screenKey: AppScreenKeys.invoices,
      icon: Icons.receipt_outlined,
      activeIcon: Icons.receipt_rounded),
  _Tab(
      path: AppRoutes.reports,
      label: 'Reports',
      screenKey: AppScreenKeys.reports,
      icon: Icons.bar_chart_outlined,
      activeIcon: Icons.bar_chart_rounded),
  _Tab(
      path: AppRoutes.admin,
      label: 'Settings',
      screenKey: AppScreenKeys.admin,
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

//Filter tabs by current user's view permissions

    final perms = ref.watch(currentRolePermissionsProvider).asData?.value;
    final visibleTabs = _allTabs.where((tab) {
      if (perms == null) {
        return true;
      } //return tab.screenKey == AppScreenKeys.dashboard;
      return perms.canView(tab.screenKey);
    }).toList();

// Selected tab index — safe calculation
    final location = GoRouterState.of(context).matchedLocation;
    // Step 1: try exact match first
    int selected = visibleTabs.indexWhere((t) => location.startsWith(t.path));
// Step 2: if no exact match, try prefix match
    // BUT skip single-character paths like '/' to avoid false matches
    if (selected < 0) {
      selected = visibleTabs.indexWhere(
        (t) => t.path.length > 1 && location.startsWith(t.path),
      );
    }
    // Step 3: if still no match (e.g. /profile, /upgrade, /admin/users)
    // default to 0 — never pass a negative value to NavigationBar
    if (selected < 0) selected = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(bizName),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.profile),
            icon: const Icon(Icons.account_circle_outlined),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
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
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: visibleTabs.length < 2
          ? null
          : NavigationBar(
              selectedIndex: selected,
              backgroundColor: AppColors.surface,
              indicatorColor: AppColors.primary.withValues(alpha: 0.12),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              onDestinationSelected: (i) => context.go(visibleTabs[i].path),
              destinations: visibleTabs
                  .map((t) => NavigationDestination(
                        icon: Icon(t.icon),
                        selectedIcon:
                            Icon(t.activeIcon, color: AppColors.primary),
                        label: t.label,
                      ))
                  .toList(),
            ),
    );
  }
}
