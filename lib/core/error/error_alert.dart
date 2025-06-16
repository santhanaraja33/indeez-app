import 'package:flutter/material.dart';
import '../../../../core/messages/app_messages.dart';

class AppError {
  static void showDialogWithExternalFunction(
      BuildContext context, String errorMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppMessages.errorTitle),
          content: Text(errorMsg),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog when the button is pressed
                Navigator.of(context).pop();
              },
              child: const Text(AppMessages.closeTitle),
            ),
          ],
        );
      },
    );
  }
}
