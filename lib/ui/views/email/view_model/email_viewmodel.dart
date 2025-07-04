import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_common_toastmessages.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/email/widget/email_view_widget.dart';
import 'package:music_app/ui/views/otp_verify/otp_verify_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:local_auth/local_auth.dart';

class EmailViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();

  final navigationService = locator<NavigationService>();

  final LocalAuthentication auth = LocalAuthentication();

  Future<void> navigationToSignUP() async {
    navigationService.navigateToSignupView();
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  Future<void> handleSignIn(BuildContext context, String email) async {
    try {
      if (email.isEmpty) {
        const AppCommonToastmessages()
            .showAppSnackBar(context, ksEmailRequired);
        return;
      }
      bool isValid = isValidEmail(email);
      if (!isValid) {
        const AppCommonToastmessages()
            .showAppSnackBar(context, ksValidEmailAddress);
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
        const AppCommonToastmessages()
            .showAppSnackBar(context, ksEmailNotRegistered);
      } else {
        const AppCommonToastmessages().showAppSnackBar(context, e.message);
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

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  //Bottom Popup
  Future<void> showActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              listTileWidget(ctx, ksUsePassword, EmailViewModel()),
              listTileWidget(ctx, ksUseBiometrics, EmailViewModel()),
              listTileWidget(ctx, ksCancel, EmailViewModel()),
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
        const AppCommonToastmessages()
            .showAppSnackBar(context, ksAuthenticateBiometrics);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigationService.clearStackAndShow(Routes.bottomBarView);
        });
      } else {
        debugPrint("Authentication failed.");
        const AppCommonToastmessages()
            .showAppSnackBar(context, ksBiometricsAuthenticatioFailed);
      }
      // Close the bottom sheet after authentication
    } catch (e) {
      debugPrint("Error using biometrics: $e");
      const AppCommonToastmessages()
          .showAppSnackBar(context, "Error using biometrics: $e");
    }
  }
}
