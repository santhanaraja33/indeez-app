import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/home/model/comments/get_comments_model.dart';
import 'package:stacked/stacked.dart';
import '../view_model/bottom_popup_viewmodel.dart';

class BottomPopupView extends StackedView<BottomPopupViewModel> {
  final String postId;
  final Function(String postId, int newCommentCount)? onCommentUpdated;
  final Function(String postId, int newReactionCount)? onReactionUpdated;

  const BottomPopupView(
    this.postId, {
    this.onCommentUpdated,
    this.onReactionUpdated,
    Key? key,
  }) : super(key: key);

  @override
  void onViewModelReady(BottomPopupViewModel viewModel) {
    viewModel.postId = postId;
    viewModel.initializeCallbacks(
      onCommentUpdated: onCommentUpdated,
      onReactionUpdated: onReactionUpdated,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator(color: kcWhite))
        : SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: kcTransparent,
            body: Container(
              alignment: Alignment.bottomCenter,
              color: kcTransparent,
              width: double.infinity,
              child: Container(
                color: kcBgColor,
                width: double.infinity,
                height: 520,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${viewModel.comments?.data?.length ?? 0} $ksCOMMENTS',
                            style: GoogleFonts.lato(
                              color: kcTextGrey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: width_10),
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
                            child: const Icon(Icons.close, color: kcWhite),
                          ),
                        ],
                      ),
                    ),

                    /// Emoji row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
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
                          const SizedBox(width: 5),
                          Expanded(
                            child:
                                viewModel.emojis.isEmpty
                                    ? Center(
                                      child: Text(
                                        'No reactions yet.',
                                        style: GoogleFonts.lato(fontSize: 14),
                                      ),
                                    )
                                    : Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children:
                                          viewModel.emojis.map((emoji) {
                                            return Text(
                                              emoji.char,
                                              style: GoogleFonts.lato(
                                                fontSize: 20,
                                              ),
                                            );
                                          }).toList(),
                                    ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Textfield with padding
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AppCommonTextfield(
                        controller: viewModel.commentController,
                        keyboardType: TextInputType.text,
                        onSubmitted: (_) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        label: Text(
                          'Add a comment',
                          style: GoogleFonts.lato(color: kcTextGrey),
                        ),
                        suffixIcon: const Icon(Icons.send, color: kcBlue),
                        onSuffixIconTap: () {
                          final comment =
                              viewModel.commentController.text.trim();
                          if (comment.isNotEmpty) {
                            viewModel.submitComment(comment, 'comments');
                            viewModel.commentController.clear();
                            FocusManager.instance.primaryFocus?.unfocus();

                            viewModel.getCommentsListAPI(
                              postId,
                              showLoader: false,
                            );
                            // const CircularProgressIndicator();
                            viewModel.rebuildUi();
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Emoji picker (if shown)
                    if (viewModel.isemoji)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: EmojiSelector(
                          withTitle: false,
                          padding: const EdgeInsets.all(5),
                          onSelected: (emoji) {
                            viewModel.emojiData = emoji;
                            viewModel.commentController.text = emoji.char;
                            viewModel.emojiStr = emoji.name;
                            viewModel.submitComment(
                              viewModel.emojiStr ?? '',
                              "emojis",
                            );

                            if (viewModel.emojiData != null) {
                              viewModel.emojis.add(
                                viewModel.emojiData as EmojiData,
                              );
                            }
                            viewModel.commentController.clear();

                            // Hide the emoji selector
                            viewModel.isemoji = false;
                            viewModel.rebuildUi();

                            // Optionally, dismiss keyboard if it's open
                          },
                        ),
                      ),

                    /// Scrollable comment list
                    const SizedBox(height: 10),
                    if (!viewModel.isemoji)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:
                              (viewModel.comments?.data == null ||
                                      viewModel.comments!.data!.isEmpty)
                                  ? Center(
                                    child: Text(
                                      'No comments yet.',
                                      style: GoogleFonts.lato(
                                        color: kcTextGrey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                  : ListView.builder(
                                    itemCount:
                                        viewModel.comments?.data?.length ?? 0,
                                    padding: const EdgeInsets.only(bottom: 20),
                                    itemBuilder: (context, index) {
                                      final comment =
                                          viewModel.comments!.data![index];
                                      return buildCommentItem(
                                        userName:
                                            comment.user?.firstName ?? 'User',
                                        commentText: comment.commentText,
                                        replies: comment.replies,
                                        index: index,
                                        level: 0,
                                        onReplyTap: (i) {
                                          viewModel.replyingToCommentIndex = i;
                                          viewModel.replyController.clear();
                                          viewModel.rebuildUi();
                                        },
                                        showReplyField:
                                            viewModel.replyingToCommentIndex ==
                                            index,
                                        replyController:
                                            viewModel.replyController,
                                        commentId: comment.commentId,
                                        userId: comment.userId,
                                        viewModel: viewModel,
                                      );
                                    },
                                  ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
  }

  Widget buildCommentItem({
    required String userName,
    required String? commentText,
    required List<Replies>? replies,
    required int index,
    int level = 0,
    required Function(int) onReplyTap,
    required bool showReplyField,
    required TextEditingController replyController,
    required String? userId,
    required String? commentId,
    required BottomPopupViewModel viewModel,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: level * 25.0, top: 12, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: kcWhite,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            commentText ?? '',
            style: GoogleFonts.lato(fontSize: 13, color: kcWhite),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  viewModel.toggleLike(commentId, postId);
                },
                child: Row(
                  children: [
                    Icon(
                      viewModel.isCommentLiked(commentId!)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 16,
                      color:
                          viewModel.isCommentLiked(commentId)
                              ? kcRed
                              : kcTextGrey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      viewModel.isCommentLiked(commentId) ? 'Liked' : 'Like',
                      style: const TextStyle(fontSize: 12, color: kcTextGrey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              if (level == 0)
                GestureDetector(
                  onTap: () => onReplyTap(index),
                  child: const Text(
                    'Reply',
                    style: TextStyle(fontSize: 12, color: kcTextGrey),
                  ),
                ),
            ],
          ),

          /// Show reply field if this comment is selected
          if (showReplyField)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: AppCommonTextfield(
                      controller: replyController,
                      hintText: 'Write a reply...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      suffixIcon: const Icon(Icons.send, color: kcBlue),
                      onSuffixIconTap: () {
                        final replyText = viewModel.replyController.text.trim();
                        final comment = viewModel.comments?.data?[index];
                        final parentId = comment?.commentId;

                        if (replyText.isNotEmpty && parentId != null) {
                          viewModel.createReplyCommentsAPI(
                            viewModel.postId!,
                            replyText,
                            parentId,
                          );
                          viewModel.replyController.clear();
                          viewModel.replyingToCommentIndex = null;
                          FocusManager.instance.primaryFocus?.unfocus();

                          viewModel.getCommentsListAPI(
                            postId,
                            showLoader: false,
                          );
                          const CircularProgressIndicator();
                          viewModel.rebuildUi();
                          viewModel.notifyListeners();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

          /// Replies
          if (replies != null && replies.isNotEmpty)
            ...replies.map(
              (reply) => buildCommentItem(
                userName: reply.user?.firstName ?? 'User',
                commentText: reply.commentText,
                replies: [],
                index: -1,
                level: level + 1,
                onReplyTap: (_) {},
                showReplyField: false,
                replyController: TextEditingController(),
                userId: reply.userId,
                commentId: reply.commentId,
                viewModel: viewModel,
              ),
            ),
        ],
      ),
    );
  }

  @override
  BottomPopupViewModel viewModelBuilder(BuildContext context) =>
      BottomPopupViewModel();
}
