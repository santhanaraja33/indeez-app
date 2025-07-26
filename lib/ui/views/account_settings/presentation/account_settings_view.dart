import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_dropdown.dart';
import 'package:music_app/ui/common/app_font_provider.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/account_settings/view_model/account_settings_viewmodel.dart';
import 'package:music_app/ui/views/account_settings/widget/common_button_widget.dart';
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart'
    show RightmenuView;
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class AccountSettingsView extends StackedView<AccountSettingsViewmodel> {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AccountSettingsViewmodel viewModel,
    Widget? child,
  ) {
    final fontNotifier = Provider.of<FontNotifier>(context);

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
            child: Stack(children: [
          const AppCommonBGImage(),
          Padding(
            padding: const EdgeInsets.only(),
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(
                    left: padding_30,
                    right: padding_30,
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: height_20,
                    ),
                    Center(
                        child: Image.network(
                      ksUserProfile,
                      height: height_100,
                      width: width_100,
                      fit: BoxFit.cover,
                      // color: Colors.white,
                    )),
                    const SizedBox(
                      height: height_20,
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        print("Image tapped");
                        // You can also call a method or navigate
                      },
                      child: Text(
                        'Upload Status',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: size_16.sp,
                            color: kcWhite,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontNotifier.currentFont),
                      ), // Just an example
                    )),
                    const SizedBox(
                      height: height_20,
                    ),
                    AppDropDown(
                      title: 'Theme',
                      dropDownHint: 'Theme',
                      value: viewModel.resourceTypes
                              .contains(viewModel.selectedResourceType)
                          ? viewModel.selectedResourceType
                          : null,
                      onChanged: (val) {
                        viewModel.themeUpdate(val!);
                      },
                      items: viewModel.resourceTypes.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: size_16.sp,
                                    color: kcBlack,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fontNotifier.currentFont),
                          ),
                        );
                      }).toList(),
                      titleTextColor: Colors.white,
                    ),
                    const SizedBox(
                      height: height_20,
                    ),
                    AppDropDown(
                      title: 'Fonts',
                      dropDownHint: 'Fonts',
                      value: viewModel.appFonts
                              .contains(viewModel.selectedAppFonts)
                          ? viewModel.selectedAppFonts
                          : null,
                      onChanged: (val) {
                        debugPrint('selected font $val');
                        viewModel.selectedAppFonts = val;
                        fontNotifier.setFont(val!);
                        viewModel.notifyListeners();
                      },
                      items: viewModel.appFonts.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: size_16.sp,
                                    color: kcBlack,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fontNotifier.currentFont),
                          ),
                        );
                      }).toList(),
                      titleTextColor: Colors.white,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flexible(
                          child: ListView.builder(
                            itemCount: viewModel.menuItems.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(viewModel
                                      .menuItems[index]), // Just an example
                                  accountSettingsWidget(viewModel, context,
                                      viewModel.menuItems[index], index),
                                ],
                              );
                            },
                          ),
                        )),
                  ])),
            ),
          ),
        ])));
  }

  @override
  AccountSettingsViewmodel viewModelBuilder(BuildContext context) =>
      AccountSettingsViewmodel();
}
