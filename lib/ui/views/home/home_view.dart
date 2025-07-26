import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_bg_image.dart';
import 'package:music_app/ui/common/app_font_provider.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    final font = Provider.of<FontNotifier>(context).currentFont;

    return Scaffold(
      body: Stack(
        children: [
          const AppCommonBGImage(),
          SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: padding_20, right: padding_20),
              child: Column(
                children: [
                  const SizedBox(
                    height: height_30,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.homeModel.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: padding_20),
                        child: Column(
                          children: [
                            Stack(
                              alignment: const Alignment(2, 0),
                              children: [
                                SizedBox(
                                    width: 300,
                                    height: 300,
                                    child: GestureDetector(
                                      onTap: () {
                                        viewModel.isImageSelected =
                                            !viewModel.isImageSelected;
                                        viewModel.rebuildUi();
                                      },
                                      child: viewModel.homeModel[index]
                                                  .isImageSelected ==
                                              true
                                          ? Image.asset(viewModel
                                                  .homeModel[index].bgImage ??
                                              '')
                                          : Image.asset(viewModel
                                                  .homeModel[index]
                                                  .musicImage1 ??
                                              ''),
                                    )),
                                SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: GestureDetector(
                                    onTap: () {
                                      viewModel.homeModel[index]
                                              .isImageSelected =
                                          !viewModel
                                              .homeModel[index].isImageSelected;
                                      viewModel.rebuildUi();
                                    },
                                    child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationZ(
                                          2 / 15,
                                        ),
                                        child: viewModel.homeModel[index]
                                                    .isImageSelected ==
                                                true
                                            ? Image.asset(viewModel
                                                    .homeModel[index].bgImage ??
                                                '')
                                            : Image.asset(viewModel
                                                    .homeModel[index]
                                                    .musicImage1 ??
                                                '')

                                        // CachedNetworkImage(
                                        //   fit: BoxFit.cover,
                                        //   imageUrl: viewModel.homeModel[index]
                                        //               .isImageSelected ==
                                        //           true
                                        //       ? viewModel
                                        //               .homeModel[index].bgImage ??
                                        //           ''
                                        //       : viewModel.homeModel[index]
                                        //               .musicImage1 ??
                                        //           '',
                                        //   placeholder: (context, url) => Column(
                                        //     children: [
                                        //       Transform.scale(
                                        //           scale: 0.6,
                                        //           child:
                                        //               const CircularProgressIndicator(
                                        //             color: kcWhite,
                                        //           )),
                                        //     ],
                                        //   ),
                                        //   errorWidget: (context, url, error) =>
                                        //       const Icon(Icons.error),
                                        // ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: height_20,
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                Text(
                                  viewModel.homeModel[index].title ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize: size_22.sp,
                                          color: kcWhite,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: font),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.popupPhotoUploadNavigation(context);
                              },
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Text(
                                    viewModel.homeModel[index].emoji ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize: size_16.sp,
                                            color: kcTextGrey,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: font),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: height_5,
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.popupPhotoUploadNavigation(context);
                              },
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Text(
                                    '${viewModel.homeModel[index].commends ?? ''} $ksCOMMENTS',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize: size_14.sp,
                                            color: kcWhite,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: font),
                                  ),
                                  const SizedBox(
                                    width: width_10,
                                  ),
                                  Text(
                                    '${viewModel.homeModel[index].reactions ?? ''} $ksREACTIONS',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize: size_14.sp,
                                            color: kcWhite,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: font),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: height_30,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
