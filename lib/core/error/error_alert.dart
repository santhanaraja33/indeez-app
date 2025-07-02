import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_strings.dart';

class AppError {
  static void showDialogWithExternalFunction(
      BuildContext context, String errorMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(errorTitle),
          content: Text(errorMsg),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog when the button is pressed
                Navigator.of(context).pop();
              },
              child: const Text(closeTitle),
            ),
          ],
        );
      },
    );
  }
}
