import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/application/auth_providers.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/business/presentation/onboarding_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/inventory/presentation/inventory_screen.dart';
import '../../features/customers/presentation/customers_screen.dart';
import '../../features/invoices/presentation/invoices_screen.dart';
import '../../features/reports/presentation/reports_screen.dart';
import '../../features/admin/presentation/admin_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../shared/widgets/app_shell.dart';
import 'router_notifier.dart';

part 'app_router.g.dart';

abstract class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String onboarding = '/onboarding';
  static const String dashboard = '/dashboard';
  static const String inventory = '/inventory';
  static const String customers = '/customers';
  static const String invoices = '/invoices';
  static const String reports = '/reports';
  static const String admin = '/admin';
  static const String profile = '/profile';
}

const _publicRoutes = [AppRoutes.login, AppRoutes.signup, AppRoutes.onboarding];

@riverpod
GoRouter appRouter(Ref ref) {
  final notifier = RouterNotifier(ref);
  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: notifier,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final user = ref.read(currentSupabaseUserProvider);
      final isPublic = _publicRoutes.contains(state.matchedLocation);
      if (user == null && !isPublic) return AppRoutes.login;
      if (user != null && state.matchedLocation == AppRoutes.login)
        return AppRoutes.dashboard;
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: AppRoutes.signup, builder: (_, __) => const SignupScreen()),
      GoRoute(
          path: AppRoutes.onboarding,
          builder: (_, __) => const OnboardingScreen()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
              path: AppRoutes.dashboard,
              builder: (_, __) => const DashboardScreen()),
          GoRoute(
              path: AppRoutes.inventory,
              builder: (_, __) => const InventoryScreen()),
          GoRoute(
              path: AppRoutes.customers,
              builder: (_, __) => const CustomersScreen()),
          GoRoute(
              path: AppRoutes.invoices,
              builder: (_, __) => const InvoicesScreen()),
          GoRoute(
              path: AppRoutes.reports,
              builder: (_, __) => const ReportsScreen()),
          GoRoute(
              path: AppRoutes.admin, builder: (_, __) => const AdminScreen()),
          GoRoute(
              path: AppRoutes.profile,
              builder: (_, __) => const ProfileScreen()),
        ],
      ),
    ],
  );
}
