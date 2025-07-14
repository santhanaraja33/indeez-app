import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/account_settings/view_model/account_settings_viewmodel.dart';
import 'package:music_app/ui/views/account_settings/widget/common_button_widget.dart';
import 'package:music_app/ui/views/bottom_bar/bottom_bar_view.dart';
import 'package:music_app/ui/views/email/widget/email_view_widget.dart';
import 'package:music_app/ui/views/followers/presentation/followers_list_view.dart';
import 'package:music_app/ui/views/following/presentation/following_list_view.dart';
import 'package:music_app/ui/views/home/presentation/home_view.dart';
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart'
    show RightmenuView;
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';

class AccountSettingsView extends StackedView<AccountSettingsViewmodel> {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AccountSettingsViewmodel viewModel,
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
                        child: Image.asset(
                      'assets/images/user.png',
                      height: height_100,
                      width: width_100,
                      fit: BoxFit.cover,
                      color: Colors.white,
                    )),
                    const SizedBox(
                      height: height_20,
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
