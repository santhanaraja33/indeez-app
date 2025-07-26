import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:music_app/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const AppCommonBGImage(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    AppImage.appLogoGif,
                    height: height_200,
                    width: width_200,
                    // fit: BoxFit.fill,
                  ),
                ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    horizontalSpaceSmall,
                    SizedBox(
                      width: width_16,
                      height: height_16,
                      child: CircularProgressIndicator(
                        color: kcWhite,
                        strokeWidth: width_2,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}

class AppCommonBGImage extends StatelessWidget {
  const AppCommonBGImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImage.appBGImage,
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
    );
  }
}
