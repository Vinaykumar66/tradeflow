import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/admin/application/permission_providers.dart';

class FieldGuard extends ConsumerWidget {
  final String fieldKey;
  final Widget child; // shown when canView + canEdit
  final Widget? readOnlyChild; // shown when canView but NOT canEdit

  const FieldGuard({
    super.key,
    required this.fieldKey,
    required this.child,
    this.readOnlyChild,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canView = ref.watch(canViewFieldProvider(fieldKey));
    final canEdit = ref.watch(canEditFieldProvider(fieldKey));

// Hidden entirely from this role
    if (!canView) return const SizedBox.shrink();

    // Visible but read-only

    if (!canEdit && readOnlyChild != null) return readOnlyChild!;

    return child;
  }
}
