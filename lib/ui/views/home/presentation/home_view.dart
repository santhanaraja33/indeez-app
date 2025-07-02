import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_bg_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/data/bean/model/home_page_model.dart';
import 'package:music_app/ui/views/home/model/post/post_download_media_model.dart';
import 'package:stacked/stacked.dart';
import '../view_model/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
            child: viewModel.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kcBlue,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await viewModel.getUserPostsAPI();
                    },
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(
                          child: SizedBox(height: height_30),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: padding_20),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                // Only keep the essential safety checks
                                if (viewModel.post?.data == null ||
                                    viewModel.post!.data!.isEmpty ||
                                    index >=
                                        (viewModel.post?.data?.length ?? 0)) {
                                  return const SizedBox.shrink();
                                }

                                return PostItemWidget(
                                  viewModel: viewModel,
                                  index: index,
                                );
                              },
                              childCount: viewModel.post?.data?.length ?? 0,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: height_30),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

// Separate widget for individual post items
class PostItemWidget extends StatelessWidget {
  final HomeViewModel viewModel;
  final int index;

  const PostItemWidget({
    Key? key,
    required this.viewModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = viewModel.post!.data![index];
    final homeModelItem = viewModel.homeModel.length > index
        ? viewModel.homeModel[index]
        : HomePageModel(); // fallback if still loading

    // Default null
    MediaFiles? foregroundImage;
    MediaFiles? backgroundImage;
    String selectedImageUrl = '';

    //get image data if available
    if (post.resourceType == "image" &&
        viewModel.downloadMediaList.length > index) {
      final downloadMedia = viewModel.downloadMediaList[index];

      foregroundImage = downloadMedia.mediaFiles?.firstWhere(
        (file) => file.index == 0,
        orElse: () => MediaFiles(),
      );

      backgroundImage = downloadMedia.mediaFiles?.firstWhere(
        (file) => file.index == 1,
        orElse: () => MediaFiles(),
      );

      selectedImageUrl = homeModelItem.isImageSelected == true
          ? foregroundImage?.mediaUrl ?? ''
          : backgroundImage?.mediaUrl ?? '';
    }

    return Padding(
      padding: const EdgeInsets.only(top: padding_20),
      child: Column(
        children: [
          // image display
          PostImageStack(
            viewModel: viewModel,
            index: index,
            selectedImageUrl: selectedImageUrl,
            foregroundImage: foregroundImage,
            backgroundImage: backgroundImage,
          ),
          const SizedBox(height: height_20),

          // Post title
          Row(
            children: [
              const Spacer(),
              Text(
                post.posttitle ?? 'No title',
                style: GoogleFonts.bokor(
                  color: kcWhite,
                  fontSize: size_22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Reactions and comments
          PostActionsRow(
            viewModel: viewModel,
            index: index,
            post: post,
          ),
        ],
      ),
    );
  }
}

//image widget
class PostImageStack extends StatelessWidget {
  final HomeViewModel viewModel;
  final int index;
  final String selectedImageUrl;
  final MediaFiles? foregroundImage;
  final MediaFiles? backgroundImage;

  const PostImageStack({
    Key? key,
    required this.viewModel,
    required this.index,
    required this.selectedImageUrl,
    this.foregroundImage,
    this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedImageUrl.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'No image available',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF888888), // soft grey
              letterSpacing: 0.5,
            ),
          ),
        ),
      );
    }

    return Stack(
      alignment: const Alignment(2, 0),
      children: [
        // Background image
        GestureDetector(
          onTap: () => _toggleImageSelection(context),
          child: OptimizedCachedImage(imageUrl: selectedImageUrl),
        ),

        // Foreground rotated image
        GestureDetector(
          onTap: () {
            viewModel.homeModel[index].isImageSelected =
                !viewModel.homeModel[index].isImageSelected;
            viewModel.rebuildUi();
          },
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(2 / 15),
            child: OptimizedCachedImage(imageUrl: selectedImageUrl),
          ),
        ),
      ],
    );
  }

  void _toggleImageSelection(BuildContext context) async {
    final getUserId =
        await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
    debugPrint('User ID: $getUserId');
    viewModel.isImageSelected = !viewModel.isImageSelected;
    viewModel.rebuildUi();
  }
}

// Optimized cached image widget
class OptimizedCachedImage extends StatelessWidget {
  final String imageUrl;

  const OptimizedCachedImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      memCacheHeight: 400, // Limit memory cache size
      memCacheWidth: 400,
      maxHeightDiskCache: 800, // Limit disk cache size
      maxWidthDiskCache: 800,
      placeholder: (context, url) => Container(
        height: 200,
        color: Colors.grey[800],
        child: const Center(
          child: CircularProgressIndicator(
            color: kcWhite,
            strokeWidth: 2,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: 200,
        color: Colors.grey[800],
        child: const Icon(Icons.error, color: Colors.white),
      ),
    );
  }
}

// comments and reactions
class PostActionsRow extends StatelessWidget {
  final HomeViewModel viewModel;
  final int index;
  final dynamic post; // Using dynamic to avoid import issues

  const PostActionsRow({
    Key? key,
    required this.viewModel,
    required this.index,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pre-calculate reaction text to avoid rebuilding
    final reactionText = _getReactionText();

    return Column(
      children: [
        GestureDetector(
          onTap: () => _navigateToComments(context),
          child: Row(
            children: [
              const Spacer(),
              Text(
                reactionText,
                style: GoogleFonts.lato(
                  color: kcWhite,
                  fontSize: size_14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: height_5),
        GestureDetector(
          onTap: () => _navigateToComments(context),
          child: Row(
            children: [
              const Spacer(),
              Text(
                '${post.commentsCount ?? 0} $ksCOMMENTS',
                style: GoogleFonts.lato(
                  color: kcWhite,
                  fontSize: size_14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: width_10),
              Text(
                '${post.totalReactions ?? 0} $ksREACTIONS',
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
    );
  }

  String _getReactionText() {
    try {
      if (index < viewModel.reactionTextList1.length) {
        return viewModel.reactionTextList1[index];
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  void _navigateToComments(BuildContext context) {
    viewModel.popupPhotoUploadNavigation(
      context,
      index,
      post.postId ?? '0',
    );
  }
}
