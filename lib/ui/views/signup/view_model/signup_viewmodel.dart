import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/otp_verify/otp_verify_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/ui/views/signup/model/signup_model.dart';

class SignupViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  bool isChecked = false;
  bool isPassword = true;
  bool isConfirmPassword = true;
  final paymentModeModel = [
    'Fan',
    'Musician',
    'Label',
    'Venue',
    'Record Store',
  ];
  String? selectedValue;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfpasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController userTypeController = TextEditingController();

  void navigationToWhoAreYou() {
    navigationService.navigateToCreateAccountView();
  }

  void checkBoxSelected(bool value) {
    isChecked = value;
    rebuildUi();
  }

  void isPasswordShow() {
    isPassword = !isPassword;
    rebuildUi();
  }

  void isConfirmPasswordShow() {
    isConfirmPassword = !isConfirmPassword;
    rebuildUi();
  }

  String? getDropDownValue() {
    return selectedValue;
  }

  //Sign Up

  void handleSignUP(
    BuildContext context,
    String email,
    String password,
    String phone,
    String firstName,
    String lastName,
    String zipCode,
    String userType,
  ) async {
    try {
      signOutGlobally();
      // Email format validation
      if (email.isNotEmpty || email.trim().isEmpty) {
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(email)) {
          Fluttertoast.showToast(msg: "Invalid email format!");
          return;
        }
      } else {
        Fluttertoast.showToast(msg: "Email Field is required");
      }

      // Password strength validation (min 8 chars; you can enhance further)
      if (password.length < 8) {
        Fluttertoast.showToast(msg: "Password must be at least 8 characters!");
        return;
      }

      // Phone number basic validation
      final phoneRegex = RegExp(r'^\+\d{10,15}$');
      // if (!phoneRegex.hasMatch(phone)) {
      //   Fluttertoast.showToast(msg: "Phone must be in 10 digits");
      //   return;
      // }
      CommonLoader.showLoader(context);
      await Future.delayed(const Duration(seconds: 1));

      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(userAttributes: {
          AuthUserAttributeKey.email: email,
          AuthUserAttributeKey.phoneNumber: phone,
          AuthUserAttributeKey.givenName: firstName,
          AuthUserAttributeKey.familyName: lastName,
          // const CognitoUserAttributeKey.custom('zip_code'): zipCode,
          // const CognitoUserAttributeKey.custom('type_of_user'): userType,
        }),
      );
      print("Sign-up result: ${result}");
      // print("Sign-up result: ${result.userId}");

      if (result.isSignUpComplete) {
        Fluttertoast.showToast(msg: "Sign up complete!");
        CommonLoader.hideLoader(context);
      } else {
        Fluttertoast.showToast(msg: "OTP sent to your email");
        // showOtpDialog(context, email);

        CommonLoader.hideLoader(context);
        await SharedPreferencesHelper.saveFromPage(
            ksSharedPreferenceFromSignupPage, true);

        await SharedPreferencesHelper.saveUser(SignupUserInfo(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phone,
          zipCode: zipCode,
          password: password,
          userType: userType,
          userId: result.userId ?? "",
          acceptPrivacyPolicy: isChecked,
        ));

        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigationService.clearStackAndShowView(
            OtpVerifyView(email: email.trim()),
          );
        });
      }
    } on AuthException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      print("Sign-up error: ${e.message}");
      CommonLoader.hideLoader(context);
    }
  }

  //Global signout
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

//Validate
  bool validatePasswordAndProceed() {
    final fName = firstNameController.text.trim();
    final lName = lastNameController.text.trim();

    if (fName.isEmpty || lName.isEmpty) {
      Fluttertoast.showToast(msg: "First and Last name are required!");
      return false;
    }

    final email = emailController.text.trim();
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Email is required!");
      return false;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      Fluttertoast.showToast(msg: "Invalid email format!");
      return false;
    }

    final phone = phoneController.text.trim();
    if (phone.isEmpty) {
      Fluttertoast.showToast(msg: "Phone number is required!");
      return false;
    } else if (!RegExp(r'^\+\d{10,15}$').hasMatch(phone)) {
      Fluttertoast.showToast(msg: "Phone must be in 10 digits");
      return false;
    }
    final password = passwordController.text.trim();
    final confirmPassword = cnfpasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      Fluttertoast.showToast(msg: "Both fields are required!");
      return false;
    }

    if (password.length < 8) {
      Fluttertoast.showToast(
          msg: "Password must be at least 8 characters long");
      return false;
    }

    if (password != confirmPassword) {
      Fluttertoast.showToast(msg: "Passwords do not match!");
      return false;
    }

    return true;
  }

  //Otp Popup
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
                  safePrint('User is signup : ${result}');

                  try {
                    final result = await Amplify.Auth.fetchAuthSession();
                    safePrint('User is signed in: ${result.isSignedIn}');
                    safePrint('User is signed in: ${result}');
                  } on AuthException catch (e) {
                    safePrint('Error retrieving auth session: ${e.message}');
                  }

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
    passwordController.dispose();
    phoneController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    zipCodeController.dispose();
    userTypeController.dispose();
    super.dispose();
  }
}
