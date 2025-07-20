import 'package:emoji_selector/emoji_selector.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/ui/data/bean/model/comment_model.dart';
import 'package:music_app/ui/data/bean/model/home_page_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomPopupViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  bool isImageSelected = false;
  bool isemoji = false;

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
}
