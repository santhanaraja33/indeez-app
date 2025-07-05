import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_dropdown.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/data/bean/model/comment_model.dart';
import 'package:music_app/ui/data/bean/model/home_page_model.dart';
import 'package:music_app/ui/views/bottom_popup/presentation/bottom_popup_view.dart';
import 'package:music_app/ui/views/home/model/comments/create_comments_model.dart';
import 'package:music_app/ui/views/home/model/post/create_post_model.dart';
import 'package:music_app/ui/views/home/model/post/homefeed_public_post_model.dart';
import 'package:music_app/ui/views/home/model/post/post_download_media_model.dart';
import 'package:music_app/ui/views/home/model/post/post_model.dart'
    hide Data, ReactionsCount;
import 'package:music_app/ui/views/home/model/post/post_update_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:path/path.dart' as p;

class HomeViewModel extends BaseViewModel {
  PostModel? _post;
  bool _isLoading = false;
  String? _error;
  PostDownloadMediaModel? downloadMedia;
  List<PostDownloadMediaModel> downloadMediaList = [];
  CreatePostModel? createPostModel;
  List<String> selectedFiles = [];
  List<File> selectedImages = [];
  List<Map<String, dynamic>> selectedImageItems = [];
  PostUpdateModel? updatePostModel;

  final List<String> reactionResult = [];
  String? reactionResultAdd;

  PostModel? get post => _post;
  bool get isLoading => _isLoading;
  String? get post_error => _error;
  HomefeedPublicPostModel? _publicPostModel;
  List<PublicPostData> get homePostModel => _publicPostModel?.data ?? [];

  List<Object> get postList => _post?.data ?? [];

  final navigationService = locator<NavigationService>();
  bool isImageSelected = false;
  bool isemoji = false;
  void popupPhotoUploadNavigation(
      BuildContext context, int index, String posId) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => BottomPopupView(posId),
    );
    rebuildUi();
  }

  late Map<String, dynamic> emojiList;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  bool isPrivate = false;
  String? selectedResourceType;
  String? selectedMode;

  final List<String> resourceTypes = ['Image', 'Video', 'Audio'];

  final Map<String, String> reactionEmojiMap = {
    "right_facing_fist": "🤜",
    "left_facing_fist": "🤛",
    "raised_back_of_hand": "🤚",
    "victory_hand": "✌️",
    "ear": "👂",
    "hand_with_fingers_splayed": "🖐️",
    "raised_hand_with_part_between_middle_and_ring_fingers": "🖖",
    "white_up_pointing_backhand_index": "👆",
    "white_down_pointing_backhand_index": "👇",
    "pinched_fingers": "🤌",
    "flexed_biceps": "💪",
    'like': '❤️',
  };

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
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
    HomePageModel(
        bgImage:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        musicImage1:
            'https://indeez.1skw54tc71lt.us-south.codeengine.appdomain.cloud/shop',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
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
                          // '${postList[index].commentsCount ?? ''} $ksCOMMENTS',
                          '',

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
                          // '${postList[index].likesCount ?? ''} $ksREACTIONS',
                          '',
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

  //Get Post List API
  Future<void> getUserPostsAPI() async {
    if (isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    // Clear previous data
    downloadMediaList.clear();
    postList.clear();

    try {
      const String endpoint =
          "${ApiConstants.baseURL}${ApiEndpoints.getPostsAPI}";
      final PostModel? post = await ApiService().homePost(endpoint: endpoint);

      if (post?.data?.isNotEmpty == true) {
        _post = post;

        // Process image downloads for all posts
        for (final postItem in _post!.data!) {
          if (postItem.resourceType == 'image' && postItem.postId != null) {
            postImageDownloadAPI(postItem.postId!).then((_) {
              notifyListeners();
            }).catchError((error) {
              print('Image download error for post ${postItem.postId}: $error');
            });
          }
        }
      } else {
        _error = 'No posts found';
      }
    } catch (e) {
      _error = 'Error: $e';
      print('getUserPostsAPI error: $e'); // Add logging
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

//Get Public post List API
  Future<void> getPublicPostsAPI() async {
    _isLoading = true;
    notifyListeners();
    try {
      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
      String endpoint =
          "${ApiConstants.baseURL}${ApiEndpoints.publicPostAPI}$getUserId";
      final HomefeedPublicPostModel? post =
          await ApiService().postUpdateAPI(endpoint: endpoint);
      print("HomefeedPublicPostModel lenght ${post?.data?.length}");

      if (post != null && post.data != null) {
        _publicPostModel = post;
        print("_publicPostModel ${_publicPostModel!.data?.length}");

        // Loop through each post and call download
        for (final postItem in post.data!) {
          int postIndex = post.data!.indexOf(postItem);
          print("postIndex ${postIndex}");

          reactionResultAdd = getReactionTextListForPost(postIndex).join(' ');
          print("reactionResultAdd ${reactionResultAdd}");

          if (postItem.resourceType == "image") {
            if (postItem.mediaItems!.isNotEmpty) {
              for (int i = 0; i < (postItem.mediaItems?.length ?? 0); i++) {
                if (postItem.mediaItems?[i].status == "uploaded") {
                  final postId = postItem.postId;
                  print("postIdr ${postId}");

                  if (postId != null) {
                    await Future.wait(post.data!.map(
                        (postItem) => postImageDownloadAPI(postItem.postId!)));
                  }
                }
              }
            }
          }
        }
        print("length of total length ${_publicPostModel?.data}");
        rebuildUi();
      } else {
        _error = 'No posts found';
      }
    } catch (e) {
      _error = 'Error: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  //Get Post List API
  Future<void> postImageDownloadAPI(String postId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final String endpoint =
          "${ApiConstants.baseURL}${ApiEndpoints.getPostImageDownloadAPI}$postId";

      final PostDownloadMediaModel? postImageDownload =
          await ApiService().postImageDownloadAPI(endpoint: endpoint);

      print(postImageDownload!.mediaFiles?.length);

      if (postImageDownload != null && postImageDownload.success == true) {
        // Add to a list if you're collecting all downloads
        downloadMediaList.add(postImageDownload);
        debugPrint("downloadMediaList $downloadMediaList");
      } else {
        debugPrint('No media found for post: $postId');
      }
    } catch (e) {
      debugPrint('Error downloading media for $postId: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  void showCreatePostDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImage.appBGImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Scaffold(
                  backgroundColor: Colors.black.withOpacity(0.6),
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: const Text('Create Post',
                        style: TextStyle(color: Colors.white)),
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Image Picker Placeholder
                        if (selectedFiles.isEmpty)
                          GestureDetector(
                            onTap: () {
                              pickMultipleImages(setState);
                            },
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white30),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                        const SizedBox(height: 20),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: selectedFiles.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    selectedImages[index],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                // Positioned close button in top-right
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedFiles.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        // Post Title
                        AppCommonTextfield(
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          label: Text(
                            ksTitle,
                            style: GoogleFonts.lato(color: kcTextGrey),
                          ),
                          onSubmitted: (p0) {},
                        ),

                        const SizedBox(height: 15),

                        // Description
                        AppCommonTextfield(
                          controller: descController,
                          height: height_100,
                          keyboardType: TextInputType.text,
                          minLines: 3,
                          maxLines: null,
                          label: Text(
                            ksDesc,
                            style: GoogleFonts.lato(color: kcTextGrey),
                          ),
                          onSubmitted: (p0) {},
                        ),

                        const SizedBox(height: 15),

                        // Privacy Toggle
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ksPrivatePostTitle,
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 15),
                            ),
                            Switch(
                              value: isPrivate,
                              onChanged: (val) {
                                setState(() {
                                  isPrivate = val;
                                  if (isPrivate == true) {
                                    selectedMode = "private";
                                  } else {
                                    selectedMode = "public";
                                  }
                                });
                              },
                              activeColor: Colors.white,
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // Resource Type Dropdown

                        AppDropDown(
                          title: 'Resource Type',
                          dropDownHint: 'Select a resource',
                          value: resourceTypes.contains(selectedResourceType)
                              ? selectedResourceType
                              : null,
                          onChanged: (val) {
                            setState(() {
                              selectedResourceType = val;
                            });
                          },
                          items: resourceTypes.map((type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(
                                type,
                                style: GoogleFonts.lato(color: Colors.blueGrey),
                              ),
                            );
                          }).toList(),
                          titleTextColor: Colors.grey,
                          bgColor: Colors.black87,
                        ),
                        const SizedBox(height: 30),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: AppCommonButton(
                            onPressed: () {
                              createPostMethod(context);
                            },
                            buttonName: ksCreatePost,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> pickMultipleImages(Function setState) async {
    try {
      final List<XFile>? files =
          await ImagePicker().pickMultipleMedia(imageQuality: 100);

      if (files == null || files.isEmpty) return;

      selectedImages = files.map((xfile) => File(xfile.path)).toList();
      for (var xfile in files) {
        final _ = p.extension(xfile.path);
        selectedFiles.add(p.basename(xfile.path));
      }

      setState(() {});
      notifyListeners();
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  Future<void> createPostMethod(BuildContext context) async {
    if (titleController.text.isEmpty || titleController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: ksPostTitle);
      return;
    }
    if (descController.text.isEmpty || descController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: ksPostDescription);
      return;
    }
    if (selectedResourceType!.isEmpty || selectedResourceType!.trim().isEmpty) {
      Fluttertoast.showToast(msg: ksResourceType);
      return;
    }
    if (selectedFiles.isEmpty) {
      Fluttertoast.showToast(
          msg: "Post creation $selectedResourceType is required");
      return;
    }
    if (selectedFiles.isNotEmpty) {
      List<Map<String, dynamic>> fileList = createFileList(selectedFiles);
      debugPrint('Error picking images: $fileList');
      selectedImageItems.addAll(fileList);
      debugPrint('Error picking images 123 : \n $selectedImageItems');
    }

    notifyListeners();
    try {
      String endpoint = "${ApiConstants.baseURL}${ApiEndpoints.createPostAPI}";
      safePrint(endpoint);
      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
      final CreatePostModel? createPost =
          await ApiService().createPostAPI(endpoint: endpoint, data: {
        "userId": getUserId,
        "posttitle": titleController.text.trim(),
        "content": descController.text.trim(),
        "privacy": selectedMode ?? '',
        "resourceType": selectedResourceType?.toLowerCase(),
        "files": selectedImageItems
      });

      if (createPost?.success == true) {
        createPostModel = createPost;
        debugPrint("Create post api response : ${createPostModel?.message}");
        Navigator.of(context).pop();
        for (int i = 0; i < createPostModel!.mediaUploadUrls!.length; i++) {
          final uploadUrl = createPostModel!.mediaUploadUrls![i].uploadUrl;
          final imagePath = selectedImages[i].path;
          final index =
              createPostModel!.postData!.mediaItems![i].index.toString();
          await uploadImageToAPI(
              uploadUrl!, imagePath, createPostModel!.postId!, index);
        }
        rebuildUi();
      } else {}
    } catch (e) {
      print('Create post api failed: $e');
    }
    notifyListeners();
  }

//ImageUrl upload
  Future<void> uploadImageToAPI(String imageUploadUrl, String selectedImagePath,
      String postId, String index) async {
    final dio = Dio();
    try {
      final imageBytes = await File(selectedImagePath).readAsBytes();
      final mimeType =
          lookupMimeType(selectedImagePath) ?? 'application/octet-stream';
      Response response = await dio.put(
        imageUploadUrl,
        data: imageBytes,
        options: Options(
          headers: {
            'Content-Type': mimeType,
          },
        ),
      );
      print('Upload success: ${response.statusCode}');
      if (response.statusCode == 200) {
        imageUploadUpdateStatusAPI(postId, index);
      }
    } catch (e) {
      print('Upload failed: $e');
    }
  }

//Update Image upload status
  Future<void> imageUploadUpdateStatusAPI(String postId, String index) async {
    notifyListeners();
    try {
      String endpoint =
          "${ApiConstants.baseURL}${ApiEndpoints.updatePostAPI}${"/$postId"}";
      safePrint(endpoint);
      safePrint("imageUploadUpdateStatusAPI $index");

      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
      final PostUpdateModel? updatePost = await ApiService().updatePostAPI(
          endpoint: endpoint,
          data: {"userId": getUserId, "index": index, "status": "uplpaded"});
      if (updatePost?.success == true) {
        updatePostModel = updatePost;
        debugPrint("Update post api response : ${updatePostModel?.message}");
        rebuildUi();
      } else {}
    } catch (e) {
      print('Update post api failed: $e');
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> createFileList(List<String> fileNames) {
    return List.generate(fileNames.length, (index) {
      final fileName = fileNames[index];
      final mimeType = getMimeType(fileName);
      return {
        "fileName": fileName,
        "mimeType": mimeType,
        "index": index,
      };
    });
  }

// Helper function to get MIME type from file extension
  String getMimeType(String fileName) {
    if (fileName.endsWith(".png")) return "image/png";
    if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
      return "image/jpeg";
    }
    if (fileName.endsWith(".gif")) return "image/gif";
    return "application/octet-stream"; // default fallback
  }

  List<String> getReactionTextListForPost(int index) {
    final List<String> result = [];

    if (_publicPostModel?.data != null &&
        index < _publicPostModel!.data!.length) {
      final postItem = _publicPostModel!.data![index];
      final reactions = postItem.reactionsCount?.toJson() ?? {};

      if (reactions.isEmpty) {
        result.add("No reactions");
      } else {
        reactions.forEach((key, value) {
          if (value is int && value > 0 && reactionEmojiMap.containsKey(key)) {
            result.add('${reactionEmojiMap[key]} $value');
          }
        });
      }
    } else {
      result.add("No post");
    }

    return result;
  }
}
