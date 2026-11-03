import 'package:flutter/material.dart';

Future<bool> onWillPop(
    BuildContext context, String title, String message) async {
  final confirmation = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(false), // Returns false (stay on page)
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () =>
              Navigator.of(context).pop(true), // Returns true (allow pop)
          child: const Text('Okay'),
        ),
      ],
    ),
  );

  // If the user taps outside the dialog, shouldLeave will be null. Fall back to false.
  return confirmation ?? false;
}
