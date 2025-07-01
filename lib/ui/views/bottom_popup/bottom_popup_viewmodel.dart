import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/data/bean/model/comment_model.dart';
import 'package:music_app/ui/data/bean/model/home_page_model.dart';
import 'package:music_app/ui/views/home/model/comments/create_comments_model.dart';
import 'package:music_app/ui/views/home/model/comments/get_comments_model.dart';
import 'package:music_app/ui/views/home/model/reactions/create_reactions_model.dart';
import 'package:music_app/ui/views/home/model/reactions/get_reactions_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomPopupViewModel extends BaseViewModel {
  final TextEditingController commentController = TextEditingController();

  final navigationService = locator<NavigationService>();

  bool isImageSelected = false;
  bool isemoji = false;
  String? postId;
  String? emojiStr;

  GetCommentsModel? comments;
  GetReactionsModel? reactions;
  CreateCommentsModel? createComments;
  CreateReactionsModel? createReactions;

  int? replyingToCommentIndex;
  TextEditingController replyController = TextEditingController();

  Set<String> likedCommentIds = {};

  bool isCommentLiked(String commentId) {
    return likedCommentIds.contains(commentId);
  }

  EmojiData? emojiData;
  final emojis = [EmojiData];

  final homeModel = [
    HomePageModel(
      bgImage:
          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/WyattBlair/paper-texture-2.png',
      musicImage1:
          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/WyattBlair/collage.png',
      commends: '4',
      reactions: '20',
      title: 'Wyatt Blair',
      emoji: '10💙 11🍒 3☁️ 5✨ 6❤️',
    ),
    HomePageModel(
      bgImage:
          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/LostCat/paper-texture-1.png',
      musicImage1:
          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/LostCat/collage.png',
      commends: '9',
      reactions: '26',
      title: 'Lost Cat',
      emoji: '2🤍 4🎲 5🖤 7🔮',
    ),
    HomePageModel(
        bgImage:
            'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/Klypi/paper-texture-1.png',
        musicImage1:
            'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/Klypi/collage.png',
        commends: '9',
        reactions: '26',
        title: 'Lost Cat',
        emoji: '1💙 3📺4 ☁️ 4✨'),
  ];

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

  //Get Comments List API
  Future<void> getCommentsListAPI(String postId,
      {bool showLoader = true}) async {
    if (showLoader) setBusy(true);

    try {
      String endpoint =
          ApiConstants.baseURL + ApiEndpoints.getCommentsAPI + postId;
      final GetCommentsModel? _comments =
          await ApiService().commentsListAPI(endpoint: endpoint);

      if (_comments != null && _comments.data != null) {
        comments = _comments;
        debugPrint("Loaded comments: ${comments!.data!.length}");
        rebuildUi();
      }
    } catch (e) {
      // Handle error
    }

    if (showLoader) setBusy(false);
  }

  Future<void> submitComment(String comments) async {
    safePrint("post id $postId");
    safePrint("Commetns $comments");

    if (containsOnlyText(comments)) {
      createCommentsAPI(postId!, comments);
    } else {
      createReactionsAPI(postId!, emojiStr!.snakeCase);
      safePrint(emojiStr?.snakeCase);
    }
    safePrint(comments);
  }

  //Get Reactions List API
  Future<void> getReactionsListAPI(String postId) async {
    notifyListeners();
    try {
      String endpoint =
          ApiConstants.baseURL + ApiEndpoints.getReactionsAPI + postId;
      safePrint(endpoint);
      final GetReactionsModel? reaction =
          await ApiService().reactionsListAPI(endpoint: endpoint);
      if (reaction != null && reaction.data != null) {
        reactions = reaction;
        debugPrint("First reaction : ${reactions!.data!.length}");
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  //Create Comments API
  Future<void> createCommentsAPI(String postId, String comments) async {
    notifyListeners();
    try {
      String endpoint =
          ApiConstants.baseURL + ApiEndpoints.getCommentsAPI + postId;
      safePrint(endpoint);
      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
      final CreateCommentsModel? createdComments = await ApiService()
          .createCommentsAPI(
              endpoint: endpoint,
              data: {"userId": getUserId, "commentText": comments});
      if (createdComments != null && createdComments.data != null) {
        createComments = createdComments;
        debugPrint("Create comments : ${createComments!.data!}");
        rebuildUi();
        getCommentsListAPI(postId, showLoader: false);
      } else {}
    } catch (e) {}
    notifyListeners();
  }

// Create Reply Comment
  Future<void> createReplyCommentsAPI(
      String postId, String comments, String parentCommentId) async {
    notifyListeners();
    try {
      String endpoint =
          ApiConstants.baseURL + ApiEndpoints.getCommentsAPI + postId;
      safePrint(endpoint);
      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
      final CreateCommentsModel? createdComments = await ApiService()
          .createCommentsAPI(endpoint: endpoint, data: {
        "userId": getUserId,
        "commentText": comments,
        "parentCommentId": parentCommentId
      });
      if (createdComments != null && createdComments.data != null) {
        createComments = createdComments;
        debugPrint("Create comments : ${createComments!.data!}");
        getCommentsListAPI(postId, showLoader: false);
        rebuildUi();
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  //Create Reactions API
  Future<void> createReactionsAPI(String postId, String comments) async {
    notifyListeners();
    try {
      String endpoint = ApiConstants.baseURL + ApiEndpoints.createReactionsAPI;
      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
      final CreateReactionsModel? createdReactions = await ApiService()
          .createReactionsAPI(endpoint: endpoint, data: {
        "userId": getUserId,
        "postId": postId,
        "reactionType": comments
      });
      if (createdReactions != null && createdReactions.data != null) {
        createReactions = createdReactions;
        debugPrint("Create reactions : ${createReactions!.data!}");
        rebuildUi();
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  // bool containsOnlyText(String text) {
  //   final textRegex = RegExp(r'^[a-zA-Z0-9\s]+$');
  //   return textRegex.hasMatch(text);
  // }

  bool containsOnlyText(String text) {
    final emojiRegex = RegExp(
      r'[\u203C-\u3299\uD83C-\uDBFF\uDC00-\uDFFF]+',
      unicode: true,
    );
    final cleaned = text.replaceAll(emojiRegex, '').trim();
    return cleaned.isNotEmpty;
  }

  //Comment like
  void toggleLike(String commentId) {
    if (isCommentLiked(commentId)) {
      likedCommentIds.remove(commentId);
    } else {
      likedCommentIds.add(commentId);
    }

    rebuildUi();
  }
}
