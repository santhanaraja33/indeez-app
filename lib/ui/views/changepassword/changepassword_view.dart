import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';

import 'changepassword_viewmodel.dart';

class ChangepasswordView extends StackedView<ChangepasswordViewModel> {
  const ChangepasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChangepasswordViewModel viewModel,
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
                  AppCommonTextfield(
                    obscureText: viewModel.isPassword,
                    keyboardType: TextInputType.streetAddress,
                    label: Text(
                      ksNewPassword,
                      style: GoogleFonts.lato(color: kcTextGrey),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        viewModel.isPasswordShow();
                      },
                      child: Icon(
                        viewModel.isPassword == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: kcTextGrey,
                      ),
                    ),
                    onSubmitted: (p0) {},
                  ),
                  const SizedBox(
                    height: height_10,
                  ),
                  AppCommonTextfield(
                    obscureText: viewModel.isConfirmPassword,
                    keyboardType: TextInputType.streetAddress,
                    label: Text(
                      ksConfirmPassword,
                      style: GoogleFonts.lato(color: kcTextGrey),
                    ),
                    onSubmitted: (p0) {},
                    suffixIcon: GestureDetector(
                      onTap: () {
                        viewModel.isConfirmPasswordShow();
                      },
                      child: Icon(
                        viewModel.isConfirmPassword == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: kcTextGrey,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          viewModel.navigationToPasswordView();
                        },
                        child: Text(
                          ksSubmit,
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
  ChangepasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChangepasswordViewModel();
}
