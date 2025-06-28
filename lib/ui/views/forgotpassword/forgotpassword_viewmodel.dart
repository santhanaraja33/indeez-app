import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotpasswordViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final TextEditingController emailController = TextEditingController();

  var email = '';

  void navigationToOTPView(BuildContext context, String email) async {
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Email is required!");
      return;
    }
    bool isValid = isValidEmail(email);
    if (!isValid) {
      Fluttertoast.showToast(msg: "Please enter a valid email address.");
      return;
    }
    await SharedPreferencesHelper.setEmailId(email.trim());

    final result1 = await Amplify.Auth.resetPassword(username: email.trim());
    await SharedPreferencesHelper.saveFromPage(
        ksSharedPreferenceFromForgotPasswordPage, true);
    navigationService.clearStackAndShow(Routes.otpVerifyView);
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}
