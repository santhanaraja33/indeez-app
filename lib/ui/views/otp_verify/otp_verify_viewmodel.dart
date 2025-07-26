import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OtpVerifyViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  bool isPassword = true;
  final String email = '';
  void navigationToChangePassword() {
    navigationService.navigateToChangepasswordView();
  }

  void showOtpDialog(BuildContext context, String otp) {
    print("email str : ${otp}");
    // if (otp.isEmpty) {
    //   Fluttertoast.showToast(msg: "Please enter OTP");
    //   return;
    // }
    // try {
    //   final result =
    //       await Amplify.Auth.confirmSignIn(confirmationValue: otp.trim());
    //   print("result : ${result}");
    //   if (result.isSignedIn) {
    //     Fluttertoast.showToast(msg: "Sign in confirmed!");
    navigationService.clearStackAndShow(Routes.bottomBarView);
    //   } else {
    //     Fluttertoast.showToast(msg: "Confirmation incomplete");
    //   }
    // } on AuthException catch (e) {
    //   print("error : ${e.message}");
    //   Fluttertoast.showToast(msg: e.message);
    // }
  }

  void handleResendOTP(BuildContext context, String email) {
    // if (email.isEmpty) {
    //   Fluttertoast.showToast(msg: "Email is required!");
    //   return;
    // }
    // try {
    //   final result =
    //       await Amplify.Auth.resendSignUpCode(username: email.trim());
    //   print("resend otp result : ${result}");
    Fluttertoast.showToast(msg: "OTP resent successfully!");
    // } on AuthException catch (e) {
    //   Fluttertoast.showToast(msg: e.message);
    // }
  }
}
