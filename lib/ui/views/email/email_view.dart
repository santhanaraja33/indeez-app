import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    ThemeData emailTheme = Theme.of(context);

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
                      label: Text(
                        ksEmail,
                        style: emailTheme.textTheme.titleLarge
                            ?.copyWith(fontSize: size_16.sp, color: kcTextGrey),
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
                            style: emailTheme.textTheme.titleLarge?.copyWith(
                                fontSize: size_16.sp,
                                color: kcPinkColor,
                                fontWeight: FontWeight.w600),
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
                        style: emailTheme.textTheme.titleLarge?.copyWith(
                            fontSize: size_16.sp,
                            color: kcPinkColor,
                            fontWeight: FontWeight.w600),
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
