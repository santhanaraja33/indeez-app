import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/email/widget/email_view_widget.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import '../view_model/email_viewmodel.dart';

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
                    appLogoImageWidget(AppImage.appLogoGif),
                    const SizedBox(
                      height: height_10,
                    ),
                    emailTextFieldWidget(viewModel, viewModel.emailController),
                    const SizedBox(
                      height: height_20,
                    ),
                    const SizedBox(
                      height: height_20,
                    ),
                    signInButtonWidget(viewModel, context),
                    const Row(
                      children: [
                        Spacer(),
                      ],
                    ),
                    appCommonTextButtonWidget(viewModel, context, ksSignup),
                    appCommonTextButtonWidget(viewModel, context, ksMoreOption),
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
