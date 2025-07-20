import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';

import 'swipe_viewmodel.dart';

class SwipeView extends StackedView<SwipeViewModel> {
  const SwipeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SwipeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBlack,
      body: Stack(
        children: [
          Image.asset(
            AppImage.greenLineGif,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 180,
                ),
                CarouselSlider(
                  options: CarouselOptions(),
                  items: viewModel.imgList
                      .map(
                        (item) => Center(
                          child: CachedNetworkImage(
                            height: height_150,
                            fit: BoxFit.cover,
                            imageUrl: item,
                            placeholder: (context, url) => Column(
                              children: [
                                Transform.scale(
                                    scale: 0.6,
                                    child: const CircularProgressIndicator(
                                      color: kcWhite,
                                    )),
                              ],
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Spacer(),
                    viewModel.isPlayMusic == false
                        ? Row(
                            children: [
                              Container(
                                height: 5,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: width_2,
                              ),
                              Container(
                                height: 5,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: width_2,
                              ),
                              Container(
                                height: 5,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: width_2,
                              ),
                              Container(
                                height: 5,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            ],
                          )
                        : Image.asset(
                            AppImage.musicGIF,
                            height: height_40,
                            width: width_50,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            color: kcLGreen,
                          ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        viewModel.isPlayMusic = !viewModel.isPlayMusic;
                        viewModel.rebuildUi();
                      },
                      child: Icon(
                        viewModel.isPlayMusic == false
                            ? Icons.play_arrow
                            : Icons.pause,
                        color: kcSkyBlue,
                        size: 40,
                      ),
                    ),
                    const Icon(
                      Icons.send,
                      color: kcSkyBlue,
                      size: 40,
                    ),
                    const Icon(
                      Icons.music_note,
                      color: kcSkyBlue,
                      size: 40,
                    ),
                    const Spacer(),
                    //genres
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 75, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Klypi',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: size_22.sp,
                                color: kcLGreen,
                                fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Wyoming\nLolipop Records',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: size_22.sp,
                                color: kcSkyBlue,
                                fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  SwipeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SwipeViewModel();
}
