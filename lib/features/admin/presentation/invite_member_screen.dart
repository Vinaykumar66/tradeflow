import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../features/business/application/business_providers.dart';
import '../data/invite_repository.dart';

class InviteMemberScreen extends ConsumerStatefulWidget {
  const InviteMemberScreen({super.key});

  @override
  ConsumerState<InviteMemberScreen> createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends ConsumerState<InviteMemberScreen> {
  final _emailCtrl = TextEditingController();
  String _role = 'salesperson';
  bool _sending = false;
  Future<void> _sendInvite() async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty) return;

    final biz = ref.read(activeBusinessProvider).asData?.value;
    final uid = ref.read(currentSupabaseUserProvider)?.id;
    if (biz == null || uid == null) return;

    setState(() {
      _sending = true;
    });
    try {
      final invite = await InviteRepository().createInvite(
          businessId: biz.id,
          email: email,
          roleValue: _role,
          invitedByUid: uid);
      await supabase.functions.invoke('send-reminder-email', body: {
        'to': email,
        'subject': 'You have been invited to join ${biz.name} on TradeFlow',
        'body': 'You have been invited to join ${biz.name}.<br><br>'
            'Download TradeFlow, create and account then enter this invite code: <br><br>'
            '<b>${invite.inviteCode}</b><br><br>'
            'This code expired in 7 days.',
      });

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invite sent to $email')));
        _emailCtrl.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to send invite: $e'),
            backgroundColor: Colors.red));
      }
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
        appBar: AppBar(title: const Text('Invite Team Member')),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email')),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _role,
                decoration: const InputDecoration(labelText: 'Role'),
                items: const [
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                  DropdownMenuItem(
                      value: 'salesperson', child: Text('Salesperson')),
                  DropdownMenuItem(
                      value: 'accountant', child: Text('Accountant')),
                ],
                onChanged: (v) => setState(() {
                  _role = v ?? _role;
                }),
              ),
              const SizedBox(height: 24),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _sending ? null : _sendInvite,
                      child: _sending
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Send Invite'))),
            ])));
  }
}
