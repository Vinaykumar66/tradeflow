import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xF0FFFFFF),
        title: const Text(style: TextStyle(color: Colors.black), 'Reports'),
      ),
      body: ListTile(
          leading: const Icon(Icons.gavel_outlined),
          title: const Text('GST Compliance'),
          subtitle: const Text('GSTR-1, HSN Summary, GSTR-3B'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(AppRoutes.gstCompliance)),

      // Center(
      //   child: Text('Reports - coming soon'),
    );
  }
}
