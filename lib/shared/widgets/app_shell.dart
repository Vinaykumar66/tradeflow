// lib/shared/widgets/app_shell.dart

import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tradeflow/core/di/repository_providers.dart';
import 'package:tradeflow/shared/models/permission.dart';
import '../../core/constants/permission_keys.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../features/auth/application/auth_providers.dart';
import '../../features/business/application/business_providers.dart';
import '../../features/admin/application/permission_providers.dart';

// ── NAVIGATION LAYOUT PREFERENCE ─────────────────────────────────────────────
// Remembers whether user prefers drawer or bottom tabs on mobile
// Web always uses drawer regardless of this setting
final navLayoutProvider = StateProvider<bool>((ref) => false);
final sidebarExpandedProvider = StateProvider<bool>((ref) => false);
// false = bottom tabs (default mobile)
// true  = side drawer

// ── TAB DEFINITION ────────────────────────────────────────────────────────────
class _Tab {
  final String path, label, screenKey;
  final IconData icon, activeIcon;
  const _Tab({
    required this.path,
    required this.label,
    required this.screenKey,
    required this.icon,
    required this.activeIcon,
  });
}

const _allTabs = [
  _Tab(
      path: AppRoutes.dashboard,
      label: 'Home',
      screenKey: AppScreenKeys.dashboard,
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded),
  _Tab(
      path: AppRoutes.catalog,
      label: 'Catalog',
      screenKey: AppScreenKeys.catalog,
      icon: Icons.storefront_outlined,
      activeIcon: Icons.storefront_rounded),
  _Tab(
      path: AppRoutes.inventory,
      label: 'Inventory',
      screenKey: AppScreenKeys.inventory,
      icon: Icons.inventory_2_outlined,
      activeIcon: Icons.inventory_2_rounded),
  _Tab(
      path: AppRoutes.customers,
      label: 'Customers',
      screenKey: AppScreenKeys.customers,
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

// ── APP SHELL ─────────────────────────────────────────────────────────────────
class AppShell extends ConsumerWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizName =
        ref.watch(activeBusinessProvider).asData?.value?.name ?? 'TradeFlow';
    final perms = ref.watch(currentRolePermissionsProvider).asData?.value;
    final useDrawer = ref.watch(navLayoutProvider);
    final screenWidth = MediaQuery.sizeOf(context).width;

    // Web or wide screen always uses drawer layout
    // Mobile uses whatever the user has toggled
    final isWideScreen = kIsWeb || screenWidth > 768;
    final showDrawer = isWideScreen || useDrawer;

    // Filter tabs by permissions — show all while loading
    final visibleTabs = _allTabs.where((tab) {
      if (perms == null) return true;
      return perms.canView(tab.screenKey);
    }).toList();

    // Safe selected index
    final location = GoRouterState.of(context).matchedLocation;
    int selected = visibleTabs
        .indexWhere((t) => t.path.length > 1 && location.startsWith(t.path));
    if (selected < 0) selected = 0;

    if (showDrawer) {
      // ── WEB / DRAWER LAYOUT ─────────────────────────────────────────
      return _DrawerLayout(
        child: child,
        bizName: bizName,
        visibleTabs: visibleTabs,
        selectedIndex: selected,
        isWideScreen: isWideScreen,
        ref: ref,
      );
    } else {
      // ── MOBILE BOTTOM TAB LAYOUT ────────────────────────────────────
      return _BottomTabLayout(
        child: child,
        bizName: bizName,
        visibleTabs: visibleTabs,
        selectedIndex: selected,
        ref: ref,
      );
    }
  }
}

// ── DRAWER LAYOUT (Web + Mobile drawer mode) ──────────────────────────────────
class _DrawerLayout extends ConsumerWidget {
  final Widget child;
  final String bizName;
  final List<_Tab> visibleTabs;
  final int selectedIndex;
  final bool isWideScreen;
  final WidgetRef ref;

  const _DrawerLayout({
    required this.child,
    required this.bizName,
    required this.visibleTabs,
    required this.selectedIndex,
    required this.isWideScreen,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(sidebarExpandedProvider);

    // Collapsed width: icons only
    // Expanded width: icons + labels
    const collapsedWidth = 64.0;
    const expandedWidth = 240.0;

    return isWideScreen
        ? Scaffold(
            // ── APP BAR ────────────────────────────────────────────────────────
            appBar: AppBar(
              title: Text(bizName),
              // Override default leading so hamburger is always visible
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                tooltip: isExpanded ? 'Collapse Menu' : 'Expand Menu',
                onPressed: () => ref
                    .read(sidebarExpandedProvider.notifier)
                    .state = !isExpanded,
              ),
              actions: [
                // Show toggle button only on mobile — switches back to bottom tabs
                if (!isWideScreen)
                  IconButton(
                    icon: const Icon(Icons.tab_outlined),
                    tooltip: 'Switch to Bottom Tabs',
                    onPressed: () =>
                        ref.read(navLayoutProvider.notifier).state = false,
                  ),
                IconButton(
                    icon: const Icon(Icons.account_circle_outlined),
                    onPressed: () => context.push(AppRoutes.profile)),
                IconButton(
                    icon: const Icon(Icons.logout),
                    tooltip: 'Log out',
                    onPressed: () => _logout(context, ref)),
              ],
            ),

            // ── BODY: Sidebar + Content in a Row ─────────────────────────────
            body: Row(children: [
              // ── PERSISTENT SIDEBAR ──────────────────────────────────────────
              AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  // Animate between collapsed and expanded widths
                  width: isExpanded ? expandedWidth : collapsedWidth,
                  decoration:
                      BoxDecoration(color: AppColors.surface, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(2, 0)),
                  ]),
                  child: Column(children: [
                    // ── SIDEBAR HEADER ────────────────────────────────────────
                    // AnimatedContainer(
                    //     duration: const Duration(milliseconds: 220),
                    //     height: 80,
                    //     color: AppColors.primary,
                    //     padding: const EdgeInsets.symmetric(horizontal: 12),
                    //     child:
                    //     Row(
                    //         mainAxisAlignment: isExpanded
                    //             ? MainAxisAlignment.start
                    //             : MainAxisAlignment.center,
                    //         children: [
                    //           // const Icon(Icons.store_outlined,
                    //           //     color: Colors.white, size: 28),
                    //           // Show business name only when expanded
                    //           if (isExpanded) ...[
                    //             const SizedBox(width: 12),
                    //             Expanded(
                    //                 child: Column(
                    //                     mainAxisAlignment: MainAxisAlignment.center,
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                   Text(bizName,
                    //                       style: const TextStyle(
                    //                           color: Colors.white,
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.bold),
                    //                       overflow: TextOverflow.ellipsis,
                    //                       maxLines: 1),
                    //                   const Text('TradeFlow',
                    //                       style: TextStyle(
                    //                           color: Colors.white60, fontSize: 11)),
                    //                 ])),
                    //           ],
                    //         ]),
                    //         ),

                    // ── NAV ITEMS ─────────────────────────────────────────────
                    Expanded(
                        child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            children: visibleTabs.asMap().entries.map((entry) {
                              final i = entry.key;
                              final tab = entry.value;
                              final isSelected = i == selectedIndex;

                              return Tooltip(
                                  // Show tooltip with label when collapsed
                                  // so user knows what each icon does
                                  message: isExpanded ? '' : tab.label,
                                  preferBelow: false,
                                  waitDuration:
                                      const Duration(milliseconds: 500),
                                  child: InkWell(
                                      onTap: () => context.go(tab.path),
                                      borderRadius: BorderRadius.circular(8),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: isExpanded ? 12 : 0,
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                            // Highlight selected item
                                            color: isSelected
                                                ? AppColors.primary
                                                    .withValues(alpha: 0.12)
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            // Left accent border for selected item
                                            border: isSelected
                                                ? Border(
                                                    left: BorderSide(
                                                        color:
                                                            AppColors.primary,
                                                        width: 3))
                                                : null),
                                        child: Row(
                                            mainAxisAlignment: isExpanded
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.center,
                                            children: [
                                              // Icon — always visible
                                              Icon(
                                                  isSelected
                                                      ? tab.activeIcon
                                                      : tab.icon,
                                                  size: 22,
                                                  color: isSelected
                                                      ? AppColors.primary
                                                      : Colors.grey.shade600),
                                              // Label — only when expanded
                                              if (isExpanded) ...[
                                                const SizedBox(width: 14),
                                                Expanded(
                                                    child: Text(tab.label,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                isSelected
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .normal,
                                                            color: isSelected
                                                                ? AppColors
                                                                    .primary
                                                                : Colors
                                                                    .black87),
                                                        overflow: TextOverflow
                                                            .ellipsis)),
                                              ],
                                            ]),
                                      )));
                            }).toList())),

                    // ── SIDEBAR FOOTER ────────────────────────────────────────
                    const Divider(height: 1),
                    Padding(
                        padding: const EdgeInsets.all(12),
                        child: isExpanded
                            ? Text('TradeFlow v1.0',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey.shade400))
                            : Icon(Icons.info_outline,
                                size: 16, color: Colors.grey.shade400)),
                  ])),

              // ── VERTICAL DIVIDER ────────────────────────────────────────────
              const VerticalDivider(width: 1, thickness: 1),

              // ── MAIN CONTENT AREA ───────────────────────────────────────────
              // Expands to fill remaining space beside the sidebar
              Expanded(child: child),
            ]),
          )
        : Scaffold(
            // ── APP BAR ────────────────────────────────────────────────────────
            appBar: AppBar(
              title: Text(bizName),
              // Hamburger icon opens/closes drawer
              leading: Builder(
                  builder: (ctx) => IconButton(
                        icon: const Icon(Icons.menu),
                        tooltip: 'Navigation Menu',
                        onPressed: () => Scaffold.of(ctx).openDrawer(),
                      )),
              actions: [
                // Show toggle button only on mobile — switches back to bottom tabs
                if (!isWideScreen)
                  IconButton(
                    icon: const Icon(Icons.tab_outlined),
                    tooltip: 'Switch to Bottom Tabs',
                    onPressed: () =>
                        ref.read(navLayoutProvider.notifier).state = false,
                  ),
                IconButton(
                    icon: const Icon(Icons.account_circle_outlined),
                    onPressed: () => context.push(AppRoutes.profile)),
                IconButton(
                    icon: const Icon(Icons.logout),
                    tooltip: 'Log out',
                    onPressed: () => _logout(context, ref)),
              ],
            ),

            // ── SIDE DRAWER ────────────────────────────────────────────────────
            drawer: SafeArea(
              child: Drawer(
                width: 280,
                child: Column(children: [
                  // Drawer header with business name
                  // DrawerHeader(
                  //     decoration: BoxDecoration(color: AppColors.primary),
                  //     child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //         children: [
                  //           const Icon(Icons.store_outlined,
                  //               color: Colors.white, size: 36),
                  //           const SizedBox(height: 8),
                  //           Text(bizName,
                  //               style: const TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 20,
                  //                   fontWeight: FontWeight.bold)),
                  //           const Text('TradeFlow',
                  //               style: TextStyle(
                  //                   color: Colors.white60, fontSize: 12)),
                  //         ])),

                  // Navigation items
                  Expanded(
                      child: ListView(
                    padding: EdgeInsets.zero,
                    children: visibleTabs.asMap().entries.map((entry) {
                      final i = entry.key;
                      final tab = entry.value;
                      final isSelected = i == selectedIndex;
                      return ListTile(
                        // Highlight selected item
                        tileColor: isSelected
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 2),
                        leading: Icon(isSelected ? tab.activeIcon : tab.icon,
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade600),
                        title: Text(tab.label,
                            style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.black87)),
                        // Left accent bar for selected item
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        onTap: () {
                          // Close drawer then navigate
                          Navigator.of(context).pop();
                          context.go(tab.path);
                        },
                      );
                    }).toList(),
                  )),

                  // Bottom section — version or extra info
                  const Divider(),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('TradeFlow v1.0',
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade400))),
                ]),
              ),
            ),

            // Main content
            body: child,
          );
  }
}

// ── BOTTOM TAB LAYOUT (Mobile default) ───────────────────────────────────────
class _BottomTabLayout extends ConsumerWidget {
  final Widget child;
  final String bizName;
  final List<_Tab> visibleTabs;
  final int selectedIndex;
  final WidgetRef ref;

  const _BottomTabLayout({
    required this.child,
    required this.bizName,
    required this.visibleTabs,
    required this.selectedIndex,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // ── APP BAR ────────────────────────────────────────────────────────
      appBar: AppBar(
        title: Text(bizName),
        actions: [
          // Toggle button — switches to drawer/sidebar view
          IconButton(
            icon: const Icon(Icons.view_sidebar_outlined),
            tooltip: 'Switch to Side Drawer',
            onPressed: () => ref.read(navLayoutProvider.notifier).state = true,
          ),
          IconButton(
              icon: const Icon(Icons.account_circle_outlined),
              onPressed: () => context.push(AppRoutes.profile)),
          IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Log out',
              onPressed: () => _logout(context, ref)),
        ],
      ),

      // Main content
      body: child,

      // ── SCROLLABLE BOTTOM TAB BAR ───────────────────────────────────────
      // Custom scrollable bottom nav — NavigationBar does not scroll
      // Shows all tabs without crowding even with 6-7 items
      bottomNavigationBar: visibleTabs.isEmpty
          ? null
          : _ScrollableBottomNav(
              tabs: visibleTabs,
              selectedIndex: selectedIndex,
              onTap: (i) => context.go(visibleTabs[i].path),
            ),
    );
  }
}

// ── SCROLLABLE BOTTOM NAVIGATION BAR ─────────────────────────────────────────
// Custom widget because Flutter's NavigationBar does not support scrolling
// Each tab has an icon + label, selected tab highlighted with primary color
class _ScrollableBottomNav extends StatelessWidget {
  final List<_Tab> tabs;
  final int selectedIndex;
  final void Function(int) onTap;

  const _ScrollableBottomNav({
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64,
        decoration: BoxDecoration(color: AppColors.surface, boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, -2)),
        ]),
        child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // ← enables horizontal scroll
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                  children: tabs.asMap().entries.map((entry) {
                final i = entry.key;
                final tab = entry.value;
                final isSelected = i == selectedIndex;

                return GestureDetector(
                  onTap: () => onTap(i),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      // Selected tab gets a wider pill background
                      // Unselected tabs are narrower icon-only
                      width: isSelected ? 100 : 64,
                      height: 52,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 4),
                      decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.12)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(isSelected ? tab.activeIcon : tab.icon,
                                size: 22,
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey.shade500),
                            const SizedBox(height: 3),
                            Text(
                              tab.label,
                              style: TextStyle(
                                  fontSize: isSelected ? 10 : 9,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.grey.shade500),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ])),
                );
              }).toList()),
            )));
  }
}

// ── SHARED LOGOUT FUNCTION ────────────────────────────────────────────────────
Future<void> _logout(BuildContext context, WidgetRef ref) async {
  final user = ref.read(currentAppUserProvider).asData?.value;
  final bizId = ref.read(activeBusinessProvider).asData?.value?.id ?? '';

  if (user != null) {
    await ref
        .read(auditServiceProvider)
        .logLogout(userId: user.id, userName: user.name, businessId: bizId);
  }
  await ref.read(loginNotifierProvider.notifier).signOut();
}

void _showCustomHeightDrawer(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Drawer",
    barrierColor: Colors.black54, // Dim background
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.topLeft, // Change to Alignment.topCenter or Left
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75, // 75% width
          height: 400, // <--- SET YOUR CUSTOM REDUCED HEIGHT HERE
          margin: const EdgeInsets.only(
              top: 56, left: 0), // Offset below AppBar if needed
          child: Material(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DrawerHeader(
                  child: Text('Custom Height Drawer'),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // Slide-in animation from the left
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tradeflow/shared/models/permission.dart';
// import '../../core/constants/permission_keys.dart';
// import '../../core/di/repository_providers.dart';
// import '../../core/router/app_router.dart';
// import '../../core/theme/app_colors.dart';
// import '../../features/admin/application/permission_providers.dart';
// import '../../features/auth/application/auth_providers.dart' as auth_providers;
// import '../../features/business/application/business_providers.dart'
//     as business_providers;
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// class _Tab {
//   final String path, label, screenKey;
//   final IconData icon, activeIcon;
//   const _Tab(
//       {required this.path,
//       required this.label,
//       required this.screenKey,
//       required this.icon,
//       required this.activeIcon});
// }

// const _allTabs = [
//   _Tab(
//       path: AppRoutes.dashboard,
//       label: 'Home',
//       screenKey: AppScreenKeys.dashboard,
//       icon: Icons.home_outlined,
//       activeIcon: Icons.home_rounded),
//   _Tab(
//       path: AppRoutes.catalog,
//       label: 'Catalog',
//       screenKey: AppScreenKeys.catalog, // add this key to AppScreenKeys
//       icon: Icons.storefront_outlined,
//       activeIcon: Icons.storefront_rounded),
//   _Tab(
//       path: AppRoutes.inventory,
//       label: 'Inventory',
//       screenKey: AppRoutes.inventory,
//       icon: Icons.inventory_2_outlined,
//       activeIcon: Icons.inventory_2_rounded),
//   _Tab(
//       path: AppRoutes.customers,
//       label: 'Customers',
//       screenKey: AppRoutes.customers,
//       icon: Icons.people_outline,
//       activeIcon: Icons.people_rounded),
//   _Tab(
//       path: AppRoutes.invoices,
//       label: 'Invoices',
//       screenKey: AppScreenKeys.invoices,
//       icon: Icons.receipt_outlined,
//       activeIcon: Icons.receipt_rounded),
//   _Tab(
//       path: AppRoutes.reports,
//       label: 'Reports',
//       screenKey: AppScreenKeys.reports,
//       icon: Icons.bar_chart_outlined,
//       activeIcon: Icons.bar_chart_rounded),
//   _Tab(
//       path: AppRoutes.admin,
//       label: 'Settings',
//       screenKey: AppScreenKeys.admin,
//       icon: Icons.settings_outlined,
//       activeIcon: Icons.settings_rounded),
// ];

// class AppShell extends ConsumerWidget {
//   final Widget child;
//   const AppShell({super.key, required this.child});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final bizAsync = ref.watch(business_providers.activeBusinessProvider);
//     final bizName = bizAsync.valueOrNull?.name ?? 'TradeFlow';

// //Filter tabs by current user's view permissions

//     final perms = ref.watch(currentRolePermissionsProvider).asData?.value;
//     final visibleTabs = _allTabs.where((tab) {
//       if (perms == null) {
//         return true;
//       } //return tab.screenKey == AppScreenKeys.dashboard;
//       return perms.canView(tab.screenKey);
//     }).toList();

// // Selected tab index — safe calculation
//     final location = GoRouterState.of(context).matchedLocation;
//     // Step 1: try exact match first
//     int selected = visibleTabs.indexWhere((t) => location.startsWith(t.path));
// // Step 2: if no exact match, try prefix match
//     // BUT skip single-character paths like '/' to avoid false matches
//     if (selected < 0) {
//       selected = visibleTabs.indexWhere(
//         (t) => t.path.length > 1 && location.startsWith(t.path),
//       );
//     }
//     // Step 3: if still no match (e.g. /profile, /upgrade, /admin/users)
//     // default to 0 — never pass a negative value to NavigationBar
//     if (selected < 0) selected = 0;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(bizName),
//         actions: [
//           IconButton(
//             onPressed: () => context.push(AppRoutes.profile),
//             icon: const Icon(Icons.account_circle_outlined),
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: 'Log out',
//             onPressed: () async {
//               //Audit layer : log logout before signing out
//               //if we signout first audit write may fail
//               final user =
//                   ref.read(auth_providers.currentAppUserProvider).asData?.value;
//               final biz =
//                   ref.read(business_providers.activeBusinessIdProvider) ?? '';
//               if (user != null) {
//                 await ref.read(auditServiceProvider).logLogout(
//                       userId: user.id,
//                       userName: user.name,
//                       businessId: biz.toString(),
//                     );
//               }
//               //signout after audit is confirmed written
//               await ref
//                   .read(auth_providers.loginNotifierProvider.notifier)
//                   .signOut();
//               //GoRouter redirect handles navigation to /login
//             },
//           ),
//         ],
//       ),
//       body: child,
//       bottomNavigationBar: visibleTabs.length < 2
//           ? null
//           : NavigationBar(
//               selectedIndex: selected,
//               backgroundColor: AppColors.surface,
//               indicatorColor: AppColors.primary.withValues(alpha: 0.12),
//               labelBehavior:
//                   NavigationDestinationLabelBehavior.onlyShowSelected,
//               onDestinationSelected: (i) => context.go(visibleTabs[i].path),
//               destinations: visibleTabs
//                   .map((t) => NavigationDestination(
//                         icon: Icon(t.icon),
//                         selectedIcon:
//                             Icon(t.activeIcon, color: AppColors.primary),
//                         label: t.label,
//                       ))
//                   .toList(),
//             ),
//     );
//   }
// }
