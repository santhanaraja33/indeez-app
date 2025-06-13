import 'dart:math';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotpasswordViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final TextEditingController emailController = TextEditingController();

  var email = '';

  void navigationToOTPView(BuildContext context, String email) async {
    // navigationService.navigateToOtpVerifyView();
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Email is required!");
      return;
    }
    print("user login result : ${email}");
    final result1 = await Amplify.Auth.resetPassword(username: email.trim());

    print("user login result : ${result1}");
    navigationService.clearStackAndShow(Routes.otpVerifyView);
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }
}
