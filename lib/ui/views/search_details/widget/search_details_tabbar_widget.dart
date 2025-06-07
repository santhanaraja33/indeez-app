import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/search_details/search_details_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchDetailsTabbarWidget
    extends ViewModelWidget<SearchDetailsViewModel> {
  const SearchDetailsTabbarWidget({super.key});

  @override
  Widget build(BuildContext context, SearchDetailsViewModel viewModel) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - height_440,
      child: DefaultTabController(
        length: viewModel.tabbarModel.length,
        child: Scaffold(
          backgroundColor: kcBgColor,
          appBar: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            dividerColor: kcBgColor,
            unselectedLabelColor: kcTextGrey,
            labelColor: kcWhite,
            labelPadding:
                const EdgeInsets.only(left: padding_10, right: padding_10),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 0.1,
            indicatorColor: kcTransparent,
            tabs: List<Widget>.generate(viewModel.tabbarModel.length, (index) {
              return Tab(
                child: Text(
                  (viewModel.tabbarModel[index].title ?? '').toUpperCase(),
                  style: GoogleFonts.lato(
                      fontSize: size_12, fontWeight: FontWeight.w600),
                ),
              );
            }),
          ),
          body: TabBarView(
            children: <Widget>[
              buildPostUI(viewModel),
              buildMusicUI(viewModel, context),
              buildShopUI(viewModel, context),
              buildCalenderUI(viewModel),
              buildPayListModel(viewModel, context),
              buildStashUI(viewModel, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStashUI(SearchDetailsViewModel viewModel, BuildContext context) {
    var size = MediaQuery.of(context).size;
    double itemHeight = height_260;
    double itemWidth = size.width / width_2;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: height_20,
          ),
          stashDesignModulesUI(itemWidth, itemHeight, viewModel),
          const SizedBox(
            height: height_20,
          ),
        ],
      ),
    );
  }

  Widget stashDesignModulesUI(
    double itemWidth,
    double itemHeight,
    SearchDetailsViewModel viewModel,
  ) {
    return GridView.count(
      crossAxisCount: crossAxisCount_2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List<Widget>.generate(viewModel.gridviewModel.length, (index) {
        return GestureDetector(
          onTap: () {
            stashMoveToSelectionVC(index);
          },
          child: GridTile(
            child: Padding(
              padding: const EdgeInsets.all(padding_10),
              child: buildStashMenus(index, viewModel),
            ),
          ),
        );
      }),
    );
  }

  stashMoveToSelectionVC(int selectedIndex) {
    //
  }

  Widget buildStashMenus(int index, SearchDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          height: height_150,
          fit: BoxFit.cover,
          imageUrl: viewModel.gridviewModel[index].dimage ?? '',
          placeholder: (context, url) => Column(
            children: [
              Transform.scale(
                  scale: scale0_6,
                  child: const CircularProgressIndicator(
                    color: kcWhite,
                  )),
            ],
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: padding_10, right: padding_10, top: padding_10),
          child: Text(
            viewModel.gridviewModel[index].dtitel ?? '',
            style: GoogleFonts.lato(
              color: kcWhite,
              fontSize: size_14,
              fontWeight: FontWeight.bold,
            ),
            //
          ),
        ),
      ],
    );
  }

  Widget buildPayListModel(
      SearchDetailsViewModel viewModel, BuildContext context) {
    var size = MediaQuery.of(context).size;
    double itemHeight = height_270;
    double itemWidth = size.width / width_2;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: padding_20, right: padding_20),
        child: Column(
          children: [
            const SizedBox(
              height: height_20,
            ),
            payListDesignModulesUI(itemWidth, itemHeight, viewModel),
            const SizedBox(
              height: height_20,
            ),
          ],
        ),
      ),
    );
  }

  Widget payListDesignModulesUI(
    double itemWidth,
    double itemHeight,
    SearchDetailsViewModel viewModel,
  ) {
    return GridView.count(
      crossAxisCount: crossAxisCount_2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List<Widget>.generate(viewModel.payListModel.length, (index) {
        return GestureDetector(
          onTap: () {
            payListmoveToSelectionVC(index);
          },
          child: GridTile(
            child: Padding(
              padding: const EdgeInsets.all(padding_10),
              child: payListbuildMenus(index, viewModel),
            ),
          ),
        );
      }),
    );
  }

  payListmoveToSelectionVC(int selectedIndex) {
    //
  }

  Widget payListbuildMenus(int index, SearchDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          height: height_130,
          fit: BoxFit.cover,
          imageUrl: viewModel.payListModel[index].dimage ?? '',
          placeholder: (context, url) => Column(
            children: [
              Transform.scale(
                  scale: scale0_6,
                  child: const CircularProgressIndicator(
                    color: kcWhite,
                  )),
            ],
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: padding_10, right: padding_10, top: padding_10),
          child: Text(
            viewModel.payListModel[index].dtitel ?? '',
            style: GoogleFonts.lato(
              color: kcWhite,
              fontSize: size_14,
              fontWeight: FontWeight.bold,
            ),
            //
          ),
        ),
      ],
    );
  }

  Widget buildCalenderUI(SearchDetailsViewModel viewModel) {
    return SingleChildScrollView(
        child: Column(
      children: [
        const SizedBox(
          height: height_20,
        ),
        ListView.builder(
          itemCount: viewModel.calenderModel.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius_0),
                      border: Border.all(color: kcWhite)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: kcDarkBlue,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(padding_10),
                          child: Text(
                            viewModel.calenderModel[index].date ?? '',
                            style: GoogleFonts.lato(
                              fontSize: size_14,
                              color: kcWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: width_10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: padding_10,
                            bottom: padding_10,
                          ),
                          child: Text(
                            viewModel.calenderModel[index].eventName ?? '',
                            style: GoogleFonts.lato(
                              fontSize: size_14,
                              color: kcWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: height_20,
        ),
      ],
    ));
  }

  Widget buildShopUI(SearchDetailsViewModel viewModel, BuildContext context) {
    var size = MediaQuery.of(context).size;
    double itemHeight = height_270;
    double itemWidth = size.width / width_2;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: padding_20, right: padding_20),
        child: Column(
          children: [
            const SizedBox(
              height: height_20,
            ),
            shopdesignModulesUI(itemWidth, itemHeight, viewModel),
          ],
        ),
      ),
    );
  }

  Widget shopdesignModulesUI(
    double itemWidth,
    double itemHeight,
    SearchDetailsViewModel viewModel,
  ) {
    return GridView.count(
      crossAxisCount: crossAxisCount_2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List<Widget>.generate(viewModel.gridShopModel.length, (index) {
        return GestureDetector(
          onTap: () {
            shopmoveToSelectionVC(index);
          },
          child: GridTile(
            child: Padding(
              padding: const EdgeInsets.all(padding_10),
              child: buildShopMenus(index, viewModel),
            ),
          ),
        );
      }),
    );
  }

  shopmoveToSelectionVC(int selectedIndex) {
    //
  }

  Widget buildShopMenus(int index, SearchDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: viewModel.gridShopModel[index].dimage ?? '',
          placeholder: (context, url) => Transform.scale(
              scale: scale0_6,
              child: const CircularProgressIndicator(
                color: kcWhite,
              )),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: padding_10,
            top: padding_10,
          ),
          child: Text(
            viewModel.gridShopModel[index].dtitel ?? '',
            style: GoogleFonts.lato(
                color: kcWhite, fontSize: size_14, fontWeight: FontWeight.bold),
            //
          ),
        ),
      ],
    );
  }

  Widget buildMusicUI(SearchDetailsViewModel viewModel, BuildContext context) {
    var size = MediaQuery.of(context).size;
    double itemHeight = height_255;
    double itemWidth = size.width / width_2;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: padding_20,
          right: padding_20,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: height_20,
            ),
            designMusicModulesUI(itemWidth, itemHeight, viewModel),
            const SizedBox(
              height: height_20,
            ),
          ],
        ),
      ),
    );
  }

  Widget designMusicModulesUI(
    double itemWidth,
    double itemHeight,
    SearchDetailsViewModel viewModel,
  ) {
    return GridView.count(
      crossAxisCount: crossAxisCount_2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List<Widget>.generate(viewModel.gridMusicModel.length, (index) {
        return GestureDetector(
          onTap: () {
            musicMoveToSelectionVC(index);
          },
          child: GridTile(
            child: Padding(
              padding: const EdgeInsets.all(padding_10),
              child: buildMusicMenus(index, viewModel),
            ),
          ),
        );
      }),
    );
  }

  musicMoveToSelectionVC(int selectedIndex) {
    //
  }

  Widget buildMusicMenus(int index, SearchDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          height: height_120,
          fit: BoxFit.cover,
          imageUrl: viewModel.gridMusicModel[index].dimage ?? '',
          placeholder: (context, url) => Column(
            children: [
              Transform.scale(
                  scale: scale0_6,
                  child: const CircularProgressIndicator(
                    color: kcWhite,
                  )),
            ],
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: padding_10, right: padding_10, top: padding_10),
          child: Text(
            viewModel.gridMusicModel[index].dtitel ?? '',
            style: GoogleFonts.lato(
                color: kcWhite, fontSize: size_18, fontWeight: FontWeight.bold),
            //
          ),
        ),
      ],
    );
  }

  Widget buildPostUI(SearchDetailsViewModel viewModel) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: height_10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.postModel.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: padding_20),
                  child: Column(
                    children: [
                      Stack(
                        alignment: const Alignment(alignment_2, alignment_0),
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: viewModel
                                        .postModel[index].isImageSelected ==
                                    true
                                ? viewModel.postModel[index].musicImage1 ?? ''
                                : viewModel.postModel[index].bgImage ?? '',
                            placeholder: (context, url) => const Column(
                              children: [],
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          GestureDetector(
                            onTap: () {
                              viewModel.postModel[index].isImageSelected =
                                  !viewModel.postModel[index].isImageSelected;
                              viewModel.rebuildUi();
                            },
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationZ(
                                rotationZ_2 / rotationZ_15,
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: viewModel
                                            .postModel[index].isImageSelected ==
                                        true
                                    ? viewModel.postModel[index].bgImage ?? ''
                                    : viewModel.postModel[index].musicImage1 ??
                                        '',
                                placeholder: (context, url) => Column(
                                  children: [
                                    Transform.scale(
                                        scale: scale0_6,
                                        child: const CircularProgressIndicator(
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
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: height_20,
            ),
            AppCommonButton(
              width: double.infinity,
              buttonName: ksCreateNewPost,
              onPressed: () {},
            ),
            const SizedBox(
              height: height_20,
            ),
          ],
        ),
      );
}
