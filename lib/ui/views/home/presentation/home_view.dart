import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_bg_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/home/model/post/post_download_media_model.dart';
import 'package:stacked/stacked.dart';
import '../view_model/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.downloadMediaList.clear();
      viewModel.postList.clear();
      viewModel.getUserPostsAPI();
    });
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
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
      body: Stack(
        children: [
          const AppCommonBGImage(),
          SafeArea(
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
                    itemCount: viewModel.post?.data?.length ?? 0,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      if ((viewModel.post?.data == null ||
                              viewModel.post!.data!.isEmpty) ||
                          index >= (viewModel.post?.data?.length ?? 0)) {
                        return const SizedBox(); // Or handle empty case
                      }
                      final post = viewModel.downloadMediaList[index];
                      final reactionTextList =
                          viewModel.post?.data?[index].reactionsCount;
                      print("reactionTextList ${reactionTextList?.toJson()}");

                      final reactionTextList1 = viewModel.reactionTextList1;

                      print("reactionTextList1 $reactionTextList1");
                      // Safely get media items
                      final foregroundImage = post.mediaFiles?.firstWhere(
                        (file) => file.index == 0,
                        orElse: () =>
                            MediaFiles(), // Provide a default MediaFiles instance
                      );

                      final backgroundImage = post.mediaFiles?.firstWhere(
                        (file) => file.index == 1,
                        orElse: () =>
                            MediaFiles(), // Provide a default MediaFiles instance
                      );
                      final imageToShow = (index % 2 == 0)
                          ? foregroundImage?.mediaUrl
                          : backgroundImage?.mediaUrl;

                      // Use your selection logic here
                      final selectedImageUrl =
                          viewModel.homeModel[index].isImageSelected == true
                              ? foregroundImage?.mediaUrl ?? ''
                              : backgroundImage?.mediaUrl ?? '';
                      return Padding(
                        padding: const EdgeInsets.only(top: padding_20),
                        child: Column(
                          children: [
                            Stack(
                              alignment: const Alignment(2, 0),
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final getUserId =
                                        await SharedPreferencesHelper
                                            .getLoginUserId(ksLoggedinUserId);
                                    debugPrint('User ID: $getUserId');
                                    viewModel.isImageSelected =
                                        !viewModel.isImageSelected;
                                    viewModel.rebuildUi();
                                  },
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: selectedImageUrl,
                                    placeholder: (context, url) => const Column(
                                      children: [
                                        // Transform.scale(
                                        //     scale: 0.6,
                                        //     child:
                                        //         const CircularProgressIndicator(
                                        //       color: kcTransparent,
                                        //     )),
                                      ],
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    viewModel.homeModel[index].isImageSelected =
                                        !viewModel
                                            .homeModel[index].isImageSelected;
                                    viewModel.rebuildUi();
                                  },
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationZ(
                                      2 / 15,
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: selectedImageUrl,
                                      placeholder: (context, url) => Column(
                                        children: [
                                          Transform.scale(
                                              scale: 0.6,
                                              child:
                                                  const CircularProgressIndicator(
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
                            Row(
                              children: [
                                const Spacer(),
                                Text(
                                  viewModel.postList[index].posttitle ??
                                      'No title',
                                  style: GoogleFonts.bokor(
                                    color: kcWhite,
                                    fontSize: size_22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.popupPhotoUploadNavigation(
                                    context,
                                    index,
                                    viewModel.postList[index].postId ?? '0');
                              },
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Text(reactionTextList1.join('')),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: height_5,
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.popupPhotoUploadNavigation(
                                    context,
                                    index,
                                    viewModel.postList[index].postId ?? '0');
                              },
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Text(
                                    '${viewModel.postList[index].commentsCount ?? 0} $ksCOMMENTS',
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
                                    '${viewModel.postList[index].totalReactions ?? 0} $ksREACTIONS',
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
