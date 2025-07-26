import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'password_viewmodel.dart';

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
                    const SizedBox(
                      height: height_10,
                    ),
                    AppCommonTextfield(
                      controller: viewModel.emailController,
                      // obscureText: viewModel.isPassword,
                      label: Text(
                        ksEmail,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: size_14.sp, color: kcTextGrey),
                      ),
                    ),
                    const SizedBox(
                      height: height_20,
                    ),
                    AppCommonTextfield(
                      obscureText: viewModel.isPassword,
                      keyboardType: TextInputType.streetAddress,
                      controller: viewModel.passwordController,
                      label: Text(
                        ksPassword,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: size_14.sp, color: kcTextGrey),
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
                      height: height_20,
                    ),
                    AppCommonButton(
                      width: double.infinity,
                      backgroundColor: kcButtonColr,
                      onPressed: () {
                        final email = viewModel.emailController.text.trim();
                        final password =
                            viewModel.passwordController.text.trim();
                        viewModel.handleSignIn(context, email, password);
                      },
                      buttonName: ksSignIn,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            viewModel.navigationToForgotPassword();
                          },
                          child: Text(
                            ksForgotPassword,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: size_16.sp,
                                    color: kcPinkColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        const SizedBox(
                          height: height_100,
                        ),
                        TextButton(
                          onPressed: () {
                            viewModel.navigationToSignUP();
                          },
                          child: Text(
                            '$ksSignup?',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: size_16.sp,
                                    color: kcPinkColor,
                                    fontWeight: FontWeight.bold),
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
      ),
    );
  }

  @override
  PasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PasswordViewModel();
}
