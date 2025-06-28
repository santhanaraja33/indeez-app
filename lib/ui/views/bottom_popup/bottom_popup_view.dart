import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'bottom_popup_viewmodel.dart';

class BottomPopupView extends StackedView<BottomPopupViewModel> {
  final String postId;

  const BottomPopupView(this.postId, {Key? key}) : super(key: key);

  @override
  void onViewModelReady(BottomPopupViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      viewModel.postId = postId;
      await viewModel.getCommentsListAPI(postId);
      await viewModel.getReactionsListAPI(postId);
    });
  }

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
                        '${viewModel.comments?.data?.length ?? 0} $ksCOMMENTS',
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
                        '${viewModel.reactions?.data?.length ?? 0} $ksREACTIONS',
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
                        child: Wrap(
                          // 👈 Use Wrap to handle overflow gracefully
                          spacing: 8,
                          runSpacing: 4,
                          children: viewModel.emojis
                              .map((emoji) => Text(
                                    emoji.toString(),
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: kcTextGrey,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppCommonTextfield(
                    controller: viewModel.commentController,
                    keyboardType: TextInputType.text,
                    // 👈 Done button on keyboard
                    onSubmitted: (value) {
                      FocusManager.instance.primaryFocus
                          ?.unfocus(); // hides keyboard
                    },
                    label: Text('Add a comment',
                        style: GoogleFonts.lato(color: kcTextGrey)),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      onPressed: () {
                        final comment = viewModel.commentController.text.trim();
                        if (comment.isNotEmpty) {
                          viewModel.submitComment(comment);
                          viewModel.commentController.clear();
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                      child: Text("Done",
                          style: GoogleFonts.lato(color: Colors.white)),
                    ),
                  ),
                  viewModel.isemoji == false
                      ? Container()
                      : EmojiSelector(
                          withTitle: false,
                          padding: const EdgeInsets.all(20),
                          // 👈 This hides the search bar (if available)
                          onSelected: (emoji) {
                            viewModel.emojiData = emoji;
                            viewModel.commentController.text = emoji.char;
                            viewModel.emojiStr = emoji.name;
                            if (viewModel.emojiData != null) {
                              viewModel.emojis.add(viewModel.emojiData as Type);
                            }
                            viewModel.rebuildUi();
                          },
                        ),
                  viewModel.comments?.data == null ||
                          viewModel.comments!.data!.isEmpty
                      ? Center(
                          child: Text(
                            'No comments yet.',
                            style: GoogleFonts.lato(
                                color: kcTextGrey, fontSize: 14),
                          ),
                        )
                      : ListView.builder(
                          itemCount: viewModel.comments?.data!.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    viewModel.comments?.data![index]
                                            .commentText ??
                                        '',
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kcWhite),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          viewModel.commentModel[index]
                                                  .subTitle ??
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
