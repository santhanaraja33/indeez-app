import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music_app/ui/views/password/view_model/password_viewmodel.dart';

class LoginProvider extends ChangeNotifier {
  final loginServices = PasswordViewModel();

  bool isLoading = false;

  Future<Map<String, String>> getLoginInfo(
      BuildContext context, String email, String password) async {
    isLoading = true;

    notifyListeners();

    final response = await loginServices.loginAPICall(
      context,
      email,
      password, // TODO: Replace '' with the actual value required for the third argument
    );
    safePrint('Login response: $response.toString()');
    safePrint(response);
    isLoading = false;
    notifyListeners();
    return response;
  }
}
