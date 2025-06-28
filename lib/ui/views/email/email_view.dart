import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'email_viewmodel.dart';

class EmailView extends StackedView<EmailViewModel> {
  const EmailView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmailViewModel viewModel,
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
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: height_10,
                    ),
                    AppCommonTextfield(
                      controller: viewModel.emailController,
                      label: Text(
                        ksEmail,
                        style: GoogleFonts.lato(color: kcTextGrey),
                      ),
                    ),
                    const SizedBox(
                      height: height_20,
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
                    const Row(
                      children: [
                        Spacer(),
                        // TextButton(
                        //   onPressed: () {
                        //     viewModel.navigationToForgotPassword();
                        //   },
                        //   child: Text(
                        //     ksForgotPassword,
                        //     style: GoogleFonts.lato(
                        //       fontSize: size_16,
                        //       fontWeight: FontWeight.bold,
                        //       color: kcPinkColor,
                        //     ),
                        //   ),
                        // ),
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
                            style: GoogleFonts.lato(
                              fontSize: size_16,
                              fontWeight: FontWeight.bold,
                              color: kcPinkColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.showActionSheet(context);
                      },
                      child: Text(
                        ksMoreOption,
                        style: GoogleFonts.lato(
                          fontSize: size_16,
                          fontWeight: FontWeight.bold,
                          color: kcPinkColor,
                        ),
                      ),
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
  EmailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EmailViewModel();
}
