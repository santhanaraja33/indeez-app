import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/otp_verify/otp_verify_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:local_auth/local_auth.dart';

class EmailViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void fetchData() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2)); // simulate API call

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
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(msg: "Email is required!");
        return;
      }
      bool isValid = EmailValidator.validate(email);
      if (!isValid) {
        Fluttertoast.showToast(msg: "Please enter a valid email address.");
        return;
      }
      if (isLoading) {
        Fluttertoast.showToast(msg: "Please wait, loading...");
        return;
      }
      CommonLoader.showLoader(context);
      await Future.delayed(const Duration(seconds: 1));

      signOutGlobally();

      print("user login result : ${email}");

      final result = await Amplify.Auth.signIn(
        username: email.trim(),
        options: const SignInOptions(
          pluginOptions: CognitoSignInPluginOptions(
            authFlowType: AuthenticationFlowType.customAuthWithoutSrp,
          ),
        ),
      );
      print("user login result : ${result}");
      await SharedPreferencesHelper.saveFromPage(
          ksSharedPreferenceFromPage, true);

      navigationService
          .clearStackAndShowView(OtpVerifyView(email: email.trim()));
    } on AuthException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      print("Sign-in error fdsf: ${e.message}");
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

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
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

  Future<void> handleMoreOption(BuildContext context) async {
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
                  if (kDebugMode) {
                    print("Use password clicked");
                    navigationService.replaceWithPasswordView();
                  }
                },
              ),
              ListTile(
                title:
                    const Text('Use Biometrics', textAlign: TextAlign.center),
                onTap: () async {
                  if (kDebugMode) {
                    print("Biometrics clicked");
                    authenticateWithBiometrics(ctx);
                    // _authenticate();
                    // List<BiometricType> types =
                    //     await auth.getAvailableBiometrics();
                    // for (var type in types) {
                    //   print(type); // face, fingerprint, etc.
                    // }
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
      print("Biometric authentication not available.");
      return;
    }

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    print("Available biometrics: $availableBiometrics");

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
        Navigator.pop(context);
      } else {
        print("Authentication failed.");
      }
      // Close the bottom sheet after authentication
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

<<<<<<< HEAD
      Fluttertoast.showToast(msg: "Authentication Successfully");
=======
      isAuthenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
>>>>>>> upstream/main
    } catch (e) {
      // setState(() {
      _message = "Error: $e";
      // });
    }
  }
}
