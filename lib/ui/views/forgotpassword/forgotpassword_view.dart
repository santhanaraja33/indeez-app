import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';

import 'forgotpassword_viewmodel.dart';

class ForgotpasswordView extends StackedView<ForgotpasswordViewModel> {
  const ForgotpasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ForgotpasswordViewModel viewModel,
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
                      // fit: BoxFit.cover,
                    ),
                  ),
                  AppCommonTextfield(
                    label: Text(
                      ksEmail,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: size_14.sp, color: kcTextGrey),
                    ),
                    onSubmitted: (p0) {},
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          viewModel.navigationToOTPView();
                        },
                        child: Text(
                          ksSendOTP,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontSize: size_16.sp,
                                  color: kcPinkColor,
                                  fontWeight: FontWeight.w600),
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
  ForgotpasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForgotpasswordViewModel();
}
