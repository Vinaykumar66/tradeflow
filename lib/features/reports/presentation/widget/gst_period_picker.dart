import 'package:flutter/material.dart';

class GstPeriodPicker extends StatelessWidget {
  final String label;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const GstPeriodPicker(
      {super.key,
      required this.label,
      required this.onPrevious,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(icon: const Icon(Icons.chevron_left), onPressed: onPrevious),
      Text(label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      IconButton(icon: const Icon(Icons.chevron_right), onPressed: onNext),
    ]);
  }
}
