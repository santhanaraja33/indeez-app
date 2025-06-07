import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PasswordViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  bool isPassword = true;
  void navigationToSignUP() {
    navigationService.navigateToSignupView();
  }

  void isPasswordShow() {
    isPassword = !isPassword;
    rebuildUi();
  }

  void navigationToForgotPassword() {
    navigationService.navigateToForgotpasswordView();
  }

  void handleSignIn(String email) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(msg: "Email is required!");
        return;
      }

      final result = await Amplify.Auth.signIn(username: email);

      // ignore: unrelated_type_equality_checks
      if (result.nextStep.signInStep ==
          'CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE') {
        Fluttertoast.showToast(msg: "OTP sent to your email");
        // Show OTP field in the UI here
      }
    } on AuthException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      print("Sign-in error: ${e.message}");
    }
  }

  //Show Toast

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
