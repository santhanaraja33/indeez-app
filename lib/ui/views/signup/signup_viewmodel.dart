import 'package:flutter/material.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    //  navigationService.clearStackAndShow(Routes.otpVerifyView);
    navigationService.clearStackAndShow(Routes.typeofuserView);

    // Email format validation
    // if (email.isNotEmpty || email.trim().isEmpty) {
    //   final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    //   if (!emailRegex.hasMatch(email)) {
    //     Fluttertoast.showToast(msg: "Invalid email format!");
    //     return;
    //   }
    // } else {
    //   Fluttertoast.showToast(msg: "Email Field is required");
    // }

    // Password strength validation (min 8 chars; you can enhance further)
    // if (password.length < 8) {
    //   Fluttertoast.showToast(msg: "Password must be at least 8 characters!");
    //   return;
    // }
    //
    // // Phone number basic validation
    // final phoneRegex = RegExp(r'^\+\d{10,15}$');
    // if (!phoneRegex.hasMatch(phone)) {
    //   Fluttertoast.showToast(msg: "Phone must be in 10 digits");
    //   return;
    // }

    // final result = await Amplify.Auth.signUp(
    //   username: email,
    //   password: password,
    //   options: SignUpOptions(userAttributes: {
    //     AuthUserAttributeKey.email: email,
    //     AuthUserAttributeKey.phoneNumber: phone,
    //     AuthUserAttributeKey.givenName: firstName,
    //     AuthUserAttributeKey.familyName: lastName,
    //     // const CognitoUserAttributeKey.custom('zip_code'): zipCode,
    //     // const CognitoUserAttributeKey.custom('type_of_user'): userType,
    //   }),
    // );
    //
    // if (result.isSignUpComplete) {
    //   Fluttertoast.showToast(msg: "Sign up complete!");
    // } else {
    //   Fluttertoast.showToast(msg: "OTP sent to your email or phone");
    //   showOtpDialog(context, email);
    // }
  }

//Validate
  bool validatePasswordAndProceed() {
    final password = passwordController.text.trim();
    final confirmPassword = cnfpasswordController.text.trim();

    // if (password.isEmpty || confirmPassword.isEmpty) {
    //   Fluttertoast.showToast(msg: "Both fields are required!");
    //   return false;
    // }
    //
    // if (password.length < 8) {
    //   Fluttertoast.showToast(
    //       msg: "Password must be at least 8 characters long");
    //   return false;
    // }
    //
    // if (password != confirmPassword) {
    //   Fluttertoast.showToast(msg: "Passwords do not match!");
    //   return false;
    // }

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
  }
}
