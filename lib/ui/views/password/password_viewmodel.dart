import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PasswordViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final navigationService = locator<NavigationService>();
  bool isPassword = true;

  var isSignedIn = false;
  String? challengeHint;

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

  void handleSignIn(BuildContext context, String email, String password) {
    // try {
    // if (email.isEmpty) {
    //   Fluttertoast.showToast(msg: "Email is required!");
    //   return;
    // }
    // signOutGlobally();
    // final result =
    //     await Amplify.Auth.signIn(username: email, password: password);
    // print("user login result : ${result}");
    // final result1 =
    //     await Amplify.Auth.resetPassword(username: username)
    //     await Amplify.Auth.confirmResetPassword(username: username, newPassword: newPassword, confirmationCode: confirmationCode)

    // print("user login result : ${result1}");

    print("password ${password}");
    // OtpVerifyView(email: email);
    // if (result.isSignedIn) {
    //   Fluttertoast.showToast(msg: "Signed in successfully!");
    //   isSignedIn = true;
    navigationService.clearStackAndShow(Routes.bottomBarView);
    // } else {
    //   switch (result.nextStep.signInStep) {
    //     case AuthSignInStep.confirmSignUp:
    //       Fluttertoast.showToast(msg: "Please confirm your account with OTP");
    //       showOtpDialog(context, email);
    //       break;
    //     case AuthSignInStep.confirmSignInWithCustomChallenge:
    //       Fluttertoast.showToast(msg: "Custom challenge. Enter OTP.");
    //       showOtpDialog(context, email);
    //       break;
    //     default:
    //       print("Unhandled sign-in step: ${result.nextStep.signInStep}");
    //   }
    // }
    // } on AuthException catch (e) {
    //   Fluttertoast.showToast(msg: e.message);
    //   print("Sign-in error fdsf: ${e.message}");
    // }
  }

// Future<void> signOutCurrentUser() async {
//     final result = await Amplify.Auth.signOut();
//     if (result is CognitoCompleteSignOut) {
//       safePrint('Sign out completed successfully');
//     } else if (result is CognitoFailedSignOut) {
//       safePrint('Error signing user out: ${result.exception.message}');
//     }
//   }

/*
 //   switch (result.nextStep.signInStep) {
        //     case AuthSignInStep.confirmSignUp:
        //       Fluttertoast.showToast(msg: "Please confirm your account with OTP");
        //       showOtpDialog(context, email);
        //       break;
        //     case AuthSignInStep.confirmSignInWithCustomChallenge:
        //       Fluttertoast.showToast(msg: "Custom challenge. Enter OTP.");
        //       showOtpDialog(context, email);
        //       break;
        //     default:
        //       print("Unhandled sign-in step: ${result.nextStep.signInStep}");
        //   }
        // }
        */

// Sign out

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

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  //OTP Popup
  void showOtpDialog(BuildContext context, String email) {
    final TextEditingController otpController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter OTP"),
          content: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter the 6-digit OTP",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final otp = otpController.text.trim();

                if (otp.isEmpty) {
                  Fluttertoast.showToast(msg: "Please enter OTP");
                  return;
                }

                // try {
                // final result = await Amplify.Auth.confirmSignUp(
                //   username: email,
                //   confirmationCode: otp,
                // );

                // if (result.isSignUpComplete) {
                Fluttertoast.showToast(msg: "Sign-up confirmed!");
                Navigator.pop(context);
                // } else {
                //   Fluttertoast.showToast(msg: "Confirmation incomplete");
                // }
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
