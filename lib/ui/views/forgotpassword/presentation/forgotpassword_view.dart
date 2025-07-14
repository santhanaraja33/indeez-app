import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/email/widget/email_view_widget.dart';
import 'package:music_app/ui/views/forgotpassword/widget/forgot_password_widget.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';

import '../view_model/forgotpassword_viewmodel.dart';

class ForgotpasswordView extends StackedView<ForgotpasswordViewModel> {
  const ForgotpasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ForgotpasswordViewModel viewModel,
    Widget? child,
  ) {
    String email = '';

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
                  appLogoImageWidget(AppImage.appLogoGif),
                  emailTextFieldWidget(viewModel, viewModel.emailController),
                  textButtonWidget(viewModel, context, email),
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
