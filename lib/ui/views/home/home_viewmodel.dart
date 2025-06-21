import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/data/bean/model/comment_model.dart';
import 'package:music_app/ui/data/bean/model/home_page_model.dart';
import 'package:music_app/ui/views/bottom_popup/bottom_popup_view.dart';
import 'package:music_app/ui/views/home/model/post_model.dart';
import 'package:music_app/ui/views/userprofile/model/userprofile_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
//Post

  Post? _post;
  bool _isLoading = false;
  String? _error;

  Post? get post => _post;
  bool get isLoading => _isLoading;
  String? get post_error => _error;

  List<Data> get postList => _post?.data ?? [];

// End Post

  final navigationService = locator<NavigationService>();
  bool isImageSelected = false;
  bool isemoji = false;
  void popupPhotoUploadNavigation(BuildContext context, int index) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => BottomPopupView(),
    );

    rebuildUi();
  }

  final homeModel = [
    HomePageModel(
      bgImage:
          'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/homeImgs/DuzMancini/DuzMancini2.webp',
      musicImage1:
          'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/homeImgs/DuzMancini/DuzMancini2.webp',
      commends: '4',
      reactions: '20',
      title: 'Wyatt Blair',
      emoji: '10💙 11🍒 3☁️ 5✨ 6❤️',
    ),
    HomePageModel(
      bgImage:
          'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
      musicImage1:
          'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
      commends: '9',
      reactions: '26',
      title: 'Lost Cat',
      emoji: '2🤍 4🎲 5🖤 7🔮',
    ),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
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
                          '${postList[index].commentsCount ?? ''} $ksCOMMENTS',
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
                          '${postList[index].likesCount ?? ''} $ksREACTIONS',
                          style: GoogleFonts.lato(
                            color: kcTextGrey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
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
                                style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kcWhite),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      commentModel[index].subTitle ?? '',
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
          );
        });
  }

  Future<List<Users>?> getUserDetailAPI() async {
    final getUserId =
        await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
    debugPrint('User ID: $getUserId');
    final authResponse = await ApiService().getUserInfo(
      endpoint: ApiConstants.baseURL +
          ApiEndpoints.getProfileAPI +
          (getUserId ?? ''), // Replace with actual user ID
    );
    if (authResponse != null) {
      final info = authResponse.users?[0];
      print(info);
      print("User profile image: ${info}");
      if (info != null) {}
    }
    return null;
  }

  //Get Home Post

  Future<void> getUserPostsAPI() async {
    _isLoading = true;
    notifyListeners();

    try {
      const String endpoint = ApiConstants.baseURL + ApiEndpoints.getPostsAPI;

      final Post? post = await ApiService().homePost(endpoint: endpoint);

      if (post != null && post.data != null) {
        _post = post;
        debugPrint("First post image key: ${_post!.data!.first.s3Key}");
      } else {
        _error = 'No posts found';
      }
    } catch (e) {
      _error = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
