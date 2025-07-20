import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart';
import 'package:stacked/stacked.dart';

import 'search_viewmodel.dart';

class SearchView extends StackedView<SearchViewModel> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SearchViewModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        Scaffold(
          key: viewModel.scaffoldKey,
          endDrawer: const RightmenuView(),
          body: Stack(
            children: [
              Image.asset(
                AppImage.searchBGErrorGif,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: height_30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImage.yellowlogoGif,
                            height: height_80,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              viewModel.scaffoldKey.currentState!
                                  .openEndDrawer();
                            },
                            icon: const Icon(
                              Icons.menu_outlined,
                              color: kcTextGrey,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: height_30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCommonTextfield(
                            controller: viewModel.searchController,
                            hintText: ksSearch,
                            prefixIcon: const Icon(
                              Icons.search,
                              color: kcWhite,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                viewModel.searchController.clear();

                                viewModel.rebuildUi();
                              },
                              child: Icon(
                                Icons.close_outlined,
                                color: viewModel.searchController.text.isEmpty
                                    ? kcBlack
                                    : kcWhite,
                              ),
                            ),
                            onChanged: (value) {
                              viewModel.searchController.text = value;
                              viewModel.rebuildUi();
                            },
                          ),
                          const SizedBox(
                            height: height_10,
                          ),
                          viewModel.searchController.text.isEmpty
                              ? Container()
                              : Container(
                                  color: kcBgColor,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: viewModel.searchModel.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          viewModel.navigateToSearchdetails();
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: padding_10,
                                                  right: padding_10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: kcBgColor,
                                                    border: Border.all(
                                                        color: kcWhite),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            borderRadius_10)),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: height_10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: padding_10,
                                                              right:
                                                                  padding_10),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              height: height_80,
                                                              width: width_80,
                                                              imageUrl: viewModel
                                                                      .searchModel[
                                                                          index]
                                                                      .image ??
                                                                  '',
                                                              placeholder:
                                                                  (context,
                                                                          url) =>
                                                                      Column(
                                                                children: [
                                                                  Transform.scale(
                                                                      scale: 0.6,
                                                                      child: const CircularProgressIndicator(
                                                                        color:
                                                                            kcWhite,
                                                                      )),
                                                                ],
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: width_16,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  viewModel
                                                                          .searchModel[
                                                                              index]
                                                                          .title ??
                                                                      '',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleMedium
                                                                      ?.copyWith(
                                                                          fontSize: size_16
                                                                              .sp,
                                                                          color:
                                                                              kcWhite,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                ),
                                                                Text(
                                                                  viewModel
                                                                          .searchModel[
                                                                              index]
                                                                          .subTitle ??
                                                                      '',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleMedium
                                                                      ?.copyWith(
                                                                          fontSize: size_14
                                                                              .sp,
                                                                          color:
                                                                              kcTextGrey,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: height_10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: height_10,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: height_30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  SearchViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SearchViewModel();
}
