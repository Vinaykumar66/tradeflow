import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradeflow/core/router/app_router.dart';
import 'permission_config_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xF0FFFFFF),
        title: const Text(style: TextStyle(color: Colors.black), 'Admin'),
      ),
      body: ListView(
        children: [
          // ListTile(
          //   leading: const Icon(Icons.admin_panel_settings_outlined),
          //   title: const Text('Permission Settings'),
          //   subtitle: const Text('Control what each role can see and do'),
          //   trailing: const Icon(Icons.chevron_right),
          //   onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (_) => const PermissionConfigScreen())),
          // ),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Permission Settings'),
            subtitle: const Text('Control what each role can access'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.permissionSettings),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
