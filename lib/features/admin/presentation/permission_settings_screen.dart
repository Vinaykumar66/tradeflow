import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../features/business/application/business_providers.dart';

const _screens = [
  'dashboard',
  'inventory',
  'invoices',
  'customers',
  'reports',
  'admin',
];

const _screenLabels = {
  'dashboard': 'Dashboard',
  'inventory': 'Inventory',
  'invoices': 'Invoices',
  'customers': 'Customers',
  'reports': 'Reports',
  'admin': 'Admin Settings',
};

const _actions = ['view', 'create', 'edit', 'delete'];

// Main screen
class PermissionSettingsScreen extends ConsumerStatefulWidget {
  const PermissionSettingsScreen({super.key});

  @override
  ConsumerState<PermissionSettingsScreen> createState() =>
      _PermissionSettingsScreenState();
}

class _PermissionSettingsScreenState
    extends ConsumerState<PermissionSettingsScreen>
    with SingleTickerProviderStateMixin {
  //TAB CONTROLLER
  // length MUST match the number of Tab() widgets in TabBar exactly
  late TabController _tabController;

  static const _roles = ['admin', 'salesperson', 'accountant'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _roles.length, // 3 — matches 3 Tab() widgets below
      vsync: this, // provided by SingleTickerProviderStateMixin
    );
  }

  @override
  void dispose() {
    _tabController.dispose(); // always dispose to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xF0FFFFFF),
        title: const Text(
            style: TextStyle(color: Colors.black), 'Permission Settings'),
        // ── TAB BAR in AppBar bottom ─────────────────────────────────────
        bottom: TabBar(
          // labelColor: Color.from(alpha: 24, red: 10, green: 10, blue: 10),

          controller: _tabController, // ← explicit controller
          tabs: const [
            Tab(text: 'Admin'),
            Tab(text: 'Salesperson'),
            Tab(text: 'Accountant'),
          ],
        ),
      ),
      // ── TAB BAR VIEW ───────────────────────────────────────────────────────
      body: TabBarView(
        controller: _tabController, // ← same controller as TabBar
        children: _roles.map((role) => _RolePermissionTab(role: role)).toList(),
      ),
    );
  }
}

// ── PER-ROLE PERMISSION TAB ───────────────────────────────────────────────────
class _RolePermissionTab extends ConsumerStatefulWidget {
  final String role;
  const _RolePermissionTab({required this.role});

  @override
  ConsumerState<_RolePermissionTab> createState() => _RolePermissionTabState();
}

class _RolePermissionTabState extends ConsumerState<_RolePermissionTab> {
  final Map<String, bool> _perms = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  Future<void> _loadPermissions() async {
    setState(() => _loading = true);
    try {
      final bizId = ref.read(activeBusinessProvider).asData?.value?.id ?? '';
      if (bizId.isEmpty) {
        setState(() => _loading = false);
        return;
      }

      final rows = await supabase
          .from('role_permissions')
          .select('screen_key, action, allowed')
          .eq('business_id', bizId)
          .eq('role', widget.role);

      // Set defaults first — everything allowed
      final map = <String, bool>{};
      for (final screen in _screens) {
        for (final action in _actions) {
          map['${screen}_$action'] = true;
        }
      }

      // Apply saved values from database
      for (final row in rows) {
        final key = '${row['screen_key']}_${row['action']}';
        map[key] = row['allowed'] as bool? ?? true;
      }

      if (mounted)
        setState(() {
          _perms.addAll(map);
          _loading = false;
        });
    } catch (e) {
      debugPrint('_loadPermissions error: $e');
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _toggle(String screenKey, String action, bool value) async {
    final key = '${screenKey}_$action';

    // Update UI immediately — optimistic update
    setState(() => _perms[key] = value);

    try {
      final bizId = ref.read(activeBusinessProvider).asData?.value?.id ?? '';
      await supabase.from('role_permissions').upsert(
        {
          'business_id': bizId,
          'role': widget.role,
          'screen_key': screenKey,
          'action': action,
          'allowed': value,
        },
        onConflict: 'business_id,role,screen_key,action',
      );
    } catch (e) {
      // Revert on failure
      if (mounted) setState(() => _perms[key] = !value);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to save: $e'), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── COLUMN HEADERS ──────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(children: [
            const Expanded(
                flex: 3,
                child: Text('Screen',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey))),
            ..._actions.map((a) => Expanded(
                child: Text(a[0].toUpperCase() + a.substring(1),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.grey)))),
          ]),
        ),

        const Divider(),

        // ── ONE ROW PER SCREEN ──────────────────────────────────────────────
        ..._screens.map((screen) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(children: [
              // Screen name
              Expanded(
                  flex: 3,
                  child: Text(_screenLabels[screen] ?? screen,
                      style: const TextStyle(fontSize: 13))),
              // Four toggles — view / create / edit / delete
              ..._actions.map((action) {
                final key = '${screen}_$action';
                final allowed = _perms[key] ?? true;
                return Expanded(
                    child: Switch(
                  value: allowed,
                  activeColor: AppColors.primary,
                  // Owner role cannot be edited
                  onChanged: widget.role == 'owner'
                      ? null
                      : (val) => _toggle(screen, action, val),
                ));
              }),
            ]))),

        const SizedBox(height: 24),

        // ── INFO NOTE ──────────────────────────────────────────────────────
        Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200)),
            child: const Text(
                'Changes save immediately. '
                'Team members see updated permissions on their next action.',
                style: TextStyle(fontSize: 12, color: Colors.black87))),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/supabase/supabase_client.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../features/auth/application/auth_providers.dart';

// // SCREEN AND ACTION DEFINITIONS
// // Add or remove screens here as your app grows
// const _screens = [
//   'dashboard',
//   'inventory',
//   'invoices',
//   'customers',
//   'reports',
//   'admin',
// ];

// const _screenLabels = {
//   'dashboard': 'Dashboard',
//   'inventory': 'Inventory',
//   'invoices': 'Invoices',
//   'customers': 'Customers',
//   'reports': 'Reports',
//   'admin': 'Admin Settings',
// };

// const _actions = ['view', 'create', 'edit', 'delete'];

// // main screen widget
// class PermissionSettingsScreen extends ConsumerStatefulWidget {
//   const PermissionSettingsScreen({super.key});

//   @override
//   ConsumerState<PermissionSettingsScreen> createState() =>
//       _PermissionSettingsScreenState();
// }

// class _PermissionSettingsScreenState
//     extends ConsumerState<PermissionSettingsScreen>
//     with SingleTickerProviderStateMixin {
//   // Tab controller — must match number of tabs exactly
//   late TabController _tabController;

//   // Roles shown as tabs — add custom roles here later
//   static const _roles = ['admin', 'salesperson', 'accountant'];
//   static const _roleLabels = {
//     'admin': 'Admin',
//     'salesperson': 'Salesperson',
//     'accountant': 'Accountant',
//   };

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: _roles.length, // must equal number of Tab() widgets below
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Permission Settings'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: _roles.map((r) => Tab(text: _roleLabels[r] ?? r)).toList(),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: _roles.map((role) => _RolePermissionTab(role: role)).toList(),
//       ),
//     );
//   }
// }

// class _RolePermissionTab extends ConsumerStatefulWidget {
//   final String role;
//   const _RolePermissionTab({required this.role});

//   @override
//   ConsumerState<_RolePermissionTab> createState() => _RolePermissionTabState();
// }

// class _RolePermissionTabState extends ConsumerState<_RolePermissionTab> {
//   // Local map: 'screen_action' → bool
//   // e.g. 'invoices_view' → true
//   final Map<String, bool> _perms = {};
//   bool _loading = true;
//   bool _saving = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadPermissions();
//   }

//   // Load this role's permissions from role_permissions table
//   Future<void> _loadPermissions() async {
//     setState(() => _loading = true);
//     try {
//       final bizId = ref.read(activeBusinessIdProvider) ?? '';
//       final rows = await supabase
//           .from('role_permissions')
//           .select('screen_key, action, allowed')
//           .eq('business_id', bizId)
//           .eq('role_value', widget.role);

//       final map = <String, bool>{};

//       // First set defaults — everything allowed by default
//       for (final screen in _screens) {
//         for (final action in _actions) {
//           map['${screen}_$action'] = true;
//         }
//       }

//       // Then apply saved values from database
//       for (final row in rows) {
//         final key = '${row['screen_key']}_${row['action']}';
//         map[key] = row['allowed'] as bool? ?? true;
//       }

//       if (mounted)
//         setState(() {
//           _perms.addAll(map);
//           _loading = false;
//         });
//     } catch (e) {
//       if (mounted) setState(() => _loading = false);
//     }
//   }

//   // Toggle one permission and save immediately to Supabase
//   Future<void> _toggle(String screenKey, String action, bool value) async {
//     final key = '${screenKey}_$action';

//     // Update UI immediately (optimistic)
//     setState(() => _perms[key] = value);

//     try {
//       final bizId = ref.read(activeBusinessIdProvider) ?? '';
//       await supabase.from('role_permissions').upsert(
//         {
//           'business_id': bizId,
//           'role_value': widget.role,
//           'screen_key': screenKey,
//           'action': action,
//           'allowed': value,
//         },
//         onConflict: 'business_id,role_value,screen_key,action',
//       );
//     } catch (e) {
//       // Revert on error
//       if (mounted) setState(() => _perms[key] = !value);
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to save: $e'),
//             backgroundColor: AppColors.alertRed,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_loading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         // Header row showing action column labels
//         Padding(
//           padding: const EdgeInsets.only(bottom: 8),
//           child: Row(
//             children: [
//               const Expanded(
//                 flex: 3,
//                 child: Text(
//                   'Screen',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               // One label per action
//               ..._actions.map((a) => Expanded(
//                     child: Text(
//                       a[0].toUpperCase() +
//                           a.substring(1), // 'View', 'Create' etc.
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 11,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   )),
//             ],
//           ),
//         ),

//         const Divider(),

//         // One row per screen
//         ..._screens.map((screen) => _ScreenRow(
//               screenLabel: _screenLabels[screen] ?? screen,
//               screenKey: screen,
//               perms: _perms,
//               onToggle: _toggle,
//               // Owner role is locked — cannot be edited
//               locked: widget.role == 'owner',
//             )),

//         const SizedBox(height: 24),

//         // Info note at the bottom
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.blue.shade50,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.blue.shade200),
//           ),
//           child: const Text(
//             'Changes are saved immediately. '
//             'Team members will see updated permissions on their next action.',
//             style: TextStyle(fontSize: 12, color: Colors.black87),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _ScreenRow extends StatelessWidget {
//   final String screenLabel;
//   final String screenKey;
//   final Map<String, bool> perms;
//   final Future<void> Function(String, String, bool) onToggle;
//   final bool locked;

//   const _ScreenRow({
//     required this.screenLabel,
//     required this.screenKey,
//     required this.perms,
//     required this.onToggle,
//     this.locked = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           // Screen name
//           Expanded(
//             flex: 3,
//             child: Text(
//               screenLabel,
//               style: const TextStyle(fontSize: 13),
//             ),
//           ),
//           // One switch per action
//           ..._actions.map((action) {
//             final key = '${screenKey}_$action';
//             final allowed = perms[key] ?? true;
//             return Expanded(
//               child: Switch(
//                 value: allowed,
//                 activeColor: AppColors.primary,
//                 // Locked roles (owner) show disabled switches
//                 onChanged:
//                     locked ? null : (val) => onToggle(screenKey, action, val),
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }
