import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_bg_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
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
                                GestureDetector(
                                  onTap: () async {
                                    final getUserId =
                                        await SharedPreferencesHelper
                                            .getLoginUserId(ksLoggedinUserId);
                                    debugPrint('User ID: $getUserId');
                                    viewModel.getUserDetailAPI();
                                    viewModel.isImageSelected =
                                        !viewModel.isImageSelected;
                                    viewModel.rebuildUi();
                                  },
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: viewModel.homeModel[index]
                                                .isImageSelected ==
                                            true
                                        ? viewModel
                                                .homeModel[index].musicImage1 ??
                                            ''
                                        : viewModel.homeModel[index].bgImage ??
                                            '',
                                    placeholder: (context, url) => const Column(
                                      children: [
                                        // Transform.scale(
                                        //     scale: 0.6,
                                        //     child:
                                        //         const CircularProgressIndicator(
                                        //       color: kcTransparent,
                                        //     )),
                                      ],
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    viewModel.homeModel[index].isImageSelected =
                                        !viewModel
                                            .homeModel[index].isImageSelected;
                                    viewModel.rebuildUi();
                                  },
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationZ(
                                      2 / 15,
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: viewModel.homeModel[index]
                                                  .isImageSelected ==
                                              true
                                          ? viewModel
                                                  .homeModel[index].bgImage ??
                                              ''
                                          : viewModel.homeModel[index]
                                                  .musicImage1 ??
                                              '',
                                      placeholder: (context, url) => Column(
                                        children: [
                                          Transform.scale(
                                              scale: 0.6,
                                              child:
                                                  const CircularProgressIndicator(
                                                color: kcWhite,
                                              )),
                                        ],
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
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
                                  style: GoogleFonts.bokor(
                                    color: kcWhite,
                                    fontSize: size_22,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                    style: GoogleFonts.lato(fontSize: size_20),
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
                                    style: GoogleFonts.lato(
                                      color: kcWhite,
                                      fontSize: size_14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: width_10,
                                  ),
                                  Text(
                                    '${viewModel.homeModel[index].reactions ?? ''} $ksREACTIONS',
                                    style: GoogleFonts.lato(
                                      color: kcWhite,
                                      fontSize: size_14,
                                      fontWeight: FontWeight.bold,
                                    ),
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
