class ApiException implements Exception {
  final dynamic message;

  ApiException({required this.message});
  @override
  String toString() {
    if (message is String) {
      print("exceptio message: $message");
      return message;
    } else {
      print("exception message: No data found");
      return "No data found";
    }
  }
}
