import 'package:flutter/material.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xF0FFFFFF),
        title: const Text(style: TextStyle(color: Colors.black), 'Invoices'),
      ),
      body: Center(
        child: Text('Invoices - coming soon'),
      ),
    );
  }
}
