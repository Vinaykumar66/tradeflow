import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradeflow/features/business/application/business_providers.dart';
import 'package:tradeflow/features/business/presentation/onboarding_screen.dart';
import 'package:tradeflow/shared/utils/session_actions.dart';

class BusinessGate extends ConsumerWidget {
  final Widget child;
  const BusinessGate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = ref.watch(activeBusinessProvider);
    if (!a.hasValue && a.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!a.hasValue && a.hasError) {
      // never show onboarding on a load error
      return Scaffold(
          body: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Could not load your business.\n${a.error}',
            textAlign: TextAlign.center),
        const SizedBox(height: 12),
        ElevatedButton(
            onPressed: () => ref.invalidate(activeBusinessProvider),
            child: const Text('Retry')),
        TextButton(
            onPressed: () => signOutWithAudit(ref),
            child: const Text('Sign out')),
      ])));
    }
    return a.value == null ? const OnboardingScreen() : child;
  }
}
