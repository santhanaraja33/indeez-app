import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/changepassword/presentation/changepassword_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/views/signup/model/signup_model.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/core/api/api_endpoints.dart';

class OtpVerifyViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final TextEditingController otpController = TextEditingController();
  var signUpResponse = SignUpModel();
  final String email = '';
  final sharedPreferencesHelper = SharedPreferencesHelper();

  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void showOtpDialog(BuildContext context, String otp, String email) async {
    debugPrint(otp);

    if (otp.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter OTP");
      return;
    }

    try {
      CommonLoader.showLoader(context);
      await Future.delayed(const Duration(seconds: 1));

      bool? fromPage = await SharedPreferencesHelper.getFromPage(
          ksSharedPreferenceFromSignupPage);
      bool? fromPage1 =
          await SharedPreferencesHelper.getFromPage(ksSharedPreferenceFromPage);

      bool? forgotPageValue = await SharedPreferencesHelper.getFromPage(
          ksSharedPreferenceFromForgotPasswordPage);

      if (fromPage == true) {
        final result1 = await Amplify.Auth.confirmSignUp(
          username: email,
          confirmationCode: otp.trim(),
        );
        safePrint('User is signed in result1: $result1');

        SignupUserInfo? user = await SharedPreferencesHelper.getUser();
        if (user != null) {
        } else {
          Fluttertoast.showToast(msg: "User details not found.");
        }
        CommonLoader.hideLoader(context); // 🔧 Important to hide loader
        if (result1.isSignUpComplete) {
          if (user != null) {
            signupAPI(
                context,
                email,
                user.password,
                user.phoneNumber,
                user.firstName,
                user.lastName,
                user.zipCode,
                user.userType,
                user.userId,
                user.acceptPrivacyPolicy);
          }
        } else {
          Fluttertoast.showToast(msg: "Confirmation incomplete");
        }
        return;
      }

      if (fromPage1 == true) {
        final result1 = await Amplify.Auth.confirmSignIn(
          confirmationValue: otp.trim(),
        );
        safePrint("result : $result1");
        final result2 =
            await Amplify.Auth.fetchAuthSession() as CognitoAuthSession;
        safePrint('User is signed in: $result2');
        if (result1.isSignedIn) {
          List<AuthUserAttribute> attributes =
              await Amplify.Auth.fetchUserAttributes();

          final subAttribute = attributes.firstWhere(
            (attr) => attr.userAttributeKey == CognitoUserAttributeKey.sub,
            orElse: () => throw Exception('User sub not found'),
          );

          await sharedPreferencesHelper.saveLoginUserId(
              ksLoggedinUserId, subAttribute.value);
          print('User sub: ${subAttribute.value}');

          final accessToken = result2.userPoolTokensResult.value.accessToken;
          await SharedPreferencesHelper.saveAccessToken(
              ksAccessToekn, accessToken.raw);
        } else {
          safePrint('User is not signed in or no tokens available');
        }
        Fluttertoast.showToast(msg: "Sign in confirmed!");
        await SharedPreferencesHelper.saveLoginStatus(true);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigationService.clearStackAndShow(Routes.bottomBarView);
        });
      } else {
        Fluttertoast.showToast(msg: "Confirmation incomplete");
      }

      if (forgotPageValue != null && forgotPageValue) {
        await saveString('otp', otp.trim());
        CommonLoader.hideLoader(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigationService
              .clearStackAndShowView(ChangepasswordView(email, otp));
        }); // 🔧 Hide loader before navigating
        return;
      }

      CommonLoader.hideLoader(context);
    } on AuthException catch (e) {
      debugPrint("error : ${e.message}");
      Fluttertoast.showToast(msg: e.message);
      CommonLoader.hideLoader(context);
    } catch (e) {
      debugPrint("Unexpected error: $e");
      Fluttertoast.showToast(msg: "Something went wrong!");
      CommonLoader.hideLoader(context);
    }
  }

  Future<void> fetchAccessTokenAfterSignIn() async {
    try {
      // First, check if session is valid and signed in
    } on AuthException catch (e) {
      debugPrint('AuthException: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
    }
  }

  void handleResendOTP(BuildContext context, String? email) async {
    if (email!.isEmpty) {
      Fluttertoast.showToast(msg: ksEmailRequired);
      return;
    }
    try {
      final _ = await Amplify.Auth.resendSignUpCode(username: email.trim());
      Fluttertoast.showToast(msg: ksOTPSentSuccess);
    } on AuthException catch (e) {
      Fluttertoast.showToast(msg: e.message);
    }
  }

//Signup api call
  // This function handles the signup process by calling the API and processing the response.
  Future<void> signupAPI(
      BuildContext context,
      String email,
      String password,
      String phone,
      String firstName,
      String lastName,
      String zipCode,
      String userType,
      String userId,
      bool acceptPrivacyPolicy) async {
    CommonLoader.showLoader(context);
    final authResponse = await ApiService().signupWithDio(
      endpoint: ApiConstants.baseURL + ApiEndpoints.signupAPI,
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "zipCode": zipCode,
        "userType": userType,
        "acceptPrivacyPolicy": acceptPrivacyPolicy,
        "acceptTerms": acceptPrivacyPolicy,
        "avatarUrl": "https://cdn.example.com/avatars/default.png",
        "bio": "Singer/songwriter",
        "userId": userId
      },
    );
    signUpResponse = authResponse ?? SignUpModel();
    debugPrint(signUpResponse.message);
    if (signUpResponse.message == ksUserCreated) {
      Fluttertoast.showToast(msg: ksSignupConfirmed);
      await sharedPreferencesHelper.saveLoginUserId(
          ksLoggedinUserId, signUpResponse.userId ?? '');
      await SharedPreferencesHelper.saveLoginStatus(true);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigationService.clearStackAndShow(Routes.bottomBarView);
      });
      CommonLoader.hideLoader(context); // 🔧 Important to hide loader
    } else {
      debugPrint("Signup failed.");
      Fluttertoast.showToast(msg: "Error: ${signUpResponse.message}");
      CommonLoader.hideLoader(context); // 🔧 Important to hide loader
    }
  }
}
