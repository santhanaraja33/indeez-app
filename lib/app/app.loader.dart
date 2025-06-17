import 'package:flutter/material.dart';

class CommonLoader {
  static void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent dismissing on tap outside
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void hideLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(); // close the dialog
  }
}
