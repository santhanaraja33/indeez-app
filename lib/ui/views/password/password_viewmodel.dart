import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.loader.dart';
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
      CommonLoader.showLoader(context);
      await Future.delayed(const Duration(seconds: 1));

      signOutGlobally();
      final result =
          await Amplify.Auth.signIn(username: email, password: password);
      print("user login result : ${result}");

      // print("user login result : ${result1}");

      print("password ${password}");

<<<<<<< HEAD
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
=======
      switch (result.nextStep.signInStep) {
        case AuthSignInStep.confirmSignInWithSmsMfaCode:
          final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
          _handleCodeDelivery(codeDeliveryDetails);
          break;
        case AuthSignInStep.confirmSignInWithNewPassword:
          safePrint('Enter a new password to continue signing in');
          break;
        case AuthSignInStep.confirmSignInWithCustomChallenge:
          final parameters = result.nextStep.additionalInfo;
          final prompt = parameters['prompt']!;
          safePrint(prompt);
          break;

        case AuthSignInStep.done:
          safePrint('Sign in is complete');
          fetchAuthSession();
          fetchCognitoAuthSession();
          challengeHint = result.nextStep.additionalInfo['hint'];
          safePrint('User is signed in: ${challengeHint}');

          break;
        case AuthSignInStep.continueSignInWithMfaSelection:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthSignInStep.continueSignInWithMfaSetupSelection:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthSignInStep.continueSignInWithTotpSetup:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthSignInStep.continueSignInWithEmailMfaSetup:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthSignInStep.confirmSignInWithTotpMfaCode:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthSignInStep.confirmSignInWithOtpCode:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthSignInStep.resetPassword:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthSignInStep.confirmSignUp:
          // TODO: Handle this case.
          throw UnimplementedError();
>>>>>>> upstream/main
      }
    } on AuthException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      print("Sign-in error fdsf: ${e.message}");
    }
  }

  Future<void> fetchAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      safePrint('User is signed in: ${result.isSignedIn}');
      safePrint('User is signed in: ${result}');
    } on AuthException catch (e) {
      safePrint('Error retrieving auth session: ${e.message}');
    }
  }

  Future<void> fetchCognitoAuthSession() async {
    try {
      final cognitoPlugin =
          Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();
      final identityId = result.identityIdResult.value;
      safePrint("Current result: $result");
      safePrint("Current identityId: $identityId");
      if (result.isSignedIn) {
        safePrint("User is signed in");
      } else {
        safePrint("User is not signed in");
      }
      safePrint("Current user's identity ID: $identityId");
    } on AuthException catch (e) {
      safePrint('Error retrieving auth session: ${e.message}');
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
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
