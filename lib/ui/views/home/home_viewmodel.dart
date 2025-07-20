import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_font_provider.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/data/bean/model/comment_model.dart';
import 'package:music_app/ui/data/bean/model/home_page_model.dart';
import 'package:music_app/ui/views/bottom_popup/bottom_popup_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  bool isImageSelected = false;
  bool isemoji = false;
  popupPhotoUploadNavigation(BuildContext context) async {
    showCupertinoModalPopup(
        context: context, builder: (context) => const BottomPopupView());

    rebuildUi();
  }

  // bgImage:
  //     'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/homeImgs/LostCat/paper-texture-1.png',
  final homeModel = [
    HomePageModel(
      bgImage: 'assets/images/guitarphone.jpeg',
      musicImage1: 'assets/images/piano.jpeg',
      commends: '4',
      reactions: '20',
      title: 'Wyatt Blair',
      emoji: '10💙 11🍒 3☁️ 5✨ 6❤️',
    ),
    HomePageModel(
      bgImage: 'assets/images/piano.jpeg',
      musicImage1: 'assets/images/allrock.jpeg',
      commends: '9',
      reactions: '26',
      title: 'Lost Cat',
      emoji: '2🤍 4🎲 5🖤 7🔮',
    ),
    HomePageModel(
        bgImage: 'assets/images/collage-pink-tape.jpeg',
        musicImage1: 'assets/images/piano.jpeg',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
  ];
  EmojiData? emojiData;
  void navi() {}
  final commentModel = [
    CommentModel(
      title: 'MusicLover94',
      subTitle: 'YES! I agree! This album was amazing!',
    ),
    CommentModel(
      title: 'SomeoneElse',
      subTitle: '@Username123 Did you see this?',
    ),
    CommentModel(
      title: 'Username123',
      subTitle:
          "I loved this album! It was so good! I can't wait for the next one!",
    ),
  ];

  bottomSheetpopUp(BuildContext context, int index) {
    showModalBottomSheet<void>(
        backgroundColor: kcBgColor,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 600,
            width: double.infinity,
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
                          '${homeModel[index].commends ?? ''} $ksCOMMENTS',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: size_10.sp,
                                  color: kcTextGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Provider.of<FontNotifier>(context)
                                      .currentFont),
                        ),
                        const SizedBox(
                          width: width_10,
                        ),
                        Text(
                          '${homeModel[index].reactions ?? ''} $ksREACTIONS',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: size_10.sp,
                                  color: kcTextGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Provider.of<FontNotifier>(context)
                                      .currentFont),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            navigationService.back();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //
                          },
                          child: const Icon(
                            Icons.emoji_emotions,
                            color: kcTextGrey,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            homeModel[index].emoji ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontSize: size_14.sp,
                                    color: kcTextGrey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        Provider.of<FontNotifier>(context)
                                            .currentFont),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppCommonTextfield(
                      label: Text(
                        'Add a comment',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: size_10.sp,
                                color: kcTextGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: Provider.of<FontNotifier>(context)
                                    .currentFont),
                      ),
                    ),
                    isemoji == false
                        ? Container()
                        : EmojiSelector(
                            withTitle: false,
                            padding: const EdgeInsets.all(20),
                            onSelected: (emoji) {
                              emojiData = emoji;
                              rebuildUi();
                            },
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      itemCount: commentModel.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                commentModel[index].title ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontSize: size_16.sp,
                                        color: kcWhite,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            Provider.of<FontNotifier>(context)
                                                .currentFont),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      commentModel[index].subTitle ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontSize: size_14.sp,
                                              color: kcWhite,
                                              fontWeight: FontWeight.w500,
                                              fontFamily:
                                                  Provider.of<FontNotifier>(
                                                          context)
                                                      .currentFont),
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
          );
        });
  }
}
