import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
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

  void showOtpDialog(BuildContext context, String otp, String email) async {
    print("email str : ${otp}");
    if (otp.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter OTP");
      return;
    }
    try {
      signOutGlobally();

      // final SignInResult result = await Amplify.Auth.signIn(
      //   username: email.trim(),
      //   password: "",
      // );
      print("result signin : ${email}");

      final result = await Amplify.Auth.signIn(
        username: email.trim(),
        options: const SignInOptions(
          pluginOptions: CognitoSignInPluginOptions(
            authFlowType: AuthenticationFlowType.customAuthWithoutSrp,
          ),
        ),
      );
      print("user login result : ${result}");

      final result1 =
          await Amplify.Auth.confirmSignIn(confirmationValue: otp.trim());
      print("result : ${result1}");

      if (result1.isSignedIn) {
        Fluttertoast.showToast(msg: "Sign in confirmed!");
        navigationService.clearStackAndShow(Routes.homeView);
      } else {
        Fluttertoast.showToast(msg: "Confirmation incomplete");
      }
    } on AuthException catch (e) {
      print("error : ${e.message}");
      Fluttertoast.showToast(msg: e.message);
    }
  }

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

  void handleResendOTP(BuildContext context, String email) async {
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Email is required!");
      return;
    }
    try {
      final result =
          await Amplify.Auth.resendSignUpCode(username: email.trim());
      print("resend otp result : ${result}");
      Fluttertoast.showToast(msg: "OTP resent successfully!");
    } on AuthException catch (e) {
      Fluttertoast.showToast(msg: e.message);
    }
  }
}
