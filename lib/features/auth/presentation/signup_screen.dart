import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/app_exceptions.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../application/auth_providers.dart';
import '../../../shared/models/app_user.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});
  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _bizCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConf = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _bizCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(signUpNotifierProvider.notifier).signUp(
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
        businessName: _bizCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpNotifierProvider);
    final isLoading = state is AsyncLoading;

    ref.listen<AsyncValue<AppUser?>>(signUpNotifierProvider, (prev, next) {
      if (prev is! AsyncLoading) return;
      next.whenOrNull(
        data: (_) => context.go(AppRoutes.onboarding),
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

    // Helper to build each form field consistently
    Widget field(TextEditingController ctrl, String label,
            {TextInputType type = TextInputType.text,
            bool obscure = false,
            VoidCallback? toggle,
            TextInputAction action = TextInputAction.next,
            String? Function(String?)? validator}) =>
        Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextFormField(
                controller: ctrl,
                keyboardType: type,
                obscureText: obscure,
                textInputAction: action,
                validator: validator,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    labelText: label,
                    suffixIcon: toggle != null
                        ? IconButton(
                            icon: Icon(obscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: toggle)
                        : null)));

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text('Create your account', style: AppTextStyles.h1),
                const SizedBox(height: 8),
                Text('Set up TradeFlow for your business',
                    style: AppTextStyles.bodyMedium),
                const SizedBox(height: 32),
                field(_nameCtrl, 'Your Name',
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Name required' : null),
                field(_bizCtrl, 'Business Name',
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Business name required'
                        : null),
                field(_emailCtrl, 'Email Address',
                    type: TextInputType.emailAddress, validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email required';
                  if (!RegExp(r'^[\w.%+-]+@[\w.-]+\.[a-zA-Z]{2,}$')
                      .hasMatch(v.trim())) return 'Enter a valid email';
                  return null;
                }),
                field(_passCtrl, 'Password',
                    obscure: _obscurePass,
                    toggle: () => setState(() => _obscurePass = !_obscurePass),
                    validator: (v) => v == null || v.length < 8
                        ? 'At least 8 characters'
                        : null),
                field(_confCtrl, 'Confirm Password',
                    obscure: _obscureConf,
                    action: TextInputAction.done,
                    toggle: () => setState(() => _obscureConf = !_obscureConf),
                    validator: (v) =>
                        v != _passCtrl.text ? 'Passwords do not match' : null),
                ElevatedButton(
                    onPressed: isLoading ? null : _onSubmit,
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : const Text('Create Account')),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Already have an account?',
                      style: AppTextStyles.bodySmall),
                  TextButton(
                      onPressed: () => context.go(AppRoutes.login),
                      child: const Text('Log in')),
                ]),
              ],
            )),
      )),
    );
  }
}
