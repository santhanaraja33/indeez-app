import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';

import 'otp_verify_viewmodel.dart';

class OtpVerifyView extends StackedView<OtpVerifyViewModel> {
  final String email;

  const OtpVerifyView({Key? key, required this.email}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OtpVerifyViewModel viewModel,
    Widget? child,
  ) {
    String verifyCode = '';

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const AppCommonBGImage(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    MediaQuery.of(context).size.width * 0.015, // 5% of width
                vertical:
                    MediaQuery.of(context).size.height * 0.02, // 2% of height
              ),
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
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.9, // 90% of screen width
                      child: OtpTextField(
                        textStyle: GoogleFonts.lato(
                          fontSize: size_16,
                          fontWeight: FontWeight.bold,
                          color: kcWhite,
                        ),
                        keyboardType: TextInputType.number,
                        fieldWidth: 46,
                        fieldHeight: 50,
                        numberOfFields: 6,
                        borderColor: const Color(0xFF512DA8),
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) async {
                          FocusScope.of(context).unfocus();
                          verifyCode = verificationCode;
                          await SharedPreferencesHelper.saveOTP(
                            ksSharedPreferenceOTP,
                            verifyCode,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: height_20,
                  ),
                  TextButton(
                    onPressed: () {
                      viewModel.handleResendOTP(context, "");
                    },
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
                        onPressed: () async {
                          print("Entered verifyCode: $verifyCode");
                          verifyCode = await SharedPreferencesHelper.getOTP(
                                  ksSharedPreferenceOTP) ??
                              '';
                          viewModel.showOtpDialog(context, verifyCode, email);
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
