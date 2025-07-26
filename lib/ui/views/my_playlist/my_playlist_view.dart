import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';

import 'my_playlist_viewmodel.dart';

class MyPlaylistView extends StackedView<MyPlaylistViewModel> {
  const MyPlaylistView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MyPlaylistViewModel viewModel,
    Widget? child,
  ) {
    var size = MediaQuery.of(context).size;
    double itemHeight = height_260;
    double itemWidth = size.width / width_2;
    return Scaffold(
      backgroundColor: kcBgColor,
      body: Stack(
        children: [
          Image.asset(
            AppImage.playListBG,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: padding_20, right: padding_20),
              child: Column(
                children: [
                  const SizedBox(
                    height: height_200,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        ksMYPLAYLISTS,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: size_16.sp,
                                color: kcWhite,
                                fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.add,
                        color: kcTextGrey,
                        size: size_30,
                      ),
                      const Spacer(),
                      Text(
                        ksSAVEDPLAYLIST,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: size_16.sp,
                                color: kcTextGrey,
                                fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: width_20,
                      ),
                    ],
                  ),
                  designModulesUI(itemWidth, itemHeight, viewModel, context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget designModulesUI(double itemWidth, double itemHeight,
      MyPlaylistViewModel viewModel, BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List<Widget>.generate(viewModel.gridviewModel.length, (index) {
        return GestureDetector(
          onTap: () {
            moveToSelectionVC(index);
          },
          child: GridTile(
            child: Padding(
              padding: const EdgeInsets.all(padding_10),
              child: buildMenus(index, viewModel, context),
            ),
          ),
        );
      }),
    );
  }

  moveToSelectionVC(int selectedIndex) {
    //
  }

  Widget buildMenus(
      int index, MyPlaylistViewModel viewModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          viewModel.gridviewModel[index].dimage ?? '',
          height: height_150,
          fit: BoxFit.cover,
        ),
        // CachedNetworkImage(
        //   height: height_150,
        //   fit: BoxFit.cover,
        //   imageUrl: viewModel.gridviewModel[index].dimage ?? '',
        //   placeholder: (context, url) => Column(
        //     children: [
        //       Transform.scale(
        //           scale: 0.6,
        //           child: const CircularProgressIndicator(
        //             color: kcWhite,
        //           )),
        //     ],
        //   ),
        //   errorWidget: (context, url, error) => const Icon(Icons.error),
        // ),
        Padding(
          padding: const EdgeInsets.only(
              left: padding_10, right: padding_10, top: padding_10),
          child: Text(
            viewModel.gridviewModel[index].dtitel ?? '',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: size_16.sp,
                color: kcWhite,
                fontWeight: FontWeight.bold),

            //
          ),
        ),
      ],
    );
  }

  @override
  MyPlaylistViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MyPlaylistViewModel();
}
