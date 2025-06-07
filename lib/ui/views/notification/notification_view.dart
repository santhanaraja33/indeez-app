import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart';
import 'package:stacked/stacked.dart';

import 'notification_viewmodel.dart';

class NotificationView extends StackedView<NotificationViewModel> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NotificationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      endDrawer: const RightmenuView(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: kcBgColor,
        title: Image.asset(
          AppImage.appLogoGif,
          height: height_50,
          width: width_50,
          fit: BoxFit.cover,
        ),
      ),
      backgroundColor: kcBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: padding_20, right: padding_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: height_10,
              ),
              ListView.builder(
                itemCount: viewModel.notificationModel.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: padding_10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius_10),
                          border: Border.all(color: kcWhite)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: padding_10, right: padding_10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: height_10,
                            ),
                            Text(
                              viewModel.notificationModel[index].title ?? '',
                              style: GoogleFonts.lato(
                                  fontSize: size_18,
                                  fontWeight: FontWeight.bold,
                                  color: kcWhite),
                            ),
                            const SizedBox(
                              height: height_5,
                            ),
                            Text(
                              viewModel.notificationModel[index].subTitle ?? '',
                              style: GoogleFonts.lato(
                                  fontSize: size_14,
                                  fontWeight: FontWeight.bold,
                                  color: kcTextGrey),
                            ),
                            const SizedBox(
                              height: height_10,
                            ),
                            Text(
                              viewModel.notificationModel[index].date ?? '',
                              style: GoogleFonts.lato(
                                  fontSize: size_12,
                                  fontWeight: FontWeight.bold,
                                  color: kcTextGrey),
                            ),
                            const SizedBox(
                              height: height_10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: height_10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  NotificationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      NotificationViewModel();
}
