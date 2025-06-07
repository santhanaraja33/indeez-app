import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                'JERRY',
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kcTextGrey),
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
                  style: GoogleFonts.lato(
                    color: kcTextGrey,
                    fontSize: size_14,
                    fontWeight: FontWeight.bold,
                  ),
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
