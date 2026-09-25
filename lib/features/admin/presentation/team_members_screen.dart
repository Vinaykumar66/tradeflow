import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../features/business/application/business_providers.dart';
import 'invite_member_screen.dart';

final teamMembersProvider = StreamProvider((ref) {
  final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (bizId == null) return const Stream.empty();
  return supabase
      .from('business_members')
      .stream(primaryKey: ['uid', 'business_id'])
      .eq('business_id', bizId)
      .map((rows) => rows);
});

class TeamMembersScreen extends ConsumerWidget {
  const TeamMembersScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersAsync = ref.watch(teamMembersProvider);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xF0FFFFFF),
          iconTheme: const IconThemeData(color: Color(0xFF2F4F4F)),
          title: const Text(
              style: TextStyle(color: Color(0xFF2F4F4F)), 'Team Members')),
      body: membersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (members) => ListView.builder(
            itemCount: members.length,
            itemBuilder: (_, i) {
              final m = members[i];
              final active = m['is_active'] as bool? ?? true;
              return ListTile(
                  title: Text(m['name'] as String? ?? 'Unnamed'),
                  subtitle: Text(
                      '${m['role_value']} - ${active ? 'Active' : 'Inactive'}'),
                  trailing: Switch(
                      value: active,
                      onChanged: (v) async {
                        await supabase
                            .from('business_members')
                            .update({'is_active': v})
                            .eq('uid', m['uid'])
                            .eq('business_id', m['business_id']);
                      }));
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const InviteMemberScreen())),
          icon: const Icon(Icons.person_add_outlined),
          label: const Text('Invite')),
    );
  }
}
