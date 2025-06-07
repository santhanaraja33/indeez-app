import 'package:flutter/material.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/ui/data/bean/model/gridview_model.dart';
import 'package:music_app/ui/data/bean/model/home_page_model.dart';
import 'package:music_app/ui/views/search_details/model/calender_model.dart';
import 'package:music_app/ui/views/search_details/model/tabbar_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchDetailsViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final postModel = [
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
  //
  final gridMusicModel = [
    GridViewModels(
      'Top 5',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums1.jpg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Swiped Like',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums2.jpg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Some other playlist',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums3.jpg',
      '',
      '',
      '',
    ),
  ];

  final gridShopModel = [
    GridViewModels(
      'Sticker \$10.50 USD',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/assets/album-Xork7llQ.webp',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Sticker \$20.50 USD',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/assets/album-BZUmVljK.webp',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Sticker \$12.50 USD',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/assets/album-PcyUSDn7.jpg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Sticker \$2.50 USD',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/JoelTylerWall/JoelTylerWall1.jpg',
      '',
      '',
      '',
    ),
  ];

  //

  final calenderModel = [
    CalenderModel(
      date: '01 Jan 2024',
      eventName: 'New Releases',
    ),
    CalenderModel(
      date: '10 Jan 2024',
      eventName: 'New Releases',
    ),
    CalenderModel(
      date: '30 Apr 2024',
      eventName: 'New Releases',
    )
  ];
  //
  final payListModel = [
    GridViewModels(
      'Top 5',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums1.jpg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Swiped Like',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums2.jpg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Some other playlist',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums3.jpg',
      '',
      '',
      '',
    ),
  ];
  //
  final tabbarModel = [
    TabbarModel(
      title: 'Posts',
    ),
    TabbarModel(
      title: 'Music',
    ),
    TabbarModel(
      title: 'Shop',
    ),
    TabbarModel(
      title: 'Calendar',
    ),
    TabbarModel(
      title: 'Playlists',
    ),
    TabbarModel(
      title: 'Stash',
    ),
  ];
  //
  final gridviewModel = [
    GridViewModels(
      'Top 5',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums1.jpg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Swiped Like',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums2.jpg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Some other playlist',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums3.jpg',
      '',
      '',
      '',
    ),
  ];
}
