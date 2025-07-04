import 'package:flutter/material.dart';

class AppCommonToastmessages extends StatelessWidget {
  const AppCommonToastmessages({super.key});

  void showAppSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
