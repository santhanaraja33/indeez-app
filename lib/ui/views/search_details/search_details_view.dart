import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/common/app_cached_image.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart';
import 'package:music_app/ui/views/search_details/widget/search_details_tabbar_widget.dart';
import 'package:stacked/stacked.dart';

import 'search_details_viewmodel.dart';

class SearchDetailsView extends StackedView<SearchDetailsViewModel> {
  const SearchDetailsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SearchDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      endDrawer: const RightmenuView(),
      key: viewModel.scaffoldKey,
      backgroundColor: kcBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: padding_20,
              right: padding_20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        viewModel.scaffoldKey.currentState!.openEndDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: AppCachedImage(
                    borderRadius: BorderRadius.circular(100),
                    placeholder: (context, url) => Column(
                      children: [
                        Transform.scale(
                          scale: scale0_6,
                          child: const CircularProgressIndicator(
                            color: kcWhite,
                          ),
                        ),
                      ],
                    ),
                    imageURL:
                        'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/BeachBums/BeachBums1.webp',
                    // imageHeight: height_150,
                    // imageWidth: width_150,
                  ),
                ),
                const SizedBox(
                  height: height_10,
                ),
                Center(
                  child: Text(
                    'Beach Bums',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: size_20.sp,
                        color: kcWhite,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(
                  height: height_30,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      '321 $ksFOLLOWERS',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: size_14.sp,
                          color: kcTextGrey,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: width_10,
                    ),
                    Text(
                      '245 $ksFOLLOWING',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: size_14.sp,
                          color: kcTextGrey,
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: height_10,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: size_16.sp,
                      color: kcWhite,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: height_20,
                ),
                Row(
                  children: [
                    Center(
                      child: AppCachedImage(
                        placeholder: (context, url) => Column(
                          children: [
                            Transform.scale(
                              scale: 0.6,
                              child: const CircularProgressIndicator(
                                color: kcWhite,
                              ),
                            ),
                          ],
                        ),
                        imageURL:
                            'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/profiles/lolipop/crocodiles.png',
                        imageHeight: 70,
                        imageWidth: 111,
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    Center(
                      child: AppCachedImage(
                        placeholder: (context, url) => Column(
                          children: [
                            Transform.scale(
                              scale: 0.6,
                              child: const CircularProgressIndicator(
                                color: kcWhite,
                              ),
                            ),
                          ],
                        ),
                        imageURL:
                            'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/profiles/lolipop/jacklenro.png',
                        imageHeight: 70,
                        imageWidth: 121,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                    ),
                    Center(
                      child: AppCachedImage(
                        imageURL:
                            'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/profiles/lolipop/JJ-AndIYou-Cover-3000x3000-MedRes_grande.png',
                        imageHeight: 70,
                        imageWidth: 120,
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    AppCachedImage(
                      placeholder: (context, url) => Column(
                        children: [
                          Transform.scale(
                            scale: scale0_6,
                            child: const CircularProgressIndicator(
                              color: kcWhite,
                            ),
                          ),
                        ],
                      ),
                      imageURL:
                          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/profiles/lolipop/FRONTCOVER_byMariKagawa_grande.png',
                      borderRadius: BorderRadius.circular(borderRadius_0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: padding_20,
                          right: padding_20,
                          bottom: padding_5),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImage.musicGIF,
                            height: 40,
                            width: 50,
                          ),
                          const Spacer(),
                          const Icon(Icons.music_note),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: height_10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 220,
                      child: Text(
                        'Some Song Title - Daisy Dell',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: size_16.sp,
                                color: kcWhite,
                                fontWeight: FontWeight.w800),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_right,
                      color: kcWhite,
                    ),
                  ],
                ),
                const SizedBox(
                  height: height_10,
                ),
                const SearchDetailsTabbarWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  SearchDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SearchDetailsViewModel();
}
