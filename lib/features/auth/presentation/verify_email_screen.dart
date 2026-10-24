import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tradeflow/core/router/app_router.dart';
import 'package:tradeflow/core/supabase/supabase_client.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  int _cooldown = 0;
  Timer? _timer;
  String? _msg;
  bool _sending = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _resend() async {
    setState(() {
      _sending = true;
      _msg = null;
    });
    try {
      await supabase.auth.resend(type: OtpType.signup, email: widget.email);
      _msg = 'Sent again. Check your spam folder too.';
      _cooldown = 60;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (!mounted) {
          t.cancel();
          return;
        }
        setState(() {
          _cooldown--;
          if (_cooldown <= 0) t.cancel();
        });
      });
    } on AuthException catch (e) {
      _msg = e.message;
    } catch (e) {
      _msg = 'Could not send: $e';
    } finally {
      if (mounted)
        setState(() {
          _sending = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mark_email_unread_outlined, size: 64),
              const SizedBox(height: 16),
              const Text('Verify your email',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                  'We sent a link to ${widget.email}.\nOpen it, then come back and log in.',
                  textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: (_sending || _cooldown > 0) ? null : _resend,
                  child: Text(_cooldown > 0
                      ? 'Resend in ${_cooldown}s'
                      : 'Resend email')),
              if (_msg != null)
                Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(_msg!)),
              TextButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: const Text('I verified, take me to login')),
            ],
          ),
        ),
      ),
    );
  }
}
