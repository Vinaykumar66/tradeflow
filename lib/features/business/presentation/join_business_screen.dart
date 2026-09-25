import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/supabase/supabase_client.dart';
import '../application/business_providers.dart';

class JoinBusinessScreen extends ConsumerStatefulWidget {
  const JoinBusinessScreen({super.key});

  @override
  ConsumerState<JoinBusinessScreen> createState() => _JoinBusinessScreenState();
}

class _JoinBusinessScreenState extends ConsumerState<JoinBusinessScreen> {
  final _codeCtrl = TextEditingController();
  bool _joining = false;
  String? _error;

  Future<void> _join() async {
    final code = _codeCtrl.text.trim().toUpperCase();
    if (code.isEmpty) return;

    setState(() {
      _joining = true;
      _error = null;
    });
    try {
      // The function itself validates the code and creates or
//      reactivates membership - the client never touches
      //    business_members directly here.

      await supabase.rpc('accept_business_invite', params: {'p_code': code});
      ref.invalidate(userBusinessListProvider);
      ref.invalidate(activeBusinessProvider);
      if (mounted) context.go(AppRoutes.dashboard);
    } catch (e) {
      setState(() {
        _error = 'That code is invalid or has expired.';
      });
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Join a Business')),
        body: Padding(
            padding: const EdgeInsets.all(24),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Enter the invite code you received by email',
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              TextField(
                  controller: _codeCtrl,
                  textCapitalization: TextCapitalization.characters,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, letterSpacing: 4),
                  decoration: InputDecoration(
                      errorText: _error, border: const OutlineInputBorder())),
              const SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _joining ? null : _join,
                      child: _joining
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Join'))),
            ])));
  }
}
