import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/home/model/post/post_download_media_model.dart';
import 'package:music_app/ui/views/home/view_model/home_viewmodel.dart';
import 'package:music_app/ui/views/home/widgets/post_image.dart';
import 'package:music_app/ui/views/home/widgets/reactions_row.dart';

Widget buildPostItem(BuildContext context, int index, HomeViewModel viewModel) {
  String selectedImageUrl = '';
  String bgUrl = '';
  String fgUrl = '';

  if (viewModel.homePostModel[index].resourceType == "image") {
    if (index < viewModel.downloadMediaList.length) {
      final post = viewModel.downloadMediaList[index];

      final backgroundImage = post.mediaFiles?.firstWhere(
        (file) => file.index == 0,
        orElse: () => MediaFiles(),
      );

      final foregroundImage = post.mediaFiles?.firstWhere(
        (file) => file.index == 1,
        orElse: () => MediaFiles(),
      );

      bgUrl = backgroundImage?.mediaUrl ?? '';
      fgUrl = foregroundImage?.mediaUrl ?? '';

      precacheImage(CachedNetworkImageProvider(bgUrl), context);
      precacheImage(CachedNetworkImageProvider(fgUrl), context);

      selectedImageUrl = viewModel.homePostModel[index].isImageSelected == true
          ? fgUrl
          : bgUrl;
    }
  }

  final reactionsMap =
      viewModel.homePostModel[index].reactionsCount?.counts ?? {};

  final reactionList = reactionsMap.entries
      .where((entry) =>
          viewModel.reactionEmojiMap.containsKey(entry.key) && entry.value > 0)
      .map((entry) => Reaction(
            key: entry.key,
            emoji: viewModel.reactionEmojiMap[entry.key]!,
            count: entry.value,
          ))
      .toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      selectedImageUrl.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_library_outlined,
                      size: 48, color: Colors.grey[400]),
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
          : Stack(
              alignment: const Alignment(2, 0),
              children: [
                buildBackgroundImage(selectedImageUrl, () async {
                  viewModel.isImageSelected = !viewModel.isImageSelected;
                  viewModel.rebuildUi();
                }),
                buildForegroundImage(selectedImageUrl, () async {
                  viewModel.homePostModel[index].isImageSelected =
                      !viewModel.homePostModel[index].isImageSelected;
                  viewModel.rebuildUi();
                }),
              ],
            ),
      const SizedBox(height: height_30),
      Row(
        children: [
          const Spacer(),
          Text(
            viewModel.homePostModel[index].posttitle ?? 'No title',
            style: GoogleFonts.bokor(
              color: kcWhite,
              fontSize: size_22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          buildReactionRow(reactionList),
        ],
      ),
      const SizedBox(height: height_5),
      GestureDetector(
        onTap: () {
          viewModel.popupPhotoUploadNavigation(
            context,
            index,
            viewModel.homePostModel[index].postId ?? '0',
          );
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
            const SizedBox(width: width_10),
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
      const SizedBox(height: height_30),
    ],
  );
}
