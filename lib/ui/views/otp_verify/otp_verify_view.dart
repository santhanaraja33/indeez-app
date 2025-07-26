import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: OtpTextField(
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                                fontSize: size_14.sp,
                                color: kcWhite,
                                fontWeight: FontWeight.bold),
                        numberOfFields: 6,
                        fieldWidth: 46,
                        fieldHeight: 50,
                        borderColor: const Color(0xFF512DA8),
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: true,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          //handle validation or checks here
                          verifyCode = code;
                        },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) {
                          verifyCode = verificationCode;
                          // Handle the OTP submission
                          // Optionally, you can navigate to another view or perform other actions
                          // For example:
                          // Navigator.pushNamed(context, '/nextView');
                        }, // end onSubmit
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
                    child: Text(ksResendOTP,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: size_16.sp,
                            color: kcPinkColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          viewModel.showOtpDialog(context, verifyCode);
                        },
                        child: Text(ksNEXT,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: size_20.sp,
                                    color: kcPinkColor,
                                    fontWeight: FontWeight.bold)),
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
