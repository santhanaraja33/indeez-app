import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';

import 'otp_verify_viewmodel.dart';

class OtpVerifyView extends StackedView<OtpVerifyViewModel> {
  const OtpVerifyView({Key? key, required String email}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OtpVerifyViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const AppCommonBGImage(),
            Padding(
              padding:
                  const EdgeInsets.only(left: padding_20, right: padding_20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      AppImage.appLogoGif,
                      height: height_200,
                      width: width_200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  OtpTextField(
                    textStyle: GoogleFonts.lato(
                      fontSize: size_16,
                      fontWeight: FontWeight.bold,
                      color: kcWhite,
                    ),
                    fieldWidth: width_60,
                    numberOfFields: 4,
                    borderColor: const Color(0xFF512DA8),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {}, // end onSubmit
                  ),
                  const SizedBox(
                    height: height_20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      ksResendOTP,
                      style: GoogleFonts.lato(
                        fontSize: size_16,
                        fontWeight: FontWeight.bold,
                        color: kcPinkColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          viewModel.navigationToChangePassword();
                        },
                        child: Text(
                          ksNEXT,
                          style: GoogleFonts.lato(
                            fontSize: size_20,
                            fontWeight: FontWeight.bold,
                            color: kcPinkColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  OtpVerifyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OtpVerifyViewModel();
}
