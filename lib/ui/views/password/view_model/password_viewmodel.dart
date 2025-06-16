import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as ApiService;
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/password/model/password_model.dart';
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

      loginUser(email, password);

      if (result.isSignedIn) {
        Fluttertoast.showToast(msg: "Signed in successfully!");
        isSignedIn = true;
        // navigationService.clearStackAndShow(Routes.homeView);
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

  Future<void> loginUser(String email, String password) async {
    final dio = Dio();

    const String url =
        'https://cognito-idp.us-west-2.amazonaws.com'; // full URL

    final Map<String, dynamic> loginPayload = {
      "AuthParameters": {
        "USERNAME": "amuthakumari.g@gmail.com",
        "PASSWORD": "32132Test@"
      },
      "AuthFlow": "USER_PASSWORD_AUTH",
      "ClientId": "gcdvf03t4358m5kvu1ckrkd9g"
    };
//application/x-amz-json-1.1
    final headers = {
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.InitiateAuth', // ✅ Correct value
    };

    try {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));

      final response = await dio.post(
        url,
        data: loginPayload,
        options: Options(
          headers: headers,
          sendTimeout: const Duration(seconds: 3000),
          receiveTimeout: const Duration(seconds: 3000),
        ),
      );

      print('Login Success: ${response.statusCode}');
      print('✅ Login Success: ${response.data}');
      final model = PasswordModel.fromJson(response.data);
      print('Access Token: ${model.authenticationResult.accessToken}');

      final loginModel = PasswordModel.fromJson(response.data);
      print(loginModel.authenticationResult.accessToken);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          print(responseData[0]); // ✅ Access by index if it’s a list
        } else if (responseData is Map) {
          print(responseData['message']); // ✅ Access by key if it's a map
        }
        if (responseData['AuthenticationResult'] != null) {
          final authResult = responseData['AuthenticationResult'];
          final accessToken = authResult['AccessToken'];
          final idToken = authResult['IdToken'];
          final refreshToken = authResult['RefreshToken'];

          // Store tokens securely or use them as needed
          safePrint("Access Token: $accessToken");
          safePrint("ID Token: $idToken");
          safePrint("Refresh Token: $refreshToken");

          // Optionally, navigate to the home view or perform other actions
          // navigationService.clearStackAndShow(Routes.homeView);
        } else {
          Fluttertoast.showToast(msg: "Login failed. Please try again.");
        }
      } else {
        print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioException) {
        print('Login Failed: ${e.response?.data}');
      } else {
        print('Unexpected error: $e');
      }
    }
  }

  // Future<Map<String, String>> loginAPICall(
  //     BuildContext context, String email, String password) async {
  //   try {
  //     final url = Uri.parse(ApiConstants.loginAWSUrl); // Replace with your API

  //     safePrint("Login API URL: $url");
  //     Map<String, dynamic> loginPayload = {
  //       "AuthParameters": {"USERNAME": email, "PASSWORD": password},
  //       "AuthFlow": "USER_PASSWORD_AUTH",
  //       "ClientId": ksAWSClientId,
  //     };
  //     safePrint(loginPayload);
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         "Content-Type": "application/x-amz-json-1.1",
  //         "X-Amz-Target": "AWSCognitoIdentityProviderService.InitiateAuth"
  //       },
  //       body: jsonEncode(loginPayload),
  //     );
  //     print("Success: ${response.body}");
  //     safePrint("Response status: ${response.statusCode}");
  //     if (response.statusCode == 200) {
  //       print("Success: ${response.body}");
  //       final responseData = jsonDecode(response.body);
  //       if (responseData['AuthenticationResult'] != null) {
  //         final authResult = responseData['AuthenticationResult'];
  //         final accessToken = authResult['AccessToken'];
  //         final idToken = authResult['IdToken'];
  //         final refreshToken = authResult['RefreshToken'];

  //         // Store tokens securely or use them as needed
  //         safePrint("Access Token: $accessToken");
  //         safePrint("ID Token: $idToken");
  //         safePrint("Refresh Token: $refreshToken");

  //         // Optionally, navigate to the home view or perform other actions
  //         // navigationService.clearStackAndShow(Routes.homeView);
  //       } else {
  //         Fluttertoast.showToast(msg: "Login failed. Please try again.");
  //       }
  //     } else {
  //       print("Failed: ${response.statusCode}");
  //     }
  //   } on AuthException catch (e) {
  //     Fluttertoast.showToast(msg: e.message);
  //   }
  //   // Return an empty map or throw as appropriate
  //   return <String, String>{};
  // }
}
