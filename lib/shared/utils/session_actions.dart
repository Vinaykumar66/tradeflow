import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/repository_providers.dart';
import '../../features/auth/application/auth_providers.dart';
import '../../features/business/application/business_providers.dart';

/// Logs the logout, then signs out. A failed audit write must not
/// trap someone in the app, so it is caught and ignored.
Future<void> signOutWithAudit(WidgetRef ref) async {
  try {
    final user = ref.read(currentAppUserProvider).asData?.value;
    final bizId = ref.read(activeBusinessProvider).asData?.value?.id ?? '';
    if (user != null) {
      await ref
          .read(auditServiceProvider)
          .logLogout(userId: user.id, userName: user.name, businessId: bizId);
    }
  } catch (_) {}
  await ref.read(loginNotifierProvider.notifier).signOut();
}
