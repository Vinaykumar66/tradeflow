import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/app_exceptions.dart';
import '../../../core/di/repository_providers.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../application/auth_providers.dart';
import '../../../shared/models/app_user.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w.%+-]+@[\w.-]+\.[a-zA-Z]{2,}$').hasMatch(v.trim()))
      return 'Enter a valid email address';
    return null;
  }

  String? _validatePass(String? v) =>
      (v == null || v.isEmpty) ? 'Password is required' : null;

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref
        .read(loginNotifierProvider.notifier)
        .signIn(email: _emailCtrl.text.trim(), password: _passCtrl.text);
  }

  Future<void> _onForgotPassword() async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Enter your email above then tap Forgot password')));
      return;
    }
    try {
      await ref.read(authServiceProvider).sendPasswordResetEmail(email);
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Password reset email sent to $email'),
            backgroundColor: AppColors.success));
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppExceptions.fromSupabaseAuth(e.toString())),
            backgroundColor: AppColors.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginNotifierProvider);
    final isLoading = state is AsyncLoading;

    ref.listen<AsyncValue<AppUser?>>(loginNotifierProvider, (prev, next) {
      if (prev is! AsyncLoading) return;
      next.whenOrNull(
        data: (appUser) async {
          if (appUser == null) return;
          // AUDIT LAYER 2: record login event
          await ref.read(auditServiceProvider).logLogin(
                userId: appUser.id,
                userName: appUser.name,
                businessId: ref.read(activeBusinessIdProvider) ?? '',
              );
          // GoRouter redirect handles navigation automatically
        },
        error: (err, _) {
          final msg = err is AuthException
              ? AppExceptions.fromSupabaseAuth(err.message)
              : AppExceptions.fromSupabaseAuth(err.toString());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(msg),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating));
        },
      );
    });

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Row(children: [
                  const Icon(Icons.store_rounded,
                      size: 40, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Text('TradeFlow', style: AppTextStyles.h1),
                ]),
                const SizedBox(height: 8),
                Text('Sign in to your account',
                    style: AppTextStyles.bodyMedium),
                const SizedBox(height: 40),
                Text('Email Address', style: AppTextStyles.labelMedium),
                const SizedBox(height: 8),
                TextFormField(
                    controller: _emailCtrl,
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: 'you@example.com',
                        prefixIcon: Icon(Icons.email_outlined))),
                const SizedBox(height: 20),
                Text('Password', style: AppTextStyles.labelMedium),
                const SizedBox(height: 8),
                TextFormField(
                    controller: _passCtrl,
                    validator: _validatePass,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => isLoading ? null : _onSubmit(),
                    decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                            icon: Icon(_obscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure)))),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: _onForgotPassword,
                        child: const Text('Forgot password?'))),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: isLoading ? null : _onSubmit,
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : const Text('Sign In')),
                const SizedBox(height: 24),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Don't have an account?",
                      style: AppTextStyles.bodySmall),
                  TextButton(
                      onPressed: () => context.go(AppRoutes.signup),
                      child: const Text('Sign up')),
                ]),
              ],
            )),
      )),
    );
  }
}
