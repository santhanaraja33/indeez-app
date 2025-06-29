import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_dropdown.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/data/bean/model/comment_model.dart';
import 'package:music_app/ui/data/bean/model/home_page_model.dart';
import 'package:music_app/ui/views/bottom_popup/bottom_popup_view.dart';
import 'package:music_app/ui/views/home/model/post/post_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
//Post

  PostModel? _post;
  bool _isLoading = false;
  String? _error;

  PostModel? get post => _post;
  bool get isLoading => _isLoading;
  String? get post_error => _error;

  List<Data> get postList => _post?.data ?? [];

  String? userProfileImage;
  String? images;

  File? file;
  File? imageFile;
  List<File> selectedFiles = [];

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

  //Get Post List API
  Future<void> getUserPostsAPI() async {
    _isLoading = true;
    notifyListeners();
    try {
      const String endpoint = ApiConstants.baseURL + ApiEndpoints.getPostsAPI;
      final PostModel? post = await ApiService().homePost(endpoint: endpoint);
      if (post != null && post.data != null) {
        _post = post;
        debugPrint("First post image key: ${_post!.data!.first.mediaItems}");
      } else {
        _error = 'No posts found';
      }
    } catch (e) {
      _error = 'Error: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  void showCreatePostDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    bool isPrivate = false;
    String? selectedResourceType;

    final List<String> resourceTypes = ['Image', 'Video', 'Audio'];

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
                                    selectedFiles[index],
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
                              'Private Post ?',
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 15),
                            ),
                            Switch(
                              value: isPrivate,
                              onChanged: (val) {
                                setState(() {
                                  isPrivate = val;
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
                          value: selectedResourceType,
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
                                style: GoogleFonts.lato(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          titleTextColor: Colors.white,
                          bgColor: Colors.black87,
                        ),

                        const SizedBox(height: 30),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: AppCommonButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            buttonName: 'Create Post',
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

      selectedFiles = files.map((xfile) => File(xfile.path)).toList();
      setState(() {});
      notifyListeners();
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }
}
