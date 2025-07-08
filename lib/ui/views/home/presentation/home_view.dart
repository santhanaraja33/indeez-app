import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_bg_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/home/model/post/post_download_media_model.dart';
import 'package:music_app/ui/views/home/widgets/post_image.dart';
import 'package:music_app/ui/views/home/widgets/post_item.dart';
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
    return _HomeViewContent(viewModel: viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

class _HomeViewContent extends StatefulWidget {
  final HomeViewModel viewModel;
  const _HomeViewContent({required this.viewModel});

  @override
  State<_HomeViewContent> createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<_HomeViewContent> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        widget.viewModel.getPublicPostsAPI();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    if (viewModel.isLoading &&
        !viewModel.isPaginating &&
        viewModel.homePostModel.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: kcWhite),
      );
    }

    if (viewModel.post_error != null) {
      return Center(
        child: Text(
          viewModel.post_error!,
        ),
      );
    }

    Future<void> prefetchImages(String bgUrl, String fgUrl) async {
      await Future.wait([
        precacheImage(CachedNetworkImageProvider(bgUrl), context),
        precacheImage(CachedNetworkImageProvider(fgUrl), context),
      ]);
    }

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
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          const AppCommonBGImage(),
          RefreshIndicator(
            key: const PageStorageKey<String>('home_scroll'),
            onRefresh: () async {
              await widget.viewModel.getPublicPostsAPI(isRefresh: true);
            },
            child: SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding_20),
                  child: Column(
                    children: [
                      const SizedBox(height: height_30),

                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: viewModel.homePostModel.length,
                          itemBuilder: (context, index) {
                            return buildPostItem(context, index, viewModel);
                          }),
                      const SizedBox(height: height_30),
                      // Show pagination loader only when paginating and there are posts
                      if (viewModel.isPaginating &&
                          viewModel.homePostModel.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: CircularProgressIndicator(color: kcWhite),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
