import 'package:flutter/material.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/ui/views/search/model/search_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchViewModel extends BaseViewModel {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  final navigationService = locator<NavigationService>();

  final searchModel = [
    SearchModel(
      image:
          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/profiles/lolipop/lolipoplogo.png',
      title: 'Lolipop Records',
      subTitle:
          'Lolipop records has been semi-revolutionary multi-cultural conglomeration of punk kids, loveless teen dreams & pop enthusiasts trying to change the world!',
    ),
    SearchModel(
      image:
          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/WyattBlair/WyattBlair2.jpg',
      title: 'Wyatt Blair',
      subTitle:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    ),
    SearchModel(
      image:
          'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/homeImgs/LostCat/LostCat2.webp',
      title: 'Lost Cat',
      subTitle: 'This is a Lost Cat bio',
    ),
  ];
  navigateToSearchdetails() {
    navigationService.navigateToSearchDetailsView();
  }
}
