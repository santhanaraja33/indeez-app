import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_dropdown.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/signup/view_model/signup_viewmodel.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';

// Ensure that signup_viewmodel.dart defines a class named SignupViewModel and it is exported properly.

class SignupView extends StackedView<SignupViewModel> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const AppCommonBGImage(),
            Image.asset(
              AppImage.cloudsImage,
              height: MediaQuery.of(context).size.height - height_300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppImage.handImage,
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      AppImage.signupIndeeImage,
                      fit: BoxFit.cover,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          AppImage.signUpZImage,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          AppImage.signUpswooptopImage,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    Image.asset(
                      AppImage.signUpswoopBottomImage,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: padding_20, right: padding_20),
                      child: Column(
                        children: [
                          AppCommonTextfield(
                            keyboardType: TextInputType.name,
                            controller: viewModel.firstNameController,
                            label: Text(
                              ksFirstName,
                              style: GoogleFonts.lato(color: kcTextGrey),
                            ),
                            onSubmitted: (p0) {},
                          ),
                          const SizedBox(
                            height: height_10,
                          ),
                          AppCommonTextfield(
                            keyboardType: TextInputType.name,
                            controller: viewModel.lastNameController,
                            label: Text(
                              ksLastName,
                              style: GoogleFonts.lato(color: kcTextGrey),
                            ),
                            onSubmitted: (p0) {},
                          ),
                          const SizedBox(
                            height: height_10,
                          ),
                          AppCommonTextfield(
                            keyboardType: TextInputType.emailAddress,
                            controller: viewModel.emailController,
                            label: Text(
                              ksEmail,
                              style: GoogleFonts.lato(color: kcTextGrey),
                            ),
                            onSubmitted: (p0) {},
                          ),
                          const SizedBox(
                            height: height_10,
                          ),
                          AppCommonTextfield(
                            maxLength: 13,
                            keyboardType: TextInputType.phone,
                            controller: viewModel.phoneController,
                            label: Text(
                              ksPhone,
                              style: GoogleFonts.lato(color: kcTextGrey),
                            ),
                            onSubmitted: (p0) {},
                          ),
                          const SizedBox(
                            height: height_10,
                          ),
                          AppCommonTextfield(
                            keyboardType: TextInputType.streetAddress,
                            controller: viewModel.zipCodeController,
                            label: Text(
                              ksZipcode,
                              style: GoogleFonts.lato(color: kcTextGrey),
                            ),
                            onSubmitted: (p0) {},
                          ),
                          const SizedBox(
                            height: height_10,
                          ),
                          AppDropDown(
                            titleTextColor: kcTextGrey,
                            dropDownHint: ksTypeofUser,
                            value: viewModel.selectedValue,
                            onChanged: (val) {
                              viewModel.selectedValue = val;
                              viewModel.rebuildUi();
                            },
                            items: viewModel.paymentModeModel
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: GoogleFonts.lato(
                                          fontSize: size_14,
                                          color: kcTextGrey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(
                            height: height_10,
                          ),
                          AppCommonTextfield(
                            obscureText: viewModel.isPassword,
                            keyboardType: TextInputType.streetAddress,
                            controller: viewModel.passwordController,
                            label: Text(
                              ksPassword,
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
                            controller: viewModel.cnfpasswordController,
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
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  side: WidgetStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                        width: 2, color: kcWhite),
                                  ),
                                  value: viewModel.isChecked,
                                  activeColor: kcWhite,
                                  checkColor: kcLightGrey,
                                  onChanged: (value) {
                                    viewModel.checkBoxSelected(value ?? false);
                                  }),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  ksPrivacypolicy,
                                  style: GoogleFonts.lato(
                                    color: kcTextGrey,
                                    decoration: TextDecoration.underline,
                                    decorationColor: kcWhite,
                                    fontSize: size_14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: width_5,
                              ),
                              Text(
                                ksand,
                                style: GoogleFonts.lato(
                                  color: kcTextGrey,
                                  fontSize: size_14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  ksTermsAndConditions,
                                  style: GoogleFonts.lato(
                                    color: kcTextGrey,
                                    decoration: TextDecoration.underline,
                                    decorationColor: kcWhite,
                                    fontSize: size_14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(
                            height: height_20,
                          ),
                          AppCommonButton(
                            width: double.infinity,
                            backgroundColor: kcButtonColr,
                            onPressed: () {
                              bool isValid =
                                  viewModel.validatePasswordAndProceed();
                              if (isValid) {
                                if (viewModel.isChecked) {
                                  viewModel.handleSignUP(
                                      context,
                                      viewModel.emailController.text.trim(),
                                      viewModel.passwordController.text.trim(),
                                      viewModel.phoneController.text.trim(),
                                      viewModel.firstNameController.text.trim(),
                                      viewModel.lastNameController.text.trim(),
                                      viewModel.zipCodeController.text.trim(),
                                      viewModel.selectedValue.toString());
                                } else {
                                  viewModel
                                      .showToast("Check the Privacy policy");
                                }
                              }
                            },
                            buttonName: ksNEXT,
                          ),
                          const SizedBox(
                            height: height_20,
                          ),
                        ],
                      ),
                    ),
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
  SignupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignupViewModel();
}
