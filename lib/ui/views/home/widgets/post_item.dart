import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/home/view_model/home_viewmodel.dart';
import 'package:music_app/ui/views/home/widgets/post_image.dart';
import 'package:music_app/ui/views/home/widgets/reactions_row.dart';

Widget buildPostItem(BuildContext context, int index, HomeViewModel viewModel) {
  String selectedImageUrl = '';
  String bgUrl = '';
  String fgUrl = '';
  safePrint(
      "buildPostItem resourcetype : ${viewModel.homePostModel[index].resourceType}");

  if (viewModel.homePostModel[index].resourceType == "image") {
    if (viewModel.homePostModel[index].mediaItems!.isNotEmpty) {
      for (var item in viewModel.homePostModel[index].mediaItems!) {
        if (item.status == "uploaded" || item.status == "uplpaded") {
          safePrint("index ${index}: ${item.mediaUrl}");

          bgUrl = item.mediaUrl ?? '';
          fgUrl = item.mediaUrl ?? '';

          safePrint("fgUrl: $fgUrl");
          safePrint("bgUrl: $bgUrl");

          precacheImage(CachedNetworkImageProvider(bgUrl), context);
          precacheImage(CachedNetworkImageProvider(fgUrl), context);

          selectedImageUrl =
              viewModel.homePostModel[index].isImageSelected == true
                  ? fgUrl
                  : bgUrl;
          break;
        }
      }
    }
  }
  if (viewModel.homePostModel[index].resourceType == "audio") {
    if (viewModel.homePostModel[index].mediaItems!.isNotEmpty) {
      for (var item in viewModel.homePostModel[index].mediaItems!) {
        fgUrl = item.mediaUrl ?? '';
      }
    }
    precacheImage(CachedNetworkImageProvider(selectedImageUrl), context);
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
              alignment: Alignment.center,
              children: [
                Center(
                    child: buildBackgroundImage(
                  selectedImageUrl,
                  () async {
                    viewModel.isImageSelected = !viewModel.isImageSelected;
                    viewModel.rebuildUi();
                  },
                )),
                Center(
                    child: buildForegroundImage(
                  selectedImageUrl,
                  () async {
                    viewModel.homePostModel[index].isImageSelected =
                        !viewModel.homePostModel[index].isImageSelected;
                    viewModel.rebuildUi();
                  },
                )),
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
