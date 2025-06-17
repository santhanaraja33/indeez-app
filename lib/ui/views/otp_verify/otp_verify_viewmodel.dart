import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/changepassword/changepassword_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerifyViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  bool isPassword = true;
  final TextEditingController otpController = TextEditingController();

  final String email = '';
  void navigationToChangePassword() {
    navigationService.navigateToChangepasswordView();
  }

  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // void showOtpDialog(BuildContext context, String otp, String email) async {
  //   if (otp.isEmpty) {
  //     Fluttertoast.showToast(msg: "Please enter OTP");
  //     return;
  //   }
  //   try {
  //     CommonLoader.showLoader(context);
  //     await Future.delayed(const Duration(seconds: 1));

  //     bool? fromPage = await SharedPreferencesHelper.getFromPage(
  //             ksSharedPreferenceFromSignupPage) ??
  //         await SharedPreferencesHelper.getFromPage(ksSharedPreferenceFromPage);

  //     bool fromPage1 = await SharedPreferencesHelper.getFromPage(
  //             ksSharedPreferenceFromForgotPasswordPage) ==
  //         ksSharedPreferenceForgotPasswordWithOTP;

  //     safePrint('fromPage: ${fromPage}');
  //     safePrint('fromPage1: ${fromPage1}');

  //     if (fromPage == true || fromPage == true) {
  //       //normal sign in
  //       final result1 =
  //           await Amplify.Auth.confirmSignIn(confirmationValue: otp.trim());
  //       final result2 = await Amplify.Auth.fetchAuthSession();
  //       safePrint('User is signed in: ${result2}');

  //       if (result1.isSignedIn) {
  //         Fluttertoast.showToast(msg: "Sign in confirmed!");
  //         navigationService.clearStackAndShow(Routes.bottomBarView);
  //       } else {
  //         Fluttertoast.showToast(msg: "Confirmation incomplete");
  //       }
  //       return;
  //     }
  //     if (fromPage1 == false) {
  //       //forgot password flow
  //       await saveString('otp', otp.trim());
  //       // navigationService.clearStackAndShow(Routes.changepasswordView);
  //       navigationService.clearStackAndShowView(ChangepasswordView(email, otp));
  //     }
  //     CommonLoader.hideLoader(context);
  //   } on AuthException catch (e) {
  //     print("error : ${e.message}");
  //     Fluttertoast.showToast(msg: e.message);
  //     CommonLoader.hideLoader(context);
  //   }
  // }

  void showOtpDialog(BuildContext context, String otp, String email) async {
    if (otp.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter OTP");
      return;
    }

    try {
      CommonLoader.showLoader(context);
      await Future.delayed(const Duration(seconds: 1));

      bool? fromPage = await SharedPreferencesHelper.getFromPage(
              ksSharedPreferenceFromSignupPage) ??
          await SharedPreferencesHelper.getFromPage(ksSharedPreferenceFromPage);

      var forgotPageValue = await SharedPreferencesHelper.getFromPage(
          ksSharedPreferenceFromForgotPasswordPage);

      bool isForgotPasswordFlow =
          forgotPageValue == ksSharedPreferenceForgotPasswordWithOTP;

      safePrint('fromPage: $fromPage');
      safePrint('isForgotPasswordFlow: $isForgotPasswordFlow');

      if (fromPage == true) {
        final result1 = await Amplify.Auth.confirmSignUp(
          username: email,
          confirmationCode: otp.trim(),
        );
        final result2 = await Amplify.Auth.fetchAuthSession();
        safePrint('User is signed in: $result2');

        CommonLoader.hideLoader(context); // 🔧 Important to hide loader

        if (result1.isSignUpComplete) {
          Fluttertoast.showToast(msg: "Sign in confirmed!");
          navigationService.clearStackAndShow(Routes.bottomBarView);
        } else {
          Fluttertoast.showToast(msg: "Confirmation incomplete");
        }
        return;
      }

      if (!isForgotPasswordFlow) {
        await saveString('otp', otp.trim());
        CommonLoader.hideLoader(context); // 🔧 Hide loader before navigating
        navigationService.clearStackAndShowView(
            ChangepasswordView(email, otp)); // check this constructor
        return;
      }

      CommonLoader.hideLoader(context);
    } on AuthException catch (e) {
      print("error : ${e.message}");
      Fluttertoast.showToast(msg: e.message);
      CommonLoader.hideLoader(context);
    } catch (e) {
      print("Unexpected error: $e");
      Fluttertoast.showToast(msg: "Something went wrong!");
      CommonLoader.hideLoader(context);
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
