import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xF0FFFFFF),
        title: const Text(
          style: TextStyle(color: Colors.black),
          'Dashboard',
        ),
      ),
      body: Center(
        child: Text('Dashboard - coming soon'),
      ),
    );
  }
}
