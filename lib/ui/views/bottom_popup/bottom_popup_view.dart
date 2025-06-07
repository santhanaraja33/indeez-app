import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';

import 'bottom_popup_viewmodel.dart';

class BottomPopupView extends StackedView<BottomPopupViewModel> {
  const BottomPopupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BottomPopupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcTransparent,
      body: Container(
        alignment: Alignment.bottomCenter,
        color: kcTransparent,
        width: double.infinity,
        child: Container(
          color: kcBgColor,
          height: 400,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '${viewModel.homeModel[2].commends ?? ''} $ksCOMMENTS',
                        style: GoogleFonts.lato(
                          color: kcTextGrey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: width_10,
                      ),
                      Text(
                        '${viewModel.homeModel[2].reactions ?? ''} $ksREACTIONS',
                        style: GoogleFonts.lato(
                          color: kcTextGrey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          viewModel.navigationService.back();
                        },
                        child: const Icon(
                          Icons.close,
                          color: kcWhite,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          viewModel.isemoji = !viewModel.isemoji;
                          viewModel.rebuildUi();
                        },
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: kcTextGrey,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          viewModel.homeModel[2].emoji ?? '',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            color: kcTextGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppCommonTextfield(
                    label: Text('Add a comment',
                        style: GoogleFonts.lato(color: kcTextGrey)),
                  ),
                  viewModel.isemoji == false
                      ? Container()
                      : EmojiSelector(
                          withTitle: false,
                          padding: const EdgeInsets.all(20),
                          onSelected: (emoji) {
                            viewModel.emojiData = emoji;
                            viewModel.rebuildUi();
                          },
                        ),
                  ListView.builder(
                    itemCount: viewModel.commentModel.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.commentModel[index].title ?? '',
                              style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kcWhite),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    viewModel.commentModel[index].subTitle ??
                                        '',
                                    style: GoogleFonts.lato(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kcWhite),
                                  ),
                                ),
                                const Icon(
                                  Icons.favorite,
                                  color: kcTextGrey,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  BottomPopupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BottomPopupViewModel();
}
