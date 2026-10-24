import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/router/app_router.dart';
import '../../../core/supabase/supabase_client.dart';
import '../application/auth_providers.dart';

class TermsAcceptanceScreen extends ConsumerStatefulWidget {
  const TermsAcceptanceScreen({super.key});

  @override
  ConsumerState<TermsAcceptanceScreen> createState() =>
      _TermsAcceptanceScreenState();
}

class _TermsAcceptanceScreenState extends ConsumerState<TermsAcceptanceScreen> {
  bool _agreed = false;
  bool _saving = false;

  static const _privacyUrl = 'https://yourbusinessdomain.com/privacy';
  static const _termsUrl = 'https://yourbusinessdomain.com/terms';

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _continue() async {
    final uid = ref.read(currentSupabaseUserProvider)?.id;
    if (uid == null) return;
    setState(() {
      _saving = true;
    });
    await supabase.from('users').update({
      'terms_accepted_at': DateTime.now().toIso8601String(),
    }).eq('id', uid);
    if (mounted) context.go(AppRoutes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.description_outlined,
                        size: 64, color: Colors.grey),
                    const SizedBox(height: 20),
                    const Text(
                      'Before you continue',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    CheckboxListTile(
                        value: _agreed,
                        onChanged: (v) => setState(() => _agreed = v ?? false),
                        title: Wrap(children: [
                          const Text('I agree to the '),
                          GestureDetector(
                              onTap: () => _openLink(_termsUrl),
                              child: const Text('Terms of Service',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline))),
                          const Text(' and '),
                          GestureDetector(
                              onTap: () => _openLink(_privacyUrl),
                              child: const Text('Privacy Policy',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline))),
                        ])),
                    const SizedBox(height: 16),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (_agreed && !_saving) ? _continue : null,
                            child: _saving
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text('Continue'))),
                  ]))),
    );
  }
}
