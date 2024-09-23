import 'package:flutter/material.dart';

import '../route.dart';

showErrorDialogue(String error) {
  showDialog(
    context: navigator.currentContext!,
    builder: (context) => ErrorAlertDialogueWidget(
      title: error,
    ),
  );
}

class ErrorAlertDialogueWidget extends StatelessWidget {
  final String title;
  const ErrorAlertDialogueWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF282F37),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        InkWell(
          child: Text("ok"),
          onTap: () => Navigator.pop(context),
        )
      ],
    );
  }
}
