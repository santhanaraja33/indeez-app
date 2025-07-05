import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_bg_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/home/model/post/post_download_media_model.dart';
import 'package:music_app/ui/views/home/widgets/post_image.dart';
import 'package:music_app/ui/views/home/widgets/reactions_row.dart';
import 'package:stacked/stacked.dart';
import '../view_model/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.downloadMediaList.clear();
      viewModel.postList.clear();
      viewModel.reactionResult.clear();
      viewModel.getPublicPostsAPI();
    });
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: kcWhite),
      );
    }

    Future<void> RefreshFunction() async {
      viewModel.getPublicPostsAPI();
    }

    Future<void> prefetchImages(String bgUrl, String fgUrl) async {
      await Future.wait([
        precacheImage(CachedNetworkImageProvider(bgUrl), context),
        precacheImage(CachedNetworkImageProvider(fgUrl), context),
      ]);
    }

    return Scaffold(
      //Floating Action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.selectedFiles.clear();
          viewModel.selectedImageItems.clear();
          viewModel.selectedImages.clear();
          viewModel.titleController.clear();
          viewModel.descController.clear();
          viewModel.selectedMode = '';
          viewModel.selectedResourceType = '';
          viewModel.showCreatePostDialog(context);
        },
        backgroundColor: kcBlue,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      // body part
      body: Stack(
        children: [
          //Background Image
          const AppCommonBGImage(),

          //Main Content
          RefreshIndicator(
            onRefresh: RefreshFunction,
            child: SafeArea(
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
                      itemCount: viewModel.homePostModel.length,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        // Empty Post Part
                        if ((viewModel.homePostModel.isEmpty) ||
                            index >= (viewModel.homePostModel.length)) {
                          return Center(
                            child: Text(
                              "No Posts Found",
                              style: GoogleFonts.lato(
                                color: kcTextGrey,
                                fontSize: size_18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        //Separate the Backgroung and foreground Images
                        var selectedImageUrl = '';

                        var bgUrl = '';
                        var fgUrl = '';
                        if (viewModel.homePostModel[index].resourceType ==
                            "image") {
                          if (index < viewModel.downloadMediaList.length) {
                            final post = viewModel.downloadMediaList[index];

                            final backgroundImage = post.mediaFiles?.firstWhere(
                              (file) => file.index == 0,
                              orElse: () =>
                                  MediaFiles(), // Provide a default MediaFiles instance
                            );

                            final foregroundImage = post.mediaFiles?.firstWhere(
                              (file) => file.index == 1,
                              orElse: () =>
                                  MediaFiles(), // Provide a default MediaFiles instance
                            );

                            bgUrl = backgroundImage?.mediaUrl ?? '';
                            fgUrl = foregroundImage?.mediaUrl ?? '';

                            prefetchImages(bgUrl, fgUrl);

                            // Use your selection logic here
                            selectedImageUrl = viewModel
                                        .homePostModel[index].isImageSelected ==
                                    true
                                ? fgUrl
                                : bgUrl;
                          }
                        } else {
                          debugPrint(
                              'Index $index out of bounds for downloadMediaList');
                        }

                        //Split the reactions
                        final reactionsMap = viewModel
                                .homePostModel[index].reactionsCount?.counts ??
                            {};

                        final reactionList = reactionsMap.entries
                            .where((entry) =>
                                viewModel.reactionEmojiMap
                                    .containsKey(entry.key) &&
                                entry.value > 0)
                            .map((entry) => Reaction(
                                  key: entry.key,
                                  emoji: viewModel.reactionEmojiMap[entry.key]!,
                                  count: entry.value,
                                ))
                            .toList();

                        return Padding(
                          padding: const EdgeInsets.only(top: padding_20),
                          child: Column(
                            children: [
                              //NO Image Part
                              selectedImageUrl.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.photo_library_outlined,
                                            size: 48,
                                            color: Colors.grey[400],
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            "No Media Found",
                                            style: GoogleFonts.lato(
                                              color: kcTextGrey,
                                              fontSize: size_14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  :

                                  // Post Image Part

                                  Stack(
                                      alignment: const Alignment(2, 0),
                                      children: [
                                        // Foreground image

                                        buildBackgroundImage(selectedImageUrl,
                                            () async {
                                          viewModel.isImageSelected =
                                              !viewModel.isImageSelected;
                                          viewModel.rebuildUi();
                                        }),

                                        // Background image

                                        buildForegroundImage(selectedImageUrl,
                                            () async {
                                          viewModel.homePostModel[index]
                                                  .isImageSelected =
                                              !viewModel.homePostModel[index]
                                                  .isImageSelected;
                                          viewModel.rebuildUi();
                                        }),
                                      ],
                                    ),

                              const SizedBox(
                                height: height_30,
                              ),

                              //Post Title

                              Row(
                                children: [
                                  const Spacer(),
                                  Text(
                                    viewModel.homePostModel[index].posttitle ??
                                        'No title',
                                    style: GoogleFonts.bokor(
                                      color: kcWhite,
                                      fontSize: size_22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              //Reaction Part

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Spacer(),
                                  buildReactionRow(reactionList),
                                ],
                              ),

                              const SizedBox(
                                height: height_5,
                              ),

                              //Comments Count Part

                              GestureDetector(
                                onTap: () {
                                  viewModel.popupPhotoUploadNavigation(
                                      context,
                                      index,
                                      viewModel.homePostModel[index].postId ??
                                          '0');
                                },
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Text(
                                      '${viewModel.homePostModel[index].commentsCount ?? 0} $ksCOMMENTS',
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
                                      '${viewModel.homePostModel[index].totalReactions ?? 0} $ksREACTIONS',
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
          ),
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
