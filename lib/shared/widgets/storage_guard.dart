import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradeflow/shared/models/business.dart';
import '../../core/di/repository_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../features/auth/application/auth_providers.dart';
import '../../features/business/application/business_providers.dart';
import '../../shared/models/license_tier.dart';

class StorageGuard extends ConsumerWidget {
  final Widget child;

  const StorageGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizAsync = ref.watch(activeBusinessProvider);
    final business = bizAsync.valueOrNull;
    if (business == null) return child;

    if (business.licenseTier.hasNoStorage) {
      return _UpgradePrompt(business.licenseTier);
    }

    return FutureBuilder<double>(
      future: ref.read(storageTrackingServiceProvider).getUsagePercent(
            businessId: business.id,
            limitBytes: business.licenseTier.storageLimitBytes,
          ),
      builder: (context, snap) {
        final percent = snap.data ?? 0.0;

        // Over quota - block upload
        if (percent >= 1.0) {
          return _UpgradePrompt(business.licenseTier);
        }

        // Approaching quota - warn but allow
        if (percent >= 0.8) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.alertAmber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: AppColors.alertAmber.withValues(alpha: 0.5)),
                ),
                child: Row(children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: AppColors.alertAmber, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(
                          'Storage ${(percent * 100).toInt()}% used. '
                          'Upgrade to ${_nextTier(business.licenseTier)} for more space.',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.alertAmber))),
                ]),
              ),
              const SizedBox(height: 8),
              child,
            ],
          );
        }

        // Under 80% - show normally
        return child;
      },
    );
  }

  String _nextTier(LicenseTier tier) => switch (tier) {
        LicenseTier.starter => 'Basic (500 MB)',
        LicenseTier.basic => 'Pro (2 GB)',
        LicenseTier.pro => 'Extra Storage',
      };
}

// Shown when storage is 100% full
class _UpgradePrompt extends StatelessWidget {
  final LicenseTier tier;
  const _UpgradePrompt(this.tier);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.alertRed.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.alertRed.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.storage_rounded, color: AppColors.alertRed),
            SizedBox(width: 8),
            Text('Storage Full',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.alertRed)),
          ]),
          const SizedBox(height: 8),
          Text(
              'Your ${tier.storageLimitLabel} storage limit is full. '
              'Upgrade your plan to continue uploading files.',
              style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to upgrade screen (built Day 71-75)
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('Contact support to upgrade your storage plan.')));
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.alertRed),
              child: const Text('Upgrade Storage'),
            ),
          ),
        ],
      ),
    );
  }
}
