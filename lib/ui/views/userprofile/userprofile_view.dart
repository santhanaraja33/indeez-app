import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_bg_image.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_dropdown.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart';
import 'package:stacked/stacked.dart';

import 'userprofile_viewmodel.dart';

class UserprofileView extends StackedView<UserprofileViewModel> {
  const UserprofileView({Key? key}) : super(key: key);

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
        title: Image.asset(
          AppImage.appLogoGif,
          height: height_50,
          width: width_70,
          // fit: BoxFit.cover,
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
                      (viewModel.userProfileImage ?? '').isEmpty
                          ? Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  borderRadius_100,
                                ),
                                child: Image.network(
                                  ksUserProfile,
                                  height: height_100,
                                  width: width_100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : ClipOval(
                              child: Image.file(
                                File(viewModel.userProfileImage ?? ''),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontSize: size_14.sp,
                                        color: kcWhite,
                                        fontWeight: FontWeight.w400),
                              ),
                            ),
                      const SizedBox(
                        height: height_20,
                      ),
                      AppCommonTextfield(
                        controller: TextEditingController(text: 'Jerry'),
                        keyboardType: TextInputType.name,
                        label: Text(
                          ksFirstName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: size_14.sp,
                                  color: kcTextGrey,
                                  fontWeight: FontWeight.w400),
                        ),
                        onSubmitted: (p0) {},
                      ),
                      const SizedBox(
                        height: height_10,
                      ),
                      AppCommonTextfield(
                        controller: TextEditingController(text: 'G'),
                        keyboardType: TextInputType.name,
                        label: Text(
                          ksLastName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: size_14.sp,
                                  color: kcTextGrey,
                                  fontWeight: FontWeight.w400),
                        ),
                        onSubmitted: (p0) {},
                      ),
                      const SizedBox(
                        height: height_10,
                      ),
                      AppCommonTextfield(
                        controller:
                            TextEditingController(text: 'jerry@yopmail.com'),
                        keyboardType: TextInputType.emailAddress,
                        label: Text(
                          ksEmail,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: size_14.sp,
                                  color: kcTextGrey,
                                  fontWeight: FontWeight.w400),
                        ),
                        onSubmitted: (p0) {},
                      ),
                      const SizedBox(
                        height: height_10,
                      ),
                      AppCommonTextfield(
                        maxLength: maxLength_10,
                        controller: TextEditingController(text: '9090009090'),
                        keyboardType: TextInputType.phone,
                        label: Text(
                          ksPhone,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: size_14.sp,
                                  color: kcTextGrey,
                                  fontWeight: FontWeight.w400),
                        ),
                        onSubmitted: (p0) {},
                      ),
                      const SizedBox(
                        height: height_10,
                      ),
                      AppCommonTextfield(
                        controller: TextEditingController(text: '641010'),
                        keyboardType: TextInputType.streetAddress,
                        label: Text(
                          ksZipcode,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: size_14.sp,
                                  color: kcTextGrey,
                                  fontWeight: FontWeight.w400),
                        ),
                        onSubmitted: (p0) {},
                      ),
                      const SizedBox(
                        height: height_10,
                      ),
                      AppDropDown(
                        titleTextColor: kcTextGrey,
                        dropDownHint: viewModel.paymentModeModel.first,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize: size_14.sp,
                                            color: kcTextGrey,
                                            fontWeight: FontWeight.w400),
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
                              onPressed: () {},
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

  @override
  UserprofileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserprofileViewModel();
}
