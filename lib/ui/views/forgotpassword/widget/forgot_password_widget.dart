import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/email/widget/email_view_widget.dart';

Widget textButtonWidget(dynamic viewModel, BuildContext context, String email) {
  return Row(
    children: [
      const Spacer(),
      TextButton(
        onPressed: () {
          email = viewModel.emailController.text.trim();
          viewModel.navigationToOTPView(context, email);
        },
        child: textWidget(ksSendOTP),
      ),
      const Spacer(),
    ],
  );
}
