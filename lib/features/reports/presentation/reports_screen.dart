import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xF0FFFFFF),
        title: const Text(style: TextStyle(color: Colors.black), 'Reports'),
      ),
      body: Center(
        child: Text('Reports - coming soon'),
      ),
    );
  }
}
