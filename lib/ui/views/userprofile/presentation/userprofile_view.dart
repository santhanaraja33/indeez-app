import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_bg_image.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_dropdown.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart';
import 'package:stacked/stacked.dart';
import '../view_model/userprofile_viewmodel.dart';

class UserprofileView extends StackedView<UserprofileViewModel> {
  const UserprofileView({Key? key}) : super(key: key);

  @override
  UserprofileViewModel viewModelBuilder(BuildContext context) =>
      UserprofileViewModel();

  @override
  void onViewModelReady(UserprofileViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getUserDetailAPI();
    });
  }

  @override
  Widget builder(
    BuildContext context,
    UserprofileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      endDrawer: const RightmenuView(),
      backgroundColor: kcBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: kcBgColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          AppImage.appLogoGif,
          height: height_50,
          width: width_50,
          fit: BoxFit.cover,
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            const AppCommonBGImage(),
            Padding(
              padding: const EdgeInsets.only(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: padding_20,
                    right: padding_20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: height_20,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              viewModel.isChecked = true;
                              viewModel.rebuildUi();
                            },
                            child: const Icon(
                              Icons.edit,
                              color: kcTextGrey,
                            ),
                          )
                        ],
                      ),
                      viewModel.userProfileImage != null &&
                              viewModel.userProfileImage!.isNotEmpty &&
                              viewModel.userProfileImage!.startsWith('http')
                          ? Center(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(borderRadius_100),
                                child: Image.network(
                                  viewModel.userProfileImage!,
                                  height: height_100,
                                  width: width_100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // ⛔️ Broken or unreachable URL fallback
                                    return Image.asset(
                                      'assets/images/user.png',
                                      height: height_100,
                                      width: width_100,
                                      fit: BoxFit.cover,
                                      color: Colors.white,
                                    );
                                  },
                                ),
                              ),
                            )
                          : ClipOval(
                              child: viewModel.userProfileImage != null &&
                                      viewModel.userProfileImage!.isNotEmpty
                                  ? Image.file(
                                      File(viewModel.userProfileImage!),
                                      fit: BoxFit.cover,
                                      height: height_100,
                                      width: width_100,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/user.png',
                                          height: height_100,
                                          width: width_100,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'assets/images/user.png',
                                      fit: BoxFit.cover,
                                      height: height_100,
                                      width: width_100,
                                    ),
                            ),
                      viewModel.isChecked == false
                          ? Container()
                          : const SizedBox(
                              height: height_10,
                            ),
                      viewModel.isChecked == false
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                viewModel.choosePhoto(context);
                              },
                              child: Text(
                                ksChangeProfile,
                                style: GoogleFonts.lato(
                                    fontSize: size_16,
                                    fontWeight: FontWeight.bold,
                                    color: kcWhite),
                              ),
                            ),
                      const SizedBox(
                        height: height_20,
                      ),
                      AppCommonTextfield(
                        controller: viewModel.firstNameController,
                        keyboardType: TextInputType.name,
                        readOnly: !viewModel.isChecked,
// 👈 disables input unless in edit mode
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
                        controller: viewModel.lastNameController,
                        keyboardType: TextInputType.name,
                        readOnly: !viewModel.isChecked,
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
                        controller: viewModel.emailController,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: !viewModel.isChecked,
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
                        maxLength: maxLength_10,
                        controller: viewModel.phoneController,
                        keyboardType: TextInputType.phone,
                        readOnly: !viewModel.isChecked,
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
                        controller: viewModel.zipCodeController,
                        keyboardType: TextInputType.streetAddress,
                        readOnly: !viewModel.isChecked,
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
                        dropDownHint: viewModel.listModeModel.first,
                        value: viewModel.listModeModel
                                .contains(viewModel.selectedValue)
                            ? viewModel.selectedValue
                            : null,
                        onChanged: (val) {
                          viewModel.selectedValue = val;
                          viewModel.rebuildUi();
                        },
                        items: viewModel.listModeModel
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.lato(
                                      fontSize: size_14,
                                      color: kcBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: height_30,
                      ),
                      viewModel.isChecked == false
                          ? Container()
                          : AppCommonButton(
                              width: double.infinity,
                              onPressed: () {
                                viewModel.userUpdateDetailAPI();
                              },
                              buttonName: ksUPDATE,
                            ),
                      const SizedBox(
                        height: height_20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
