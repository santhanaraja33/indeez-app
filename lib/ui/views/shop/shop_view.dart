import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';

import 'shop_viewmodel.dart';

class ShopView extends StackedView<ShopViewModel> {
  const ShopView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShopViewModel viewModel,
    Widget? child,
  ) {
    var size = MediaQuery.of(context).size;
    double itemHeight = height_270;
    double itemWidth = size.width / width_2;
    return Scaffold(
      backgroundColor: kcBgColor,
      body: SingleChildScrollView(
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
      ),
    );
  }

  Widget shopdesignModulesUI(
    double itemWidth,
    double itemHeight,
    ShopViewModel viewModel,
  ) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List<Widget>.generate(viewModel.gridviewModel.length, (index) {
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

  Widget buildShopMenus(int index, ShopViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 0, right: padding_10, top: padding_10),
          child: Text(
            viewModel.gridviewModel[index].dtitel ?? '',
            style: GoogleFonts.lato(
                color: kcWhite, fontSize: size_18, fontWeight: FontWeight.bold),
            //
          ),
        ),
        const SizedBox(
          height: height_10,
        ),
        CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: viewModel.gridviewModel[index].dimage ?? '',
          placeholder: (context, url) => Transform.scale(
              scale: 0.6,
              child: const CircularProgressIndicator(
                color: kcWhite,
              )),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ],
    );
  }

  @override
  ShopViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ShopViewModel();
}
