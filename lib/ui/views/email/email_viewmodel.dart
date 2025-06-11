import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/ui/views/otp_verify/otp_verify_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:email_validator/email_validator.dart';

class EmailViewModel extends BaseViewModel {
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

  void handleSignIn(BuildContext context, String email, String password) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(msg: "Email is required!");
        return;
      }
      bool isValid = EmailValidator.validate(email);
      if (!isValid) {
        Fluttertoast.showToast(msg: "Please enter a valid email address.");
        return;
      }

      signOutGlobally();
      final result =
          await Amplify.Auth.signIn(username: email, password: password);
      print("user login result : ${result}");

      showActionSheet(context);

      print("password ${password}");
      // OtpVerifyView(email: email);
      if (result.isSignedIn) {
        Fluttertoast.showToast(msg: "Signed in successfully!");
        isSignedIn = true;
        // navigationService.clearStackAndShow(Routes.homeView);
        showActionSheet(context);
      } else {
        switch (result.nextStep.signInStep) {
          case AuthSignInStep.confirmSignUp:
            Fluttertoast.showToast(msg: "Please confirm your account with OTP");
            showActionSheet(context);

            // showOtpDialog(context, email);
            break;
          case AuthSignInStep.confirmSignInWithCustomChallenge:
            Fluttertoast.showToast(msg: "Custom challenge. Enter OTP.");
            showActionSheet(context);

            // showOtpDialog(context, email);
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

  Future<void> handleMoreOption(BuildContext context) async {
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
  void showActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                // leading: Icon(Icons.edit),
                title: const Text('Use Password', textAlign: TextAlign.center),
                onTap: () {
                  if (kDebugMode) {
                    print("Use password clicked");
                    navigationService.replaceWithPasswordView();
                  }
                },
              ),
              ListTile(
                // leading: Icon(Icons.share),
                title:
                    const Text('Use Biometrics', textAlign: TextAlign.center),
                onTap: () {
                  if (kDebugMode) {
                    print("Biometrics clicked");
                  }
                },
              ),
              ListTile(
                // leading: Icon(Icons.delete),
                title: const Text('Cancel', textAlign: TextAlign.center),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
