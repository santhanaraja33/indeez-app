import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textbutton.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/email/view_model/email_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

Widget appLogoImageWidget(String image) {
  return Center(
    child: Image.asset(
      AppImage.appLogoGif,
      height: height_200,
      width: width_200,
      fit: BoxFit.cover,
    ),
  );
}

Widget emailTextFieldWidget(
    dynamic viewModel, TextEditingController controller) {
  return AppCommonTextfield(
    controller: viewModel.emailController,
    label: Text(
      ksEmail,
      style: GoogleFonts.lato(color: kcTextGrey),
    ),
    onSubmitted: (p0) {},
  );
}

Widget signInButtonWidget(dynamic viewModel, BuildContext context) {
  return AppCommonButton(
    width: double.infinity,
    backgroundColor: kcButtonColr,
    onPressed: () {
      final email = viewModel.emailController.text.trim();
      viewModel.handleSignIn(context, email);
    },
    buttonName: ksSignIn,
  );
}

Widget appCommonTextButtonWidget(
    dynamic viewModel, BuildContext context, String buttonName) {
  return Row(
    children: [
      const Spacer(),
      const SizedBox(
        height: height_60,
      ),
      AppCommonTextbutton(
        onPressed: () {
          if (buttonName == ksMoreOption) {
            viewModel.showActionSheet(context);
          } else if (buttonName == ksSignup) {
            viewModel.navigationToSignUP();
          }
        },
        buttonName: buttonName,
      ),
      const Spacer(),
    ],
  );
}

Widget listTileWidget(BuildContext context, String from, dynamic viewModel) {
  var emailViewModel = EmailViewModel();
  emailViewModel = viewModel;
  final navigationService = locator<NavigationService>();
  return ListTile(
    title: textWidget(from),
    onTap: () async {
      if (from == ksUseBiometrics) {
        debugPrint("Biometrics clicked");
        emailViewModel.authenticateWithBiometrics(context);
      } else if (from == ksUsePassword) {
        debugPrint("Use password clicked");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigationService.clearStackAndShow(Routes.passwordView);
        });
      } else if (from == ksCancel) {
        Navigator.pop(context);
      }
    },
  );
}

Widget textWidget(String from) {
  return Text(from,
      textAlign: TextAlign.center,
      style: GoogleFonts.lato(
        fontSize: size_16,
        fontWeight: FontWeight.bold,
        color: kcBlack,
      ));
}
