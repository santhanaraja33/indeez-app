import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';

import 'create_account_viewmodel.dart';

class CreateAccountView extends StackedView<CreateAccountViewModel> {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateAccountViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Stack(
        children: [
          const AppCommonBGImage(),
          Padding(
            padding: const EdgeInsets.only(top: padding_100),
            child: Image.asset(
              AppImage.signupLandImage,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: viewModel.isChecked == false
                    ? null
                    : () {
                        viewModel.navigationToBottomBar();
                      },
                child: Center(
                  child: Image.asset(
                    AppImage.signupCreateAccountImage,
                    fit: BoxFit.cover,
                    color: viewModel.isChecked == false
                        ? kcimageDeactiveColor
                        : kcImageActiveColor,
                  ),
                ),
              )),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: height_150,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Checkbox(
                        side: WidgetStateBorderSide.resolveWith(
                          (states) =>
                              const BorderSide(width: width_2, color: kcWhite),
                        ),
                        value: viewModel.isChecked,
                        activeColor: kcWhite,
                        checkColor: kcLightGrey,
                        onChanged: (value) {
                          viewModel.checkBoxSelected(value ?? false);
                        }),
                    Text(
                      ksIAgreeToThe,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: size_16.sp,
                            color: kcTextGrey,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      width: width_5,
                    ),
                    Text(
                      ksTermsConditions,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: size_18.sp,
                          color: kcBlack,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  CreateAccountViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateAccountViewModel();
}
