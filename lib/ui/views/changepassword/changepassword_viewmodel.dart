import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChangepasswordViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  bool isChecked = false;
  bool isPassword = true;
  bool isConfirmPassword = true;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfpasswordController = TextEditingController();
  final paymentModeModel = [
    'Fan',
    'Musician',
    'Label',
    'Venue',
    'Record Store',
  ];
  String? selectedValue;
  Future<void> confirmNewPassword(
      String email, String newPassword, String otp) async {
    email = 'amuthakumari.g@gmail.com';
    print('Password $email');
    print('Password $newPassword');
    print('Password $otp');

    String? otp1 = await getString('otp');
    print(otp1); // prints: amutha@example.com

    try {
      final result = await Amplify.Auth.confirmResetPassword(
        username: email,
        newPassword: newPassword,
        confirmationCode: otp1 ?? '',
      );
      print('Password reset result: $result');

      print('Password reset successful');
    } on AuthException catch (e) {
      print('Error: ${e.message}');
    } // navigationService.navigateToPasswordView();
  }

  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
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
}
