import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';

import 'rightmenu_viewmodel.dart';

class RightmenuView extends StackedView<RightmenuViewModel> {
  const RightmenuView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RightmenuViewModel viewModel,
    Widget? child,
  ) {
    return Drawer(
      backgroundColor: kcBlack,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: height_50,
            ),
            Center(
              child: Image.asset(
                AppImage.appLogoGif,
                height: height_100,
                width: width_100,
              ),
            ),
            Center(
              child: Text(
                'JERRY',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: size_16.sp,
                    color: kcTextGrey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Divider(),
            buildMenuRowUI(viewModel, context),
            const SizedBox(
              height: height_20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuRowUI(RightmenuViewModel viewModel, BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < (viewModel.drawerItems).length; i++) {
      var d = (viewModel.drawerItems)[i];
      drawerOptions.add(
        Column(
          children: [
            Center(
              child: ListTile(
                selectedColor: kcTextGrey,
                hoverColor: kcTransparent,
                leading: Icon(
                  d.icon,
                  color: kcTextGrey,
                ),
                title: Text(
                  (d.title ?? '').toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: size_14.sp,
                      color: kcTextGrey,
                      fontWeight: FontWeight.w400),
                ),
                selected: viewModel.selectedDrawerIndex == i,
                onTap: () {
                  viewModel.onSelectMenuItem(i, context);
                  viewModel.onSelectItem(i);
                },
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: drawerOptions,
    );
  }

  @override
  RightmenuViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RightmenuViewModel();
}
