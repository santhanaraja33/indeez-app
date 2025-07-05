import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';

import 'bottom_bar_viewmodel.dart';

class BottomBarView extends StackedView<BottomBarViewModel> {
  const BottomBarView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BottomBarViewModel viewModel,
    Widget? child,
  ) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        endDrawer: viewModel.bottomBarSelectedIndex == 2
            ? null
            : const RightmenuView(),
        appBar: AppBar(
          actions: viewModel.bottomBarSelectedIndex == 2
              ? [
                  const Padding(
                    padding: EdgeInsets.only(right: padding_10),
                    child: Icon(
                      Icons.settings,
                      color: kcLGreen,
                      size: size_30,
                    ),
                  )
                ]
              : [],
          automaticallyImplyLeading: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: viewModel.bottomBarSelectedIndex == 0 ||
                  viewModel.bottomBarSelectedIndex == 2 ||
                  viewModel.bottomBarSelectedIndex == 3
              ? kcTransparent
              : kcBgColor,
          title: viewModel.bottomBarSelectedIndex == 2
              ? Container()
              : Image.asset(
                  AppImage.appLogoGif,
                  height: height_50,
                  width: width_50,
                  fit: BoxFit.cover,
                ),
        ),
        backgroundColor: kcBlack,
        body: Stack(
          children: [
            const AppCommonBGImage(),
            Center(
              child: IndexedStack(
                index: viewModel.bottomBarSelectedIndex,
                children: viewModel.pages,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          fixedColor: kcBottombarSelectedColor,
          backgroundColor: kcBlack,
          selectedIconTheme: const IconThemeData(
            color: kcBottombarSelectedColor,
            size: 40,
          ),
          unselectedIconTheme: const IconThemeData(
            color: kcBlue,
            size: 30,
          ),
          unselectedItemColor: kcBlue,
          items: List<BottomNavigationBarItem>.generate(
              viewModel.drawerItems.length, (index) {
            return BottomNavigationBarItem(
              icon: Icon(viewModel.drawerItems[index].icon),
              label: viewModel.drawerItems[index].title,
            );
          }),
          currentIndex: viewModel.bottomBarSelectedIndex,
          onTap: viewModel.onItemTapped,
        ),
      ),
    );
  }

  @override
  BottomBarViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BottomBarViewModel();
}
