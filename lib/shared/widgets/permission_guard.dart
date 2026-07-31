import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/permission_keys.dart';
import '../../features/admin/application/permission_providers.dart';

class PermissionGuard extends ConsumerWidget {
  final String screenKey;
  final PermissionAction action;
  final Widget child;
  final Widget? fallback;
  const PermissionGuard({
    super.key,
    required this.screenKey,
    required this.action,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPermission =
        ref.watch(hasScreenPermissionProvider(screenKey, action));
    if (hasPermission) return child;
    return fallback ?? const SizedBox.shrink();
  }
}
