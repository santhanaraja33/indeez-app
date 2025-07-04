import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_bg_image.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import '../view_model/password_viewmodel.dart';

class PasswordView extends StackedView<PasswordViewModel> {
  const PasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PasswordViewModel viewModel,
    Widget? child,
  ) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            const AppCommonBGImage(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: padding_20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: height_50),
                    Center(
                      child: Image.asset(
                        AppImage.appLogoGif,
                        height: height_200,
                        width: width_200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: height_10),
                    AppCommonTextfield(
                      controller: viewModel.emailController,
                      label: Text(
                        ksEmail,
                        style: GoogleFonts.lato(color: kcTextGrey),
                      ),
                    ),
                    const SizedBox(height: height_20),
                    AppCommonTextfield(
                      obscureText: viewModel.isPassword,
                      keyboardType: TextInputType.streetAddress,
                      controller: viewModel.passwordController,
                      label: Text(
                        ksPassword,
                        style: GoogleFonts.lato(color: kcTextGrey),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: viewModel.isPasswordShow,
                        child: Icon(
                          viewModel.isPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kcTextGrey,
                        ),
                      ),
                    ),
                    const SizedBox(height: height_20),
                    AppCommonButton(
                      width: double.infinity,
                      backgroundColor: kcButtonColr,
                      onPressed: () {
                        final email = viewModel.emailController.text.trim();
                        // viewModel.handleSignInWithOTP(context, email);
                        viewModel.handleSignIn(context, email,
                            viewModel.passwordController.text.trim());
                      },
                      buttonName: ksSignIn,
                    ),
                    const SizedBox(height: height_10),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: viewModel.navigationToForgotPassword,
                          child: Text(
                            ksForgotPassword,
                            style: GoogleFonts.lato(
                              fontSize: size_16,
                              fontWeight: FontWeight.bold,
                              color: kcPinkColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: height_50),
                    Center(
                      child: TextButton(
                        onPressed: viewModel.navigationToSignUP,
                        child: Text(
                          '$ksSignup',
                          style: GoogleFonts.lato(
                            fontSize: size_16,
                            fontWeight: FontWeight.bold,
                            color: kcPinkColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: height_20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  PasswordViewModel viewModelBuilder(BuildContext context) =>
      PasswordViewModel();
}
