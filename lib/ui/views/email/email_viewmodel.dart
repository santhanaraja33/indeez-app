import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/otp_verify/otp_verify_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:local_auth/local_auth.dart';

class EmailViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();

  final navigationService = locator<NavigationService>();

  final LocalAuthentication auth = LocalAuthentication();

  String _message = "Not Authenticated";

  void navigationToSignUP() {
    navigationService.navigateToSignupView();
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void handleSignIn(BuildContext context, String email) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(msg: "Email is required!");
        return;
      }
      bool isValid = isValidEmail(email);
      if (!isValid) {
        Fluttertoast.showToast(msg: "Please enter a valid email address.");
        return;
      }

      CommonLoader.showLoader(context);
      await Future.delayed(const Duration(seconds: 1));

      signOutGlobally();

      safePrint("user email : $email");
      final result = await Amplify.Auth.signIn(
        username: email.trim(),
        options: const SignInOptions(
          pluginOptions: CognitoSignInPluginOptions(
            authFlowType: AuthenticationFlowType.customAuthWithoutSrp,
          ),
        ),
      );
      safePrint("user login result : $result");
      CommonLoader.hideLoader(context);

      await SharedPreferencesHelper.setEmailId(email.trim());
      await SharedPreferencesHelper.saveFromPage(
          ksSharedPreferenceFromPage, true);
      navigationService
          .clearStackAndShowView(OtpVerifyView(email: email.trim()));
    } on AuthException catch (e) {
      safePrint("Sign-in error: ${e.message}");
      if (e.message == "Missing final '@domain'") {
        Fluttertoast.showToast(msg: 'User Email is not registered');
      } else {
        Fluttertoast.showToast(msg: e.message);
      }
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
      safePrint('Error signing user out: ${globalSignOutException.message}');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
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
                  debugPrint("Use password clicked");
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    navigationService.clearStackAndShow(Routes.passwordView);
                  });
                },
              ),
              ListTile(
                title:
                    const Text('Use Biometrics', textAlign: TextAlign.center),
                onTap: () async {
                  debugPrint("Biometrics clicked");
                  authenticateWithBiometrics(ctx);
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
      debugPrint("Biometric authentication not available.");
      return;
    }

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    debugPrint("Available biometrics: $availableBiometrics");

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
        Fluttertoast.showToast(msg: "Authenticated successfully!");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigationService.clearStackAndShow(Routes.bottomBarView);
        });
      } else {
        debugPrint("Authentication failed.");
        Fluttertoast.showToast(msg: "Authentication failed.");
      }
      // Close the bottom sheet after authentication
    } catch (e) {
      debugPrint("Error using biometrics: $e");
      Fluttertoast.showToast(msg: "Error using biometrics: $e");
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
        Fluttertoast.showToast(msg: _message);
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
      _message = "Error: $e";
      Fluttertoast.showToast(msg: _message);
    }
  }
}
