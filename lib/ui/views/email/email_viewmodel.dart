import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/ui/views/otp_verify/otp_verify_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:local_auth/local_auth.dart';

class EmailViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void fetchData() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // simulate API call

    isLoading = false;
    notifyListeners();
  }

  final navigationService = locator<NavigationService>();
  bool isPassword = true;
  final LocalAuthentication auth = LocalAuthentication();
  String _message = "Not Authenticated";

  var isSignedIn = false;
  String? challengeHint;

  void navigationToSignUP() {
    navigationService.navigateToSignupView();
  }

  void isPasswordShow() {
    isPassword = !isPassword;
  }

  void navigationToForgotPassword() {
    navigationService.navigateToForgotpasswordView();
  }

  void handleSignIn(BuildContext context, String email, String password) async {
    // try {
    navigationService.clearStackAndShowView(OtpVerifyView(email: email.trim()));
    // } on AuthException catch (e) {
    //   Fluttertoast.showToast(msg: e.message);
    //   print("Sign-in error fdsf: ${e.message}");
    // }
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

  //Bottom Popup
  void showActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: const Text('Use Password', textAlign: TextAlign.center),
                onTap: () {
                  navigationService.replaceWithPasswordView();
                },
              ),
              ListTile(
                title:
                    const Text('Use Biometrics', textAlign: TextAlign.center),
                onTap: () {
                  if (kDebugMode) {
                    authenticateWithBiometrics(ctx);
                    _authenticate();
                  }
                },
              ),
              ListTile(
                title: const Text('Cancel', textAlign: TextAlign.center),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> authenticateWithBiometrics(BuildContext context) async {
    bool canCheck = await auth.canCheckBiometrics;
    bool isDeviceSupported = await auth.isDeviceSupported();

    if (!canCheck || !isDeviceSupported) {
      return;
    }

    List<BiometricType> _ = await auth.getAvailableBiometrics();

    try {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (didAuthenticate) {
      } else {
        print("Authentication failed.");
      }
      Navigator.pop(context); // Close the bottom sheet after authentication
    } catch (e) {
      print("Error using biometrics: $e");
    }
  }

  Future<void> _authenticate() async {
    bool isAuthenticated = false;

    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        // setState(() {
        _message = "Biometric authentication not available.";
        // });
        return;
      }

      isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      isAuthenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      // setState(() {
      _message = "Error: $e";
      // });
    }
  }
}
