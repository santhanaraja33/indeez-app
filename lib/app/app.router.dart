// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i25;
import 'package:flutter/material.dart';
import 'package:music_app/ui/views/bottom_bar/bottom_bar_view.dart' as _i8;
import 'package:music_app/ui/views/bottom_popup/presentation/bottom_popup_view.dart'
    as _i18;
import 'package:music_app/ui/views/calendar/calendar_view.dart' as _i23;
import 'package:music_app/ui/views/changepassword/changepassword_view.dart'
    as _i15;
import 'package:music_app/ui/views/create_account/create_account_view.dart'
    as _i7;
import 'package:music_app/ui/views/create_post/presentation/create_post_view.dart'
    as _i24;
import 'package:music_app/ui/views/email/presentation/email_view.dart' as _i5;
import 'package:music_app/ui/views/event/event_view.dart' as _i11;
import 'package:music_app/ui/views/forgotpassword/forgotpassword_view.dart'
    as _i13;
import 'package:music_app/ui/views/home/presentation/home_view.dart' as _i2;
import 'package:music_app/ui/views/my_playlist/my_playlist_view.dart' as _i9;
import 'package:music_app/ui/views/notification/notification_view.dart' as _i22;
import 'package:music_app/ui/views/otp_verify/otp_verify_view.dart' as _i14;
import 'package:music_app/ui/views/password/presentation/password_view.dart'
    as _i4;
import 'package:music_app/ui/views/paylist_popup/paylist_popup_view.dart'
    as _i19;
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart' as _i16;
import 'package:music_app/ui/views/search/search_view.dart' as _i20;
import 'package:music_app/ui/views/search_details/search_details_view.dart'
    as _i21;
import 'package:music_app/ui/views/shop/shop_view.dart' as _i12;
import 'package:music_app/ui/views/signup/presentation/signup_view.dart' as _i6;
import 'package:music_app/ui/views/startup/startup_view.dart' as _i3;
import 'package:music_app/ui/views/swipe/swipe_view.dart' as _i10;
import 'package:music_app/ui/views/userprofile/presentation/userprofile_view.dart'
    as _i17;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i26;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const passwordView = '/password-view';

  static const emailView = '/email-view';

  static const signupView = '/signup-view';

  static const createAccountView = '/create-account-view';

  static const bottomBarView = '/bottom-bar-view';

  static const myPlaylistView = '/my-playlist-view';

  static const swipeView = '/swipe-view';

  static const eventView = '/event-view';

  static const shopView = '/shop-view';

  static const forgotpasswordView = '/forgotpassword-view';

  static const otpVerifyView = '/otp-verify-view';

  static const changepasswordView = '/changepassword-view';

  static const rightmenuView = '/rightmenu-view';

  static const userprofileView = '/userprofile-view';

  static const bottomPopupView = '/bottom-popup-view';

  static const paylistPopupView = '/paylist-popup-view';

  static const searchView = '/search-view';

  static const searchDetailsView = '/search-details-view';

  static const notificationView = '/notification-view';

  static const calendarView = '/calendar-view';

  static const createPostView = '/create-post-view';

  static const all = <String>{
    homeView,
    startupView,
    passwordView,
    emailView,
    signupView,
    createAccountView,
    bottomBarView,
    myPlaylistView,
    swipeView,
    eventView,
    shopView,
    forgotpasswordView,
    otpVerifyView,
    changepasswordView,
    rightmenuView,
    userprofileView,
    bottomPopupView,
    paylistPopupView,
    searchView,
    searchDetailsView,
    notificationView,
    calendarView,
    createPostView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.passwordView,
      page: _i4.PasswordView,
    ),
    _i1.RouteDef(
      Routes.emailView,
      page: _i5.EmailView,
    ),
    _i1.RouteDef(
      Routes.signupView,
      page: _i6.SignupView,
    ),
    _i1.RouteDef(
      Routes.createAccountView,
      page: _i7.CreateAccountView,
    ),
    _i1.RouteDef(
      Routes.bottomBarView,
      page: _i8.BottomBarView,
    ),
    _i1.RouteDef(
      Routes.myPlaylistView,
      page: _i9.MyPlaylistView,
    ),
    _i1.RouteDef(
      Routes.swipeView,
      page: _i10.SwipeView,
    ),
    _i1.RouteDef(
      Routes.eventView,
      page: _i11.EventView,
    ),
    _i1.RouteDef(
      Routes.shopView,
      page: _i12.ShopView,
    ),
    _i1.RouteDef(
      Routes.forgotpasswordView,
      page: _i13.ForgotpasswordView,
    ),
    _i1.RouteDef(
      Routes.otpVerifyView,
      page: _i14.OtpVerifyView,
    ),
    _i1.RouteDef(
      Routes.changepasswordView,
      page: _i15.ChangepasswordView,
    ),
    _i1.RouteDef(
      Routes.rightmenuView,
      page: _i16.RightmenuView,
    ),
    _i1.RouteDef(
      Routes.userprofileView,
      page: _i17.UserprofileView,
    ),
    _i1.RouteDef(
      Routes.bottomPopupView,
      page: _i18.BottomPopupView,
    ),
    _i1.RouteDef(
      Routes.paylistPopupView,
      page: _i19.PaylistPopupView,
    ),
    _i1.RouteDef(
      Routes.searchView,
      page: _i20.SearchView,
    ),
    _i1.RouteDef(
      Routes.searchDetailsView,
      page: _i21.SearchDetailsView,
    ),
    _i1.RouteDef(
      Routes.notificationView,
      page: _i22.NotificationView,
    ),
    _i1.RouteDef(
      Routes.calendarView,
      page: _i23.CalendarView,
    ),
    _i1.RouteDef(
      Routes.createPostView,
      page: _i24.CreatePostView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.PasswordView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.PasswordView(),
        settings: data,
      );
    },
    _i5.EmailView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.EmailView(),
        settings: data,
      );
    },
    _i6.SignupView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.SignupView(),
        settings: data,
      );
    },
    _i7.CreateAccountView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.CreateAccountView(),
        settings: data,
      );
    },
    _i8.BottomBarView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.BottomBarView(),
        settings: data,
      );
    },
    _i9.MyPlaylistView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.MyPlaylistView(),
        settings: data,
      );
    },
    _i10.SwipeView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.SwipeView(),
        settings: data,
      );
    },
    _i11.EventView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.EventView(),
        settings: data,
      );
    },
    _i12.ShopView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.ShopView(),
        settings: data,
      );
    },
    _i13.ForgotpasswordView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.ForgotpasswordView(),
        settings: data,
      );
    },
    _i14.OtpVerifyView: (data) {
      final args = data.getArgs<OtpVerifyViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i14.OtpVerifyView(key: args.key, email: args.email),
        settings: data,
      );
    },
    _i15.ChangepasswordView: (data) {
      final args = data.getArgs<ChangepasswordViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i15.ChangepasswordView(args.email, args.otp, key: args.key),
        settings: data,
      );
    },
    _i16.RightmenuView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.RightmenuView(),
        settings: data,
      );
    },
    _i17.UserprofileView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.UserprofileView(),
        settings: data,
      );
    },
    _i18.BottomPopupView: (data) {
      final args = data.getArgs<BottomPopupViewArguments>(nullOk: false);
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.BottomPopupView(args.postId,
            onCommentUpdated: args.onCommentUpdated,
            onReactionUpdated: args.onReactionUpdated,
            key: args.key),
        settings: data,
      );
    },
    _i19.PaylistPopupView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.PaylistPopupView(),
        settings: data,
      );
    },
    _i20.SearchView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.SearchView(),
        settings: data,
      );
    },
    _i21.SearchDetailsView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.SearchDetailsView(),
        settings: data,
      );
    },
    _i22.NotificationView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i22.NotificationView(),
        settings: data,
      );
    },
    _i23.CalendarView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.CalendarView(),
        settings: data,
      );
    },
    _i24.CreatePostView: (data) {
      return _i25.MaterialPageRoute<dynamic>(
        builder: (context) => const _i24.CreatePostView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class OtpVerifyViewArguments {
  const OtpVerifyViewArguments({
    this.key,
    required this.email,
  });

  final _i25.Key? key;

  final String email;

  @override
  String toString() {
    return '{"key": "$key", "email": "$email"}';
  }

  @override
  bool operator ==(covariant OtpVerifyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.email == email;
  }

  @override
  int get hashCode {
    return key.hashCode ^ email.hashCode;
  }
}

class ChangepasswordViewArguments {
  const ChangepasswordViewArguments({
    required this.email,
    required this.otp,
    this.key,
  });

  final String? email;

  final String? otp;

  final _i25.Key? key;

  @override
  String toString() {
    return '{"email": "$email", "otp": "$otp", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ChangepasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.email == email && other.otp == otp && other.key == key;
  }

  @override
  int get hashCode {
    return email.hashCode ^ otp.hashCode ^ key.hashCode;
  }
}

class BottomPopupViewArguments {
  const BottomPopupViewArguments({
    required this.postId,
    this.onCommentUpdated,
    this.onReactionUpdated,
    this.key,
  });

  final String postId;

  final dynamic Function(
    String,
    int,
  )? onCommentUpdated;

  final dynamic Function(
    String,
    int,
  )? onReactionUpdated;

  final _i25.Key? key;

  @override
  String toString() {
    return '{"postId": "$postId", "onCommentUpdated": "$onCommentUpdated", "onReactionUpdated": "$onReactionUpdated", "key": "$key"}';
  }

  @override
  bool operator ==(covariant BottomPopupViewArguments other) {
    if (identical(this, other)) return true;
    return other.postId == postId &&
        other.onCommentUpdated == onCommentUpdated &&
        other.onReactionUpdated == onReactionUpdated &&
        other.key == key;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        onCommentUpdated.hashCode ^
        onReactionUpdated.hashCode ^
        key.hashCode;
  }
}

extension NavigatorStateExtension on _i26.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.passwordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEmailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.emailView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createAccountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBottomBarView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.bottomBarView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyPlaylistView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myPlaylistView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSwipeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.swipeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.eventView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToShopView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.shopView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgotpasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.forgotpasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOtpVerifyView({
    _i25.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.otpVerifyView,
        arguments: OtpVerifyViewArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangepasswordView({
    required String? email,
    required String? otp,
    _i25.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.changepasswordView,
        arguments:
            ChangepasswordViewArguments(email: email, otp: otp, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRightmenuView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.rightmenuView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUserprofileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.userprofileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBottomPopupView({
    required String postId,
    dynamic Function(
      String,
      int,
    )? onCommentUpdated,
    dynamic Function(
      String,
      int,
    )? onReactionUpdated,
    _i25.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.bottomPopupView,
        arguments: BottomPopupViewArguments(
            postId: postId,
            onCommentUpdated: onCommentUpdated,
            onReactionUpdated: onReactionUpdated,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPaylistPopupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.paylistPopupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSearchView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.searchView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSearchDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.searchDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCalendarView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.calendarView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreatePostView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createPostView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.passwordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEmailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.emailView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createAccountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBottomBarView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.bottomBarView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyPlaylistView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myPlaylistView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSwipeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.swipeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.eventView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithShopView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.shopView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgotpasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.forgotpasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOtpVerifyView({
    _i25.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.otpVerifyView,
        arguments: OtpVerifyViewArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangepasswordView({
    required String? email,
    required String? otp,
    _i25.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.changepasswordView,
        arguments:
            ChangepasswordViewArguments(email: email, otp: otp, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRightmenuView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.rightmenuView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUserprofileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.userprofileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBottomPopupView({
    required String postId,
    dynamic Function(
      String,
      int,
    )? onCommentUpdated,
    dynamic Function(
      String,
      int,
    )? onReactionUpdated,
    _i25.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.bottomPopupView,
        arguments: BottomPopupViewArguments(
            postId: postId,
            onCommentUpdated: onCommentUpdated,
            onReactionUpdated: onReactionUpdated,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPaylistPopupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.paylistPopupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSearchView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.searchView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSearchDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.searchDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCalendarView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.calendarView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreatePostView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createPostView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
