import 'package:amplify_flutter/amplify_flutter.dart';

class ApiException implements Exception {
  final dynamic message;

  ApiException({required this.message});
  @override
  String toString() {
    if (message is String) {
      safePrint("exceptio message: $message");
      return message;
    } else {
      safePrint("exception message: No data found");
      return "No data found";
    }
  }
}
