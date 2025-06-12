import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/ui/views/otp_verify/otp_verify_view.dart';
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

  //Email OTP
  void handleSignInWithOTP(BuildContext context, String email) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(msg: "Email is required!");
        return;
      }

      final result = await Amplify.Auth.signIn(username: email);

      if (result.nextStep.signInStep ==
          'CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE') {
        showOtpDialog(context, email);

        final confirmRes =
            await Amplify.Auth.confirmSignIn(confirmationValue: "123456");
        if (confirmRes.isSignedIn) {
          print("Signed in!");
        } else {
          print("Next step: ${confirmRes.nextStep.signInStep}");
        }
      }

      // if (result.isSignedIn) {
      //   Fluttertoast.showToast(msg: "Signed in successfully!");
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
    } on AuthException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      print("Sign-in error: ${e.message}");
    }
  }

// Email and Password
  void handleSignIn(BuildContext context, String email, String password) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(msg: "Email is required!");
        return;
      }
      signOutGlobally();
      final result =
          await Amplify.Auth.signIn(username: email, password: password);
      print("user login result : ${result}");
      // final result1 =
      //     await Amplify.Auth.resetPassword(username: username)
      //     await Amplify.Auth.confirmResetPassword(username: username, newPassword: newPassword, confirmationCode: confirmationCode)

      // print("user login result : ${result1}");

      print("password ${password}");

      if (result.isSignedIn) {
        Fluttertoast.showToast(msg: "Signed in successfully!");
        isSignedIn = true;
        navigationService.clearStackAndShow(Routes.homeView);
      } else {
        switch (result.nextStep.signInStep) {
          case AuthSignInStep.confirmSignUp:
            Fluttertoast.showToast(msg: "Please confirm your account with OTP");
            showOtpDialog(context, email);
            break;
          case AuthSignInStep.confirmSignInWithCustomChallenge:
            Fluttertoast.showToast(msg: "Custom challenge. Enter OTP.");
            showOtpDialog(context, email);
            break;
          default:
            print("Unhandled sign-in step: ${result.nextStep.signInStep}");
        }
      }
    } on AuthException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      print("Sign-in error fdsf: ${e.message}");
    }
  }

// Future<void> signOutCurrentUser() async {
//     final result = await Amplify.Auth.signOut();
//     if (result is CognitoCompleteSignOut) {
//       safePrint('Sign out completed successfully');
//     } else if (result is CognitoFailedSignOut) {
//       safePrint('Error signing user out: ${result.exception.message}');
//     }
//   }
  Future<void> signOutGlobally() async {
    final result = await Amplify.Auth.signOut(
      options: const SignOutOptions(globalSignOut: true),
    );
    if (result is CognitoCompleteSignOut) {
      safePrint('Sign out completed successfully');
    } else if (result is CognitoPartialSignOut) {
      final globalSignOutException = result.globalSignOutException!;
      final accessToken = globalSignOutException.accessToken;
      // Retry the global sign out using the access token, if desired
      // ...
      safePrint('Error signing user out: ${globalSignOutException.message}');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
  }

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
  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }
// Sign out

  Future<void> handleSignOut(BuildContext context) async {
    try {
      await Amplify.Auth.signOut();
      Fluttertoast.showToast(msg: "Signed out");
    } on AuthException catch (e) {
      Fluttertoast.showToast(msg: e.message);
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
              onPressed: () async {
                final otp = otpController.text.trim();

                if (otp.isEmpty) {
                  Fluttertoast.showToast(msg: "Please enter OTP");
                  return;
                }
                try {
                  final result = await Amplify.Auth.confirmSignUp(
                    username: email,
                    confirmationCode: otp,
                  );

                  if (result.isSignUpComplete) {
                    Fluttertoast.showToast(msg: "Sign-up confirmed!");
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(msg: "Confirmation incomplete");
                  }
                } on AuthException catch (e) {
                  Fluttertoast.showToast(msg: e.message);
                }
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
