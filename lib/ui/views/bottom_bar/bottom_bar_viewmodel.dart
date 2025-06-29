import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_common_button.dart';
import 'package:music_app/ui/common/app_common_textfield.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/data/bean/model/bottom_bar_model.dart';
import 'package:music_app/ui/views/event/event_view.dart';
import 'package:music_app/ui/views/home/presentation/home_view.dart';
import 'package:music_app/ui/views/my_playlist/my_playlist_view.dart';
import 'package:music_app/ui/views/shop/shop_view.dart';
import 'package:music_app/ui/views/swipe/swipe_view.dart';
import 'package:stacked/stacked.dart';

class BottomBarViewModel extends BaseViewModel {
  final List<Widget> pages = <Widget>[
    const HomeView(),
    const MyPlaylistView(),
    const SwipeView(),
    const EventView(),
    const ShopView(),
  ];
  final drawerItems = [
    BottomBarModel('', Icons.home_outlined,
        'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/home-blue.svg'),
    BottomBarModel('', Icons.sports_esports,
        'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/playlist-blue.svg'),
    BottomBarModel('', Icons.bolt,
        'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/swipe-blue.svg'),
    BottomBarModel('', Icons.calendar_month,
        'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/calendar-blue.svg'),
    BottomBarModel('', Icons.local_mall,
        'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/shop-blue.svg'),
  ];
  int bottomBarSelectedIndex = 0;

  void onItemTapped(int index) {
    bottomBarSelectedIndex = index;
    rebuildUi();
  }
}
