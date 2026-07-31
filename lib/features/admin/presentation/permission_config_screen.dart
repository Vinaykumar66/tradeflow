import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/constants/permission_keys.dart';
import '../../../core/di/repository_providers.dart';
import '../../../core/permissions/default_permissions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../shared/models/permission.dart';
import '../application/permission_providers.dart';

class PermissionConfigScreen extends ConsumerStatefulWidget {
  const PermissionConfigScreen({super.key});
  @override
  ConsumerState<PermissionConfigScreen> createState() =>
      _PermissionConfigScreenState();
}

class _PermissionConfigScreenState extends ConsumerState<PermissionConfigScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  final _roles = ['admin', 'salesperson', 'accountant'];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Settings'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Admin'),
            Tab(text: 'Salesperson'),
            Tab(text: 'Accountant'),
          ],
        ),
      ),
      body: TabBarView(
        children:
            _roles.map((role) => _RolePermissionTab(roleValue: role)).toList(),
      ),
    );
  }
}

class _RolePermissionTab extends ConsumerStatefulWidget {
  final String roleValue;
  const _RolePermissionTab({required this.roleValue});
  @override
  ConsumerState<_RolePermissionTab> createState() => _RolePermissionTabState();
}

class _RolePermissionTabState extends ConsumerState<_RolePermissionTab> {
  RolePermissionSet? _editing;
  @override
  Widget build(BuildContext context) {
    final bizId = ref.watch(activeBusinessIdProvider) ?? '';
    final permAsync =
        ref.watch(rolePermissionsProvider(bizId, widget.roleValue));
    return permAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (perms) {
        _editing ??= perms ?? _defaultFor(bizId);
        return _buildForm();
      },
    );
  }

  RolePermissionSet _defaultFor(String bizId) => switch (widget.roleValue) {
        'admin' => DefaultPermissions.admin(bizId),
        'salesperson' => DefaultPermissions.salesperson(bizId),
        _ => DefaultPermissions.accountant(bizId),
      };

  Widget _buildForm() {
    if (_editing == null) return const SizedBox.shrink();
    final saving = ref.watch(savePermissionsNotifierProvider) is AsyncLoading;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
//screen permissions
        Text(
          'Screen Access',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ..._editing!.screens.map((screen) => _ScreenPermissionTile(
              permission: screen,
              readOnly: widget.roleValue == 'admin',
              onChanged: (updated) => setState(() {
                final screens = _editing!.screens.toList();
                final idx =
                    screens.indexWhere((s) => s.screenKey == updated.screenKey);
                if (idx >= 0) screens[idx] = updated;
                _editing = _editing!.copyWith(screens: screens);
              }),
            )),
        const Divider(height: 32),

//Field permissions

        Text('Sensitive Field Access',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ..._editing!.fields.map((field) => _FieldPermissionTile(
              permission: field,
              readOnly: widget.roleValue == 'admin',
              onChanged: (updated) => setState(() {
                final fields = _editing!.fields.toList();
                final idx =
                    fields.indexWhere((f) => f.fieldKey == updated.fieldKey);
                if (idx >= 0) fields[idx] = updated;
                _editing = _editing!.copyWith(fields: fields);
              }),
            )),
        const SizedBox(height: 32),
      ],
    );
  }

  Future<void> _save() async {
    if (_editing == null) return;
    await ref.read(savePermissionsNotifierProvider.notifier).save(_editing!);
    if (mounted)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Permissions saved'),
        backgroundColor: AppColors.success,
      ));
  }
}

class _ScreenPermissionTile extends StatelessWidget {
  final ScreenPermission permission;
  final bool readOnly;
  final ValueChanged<ScreenPermission> onChanged;
  const _ScreenPermissionTile(
      {required this.permission,
      required this.readOnly,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                permission.screenKey.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(spacing: 8, children: [
                for (final (label, value, update) in [
                  (
                    'View',
                    permission.canView,
                    (bool v) => onChanged(permission.copyWith(canView: v))
                  ),
                  (
                    'Create',
                    permission.canCreate,
                    (bool v) => onChanged(permission.copyWith(canCreate: v))
                  ),
                  (
                    'Edit',
                    permission.canEdit,
                    (bool v) => onChanged(permission.copyWith(canEdit: v))
                  ),
                  (
                    'Delete',
                    permission.canDelete,
                    (bool v) => onChanged(permission.copyWith(canDelete: v))
                  ),
                ])
                  FilterChip(
                    label: Text(label),
                    selected: value,
                    onSelected: readOnly ? null : update,
                  ),
              ]),
            ],
          )),
    );
  }
}

// Single field permission toggle row

class _FieldPermissionTile extends StatelessWidget {
  final FieldPermission permission;
  final bool readOnly;
  final ValueChanged<FieldPermission> onChanged;
  const _FieldPermissionTile(
      {required this.permission,
      required this.readOnly,
      required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(children: [
        Expanded(
            child: Text(
          permission.fieldKey.replaceAll('_', ' ').toUpperCase(),
          style: const TextStyle(fontSize: 13),
        )),
        FilterChip(
            label: const Text('Can View'),
            selected: permission.canView,
            onSelected: readOnly
                ? null
                : (v) => onChanged(permission.copyWith(canView: v))),
        const SizedBox(width: 8),
        FilterChip(
            label: const Text('Can Edit'),
            selected: permission.canEdit,
            onSelected: readOnly || !permission.canView
                ? null
                : (v) => onChanged(permission.copyWith(canEdit: v))),
      ]),
    ));
  }
}
