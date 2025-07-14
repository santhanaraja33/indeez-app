import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';

class PasswordViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final navigationService = locator<NavigationService>();
  bool isPassword = true;
  bool isSignedIn = false;
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

      final session = await Amplify.Auth.fetchAuthSession();

      if (result.isSignedIn) {
        Fluttertoast.showToast(msg: "Logged in successfully!");
        isSignedIn = true;
        if (session.isSignedIn && session is CognitoAuthSession) {
          await SharedPreferencesHelper()
              .saveLoginUserId(ksLoggedinUserId, session.userSubResult.value);
        }
        loginAPI(email, password);
        CommonLoader.hideLoader(context);
      } else {
        switch (result.nextStep.signInStep) {
          case AuthSignInStep.confirmSignUp:
            Fluttertoast.showToast(msg: "Please confirm your account with OTP");
            showOtpDialog(context, email);
            CommonLoader.hideLoader(context);
            break;
          case AuthSignInStep.confirmSignInWithCustomChallenge:
            Fluttertoast.showToast(msg: "Custom challenge. Enter OTP.");
            showOtpDialog(context, email);
            CommonLoader.hideLoader(context);
            break;
          default:
            print("Unhandled sign-in step: ${result.nextStep.signInStep}");
            CommonLoader.hideLoader(context);
        }
      }
    } on AuthException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      print("Sign-in error fdsf: ${e.message}");
      CommonLoader.hideLoader(context);
    }
  }

  Future<void> fetchAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      safePrint('User is signed in: ${result.isSignedIn}');
      final result1 = result.toJson();
      if (result is CognitoAuthSession) {
        // final isSignedIn = result.isSignedIn;
        // final userSub = result.userSubResult.value;
        // final accessToken = result.userPoolTokensResult.value.accessToken;
        // final idToken = result.userPoolTokensResult.value.idToken;
        // final refreshToken = result.userPoolTokensResult.value.refreshToken;
        // final identityId = result.identityIdResult.value;

        // print('✅ Signed In: $isSignedIn');
        // print('🔐 Access Token: $accessToken');
        // print('🪪 User Sub: $userSub');
        // print('🧾 ID Token: $idToken');
        // print('🔄 Refresh Token: $refreshToken');
        // print('🆔 Identity ID: $identityId');
      } else {
        print('⚠️ Not a Cognito session');
      }

      safePrint('User is signed in  Cognito: ${result1.keys.first}');
    } on AuthException catch (e) {
      safePrint('Error retrieving auth session: ${e.message}');
    }
  }

  Future<void> fetchCognitoAuthSession() async {
    try {
      final cognitoPlugin =
          Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();
      safePrint("Current user's result: $result");

      final identityId = result.identityIdResult.value;
      safePrint("Current user's identity ID: $identityId");

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

  Future<void> signOutGlobally() async {
    final result = await Amplify.Auth.signOut(
      options: const SignOutOptions(globalSignOut: true),
    );
    if (result is CognitoCompleteSignOut) {
      safePrint('Sign out completed successfully');
    } else if (result is CognitoPartialSignOut) {
      final globalSignOutException = result.globalSignOutException!;
      final _ = globalSignOutException.accessToken;
      // Retry the global sign out using the access token, if desired
      // ...
      safePrint('Error signing user out: ${globalSignOutException.message}');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
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
              child: const Text(cancelBtnMsg),
            ),
            ElevatedButton(
              onPressed: () async {
                final otp = otpController.text.trim();

                if (otp.isEmpty) {
                  Fluttertoast.showToast(msg: ksEnterOTP);
                  return;
                }
                try {
                  final result = await Amplify.Auth.confirmSignUp(
                    username: email,
                    confirmationCode: otp,
                  );

                  if (result.isSignUpComplete) {
                    Fluttertoast.showToast(msg: ksSignupConfirmed);
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(msg: ksConfirmationIncomplete);
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

//MARK: LOGIN API
  Future<void> loginAPI(String email, String password) async {
    final authResponse = await ApiService().loginWithDio(
      endpoint: '',
      data: {
        "AuthParameters": {
          "USERNAME": email,
          "PASSWORD": password,
        },
        "AuthFlow": "USER_PASSWORD_AUTH",
        "ClientId": "gcdvf03t4358m5kvu1ckrkd9g",
      },
    );

    if (authResponse != null) {
      safePrint("Login success.");
      Fluttertoast.showToast(msg: ksLoginSuccess);
      await SharedPreferencesHelper.saveAccessToken(
          ksAccessToekn, authResponse.authenticationResult.accessToken);
      await SharedPreferencesHelper.saveRefreshToken(
          ksRefreshToekn, authResponse.authenticationResult.refreshToken);

      await SharedPreferencesHelper.saveLoginStatus(true);
      navigationService.clearStackAndShow(Routes.bottomBarView);
    } else {
      safePrint("Login failed.");
      Fluttertoast.showToast(msg: ksLoginFailed);
      throw Exception(ksLoginFailed);
    }
  }
}
