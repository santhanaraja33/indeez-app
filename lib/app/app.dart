import 'package:music_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:music_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:music_app/ui/views/home/presentation/home_view.dart';
import 'package:music_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:music_app/ui/views/password/presentation/password_view.dart';
import 'package:music_app/ui/views/signup/presentation/signup_view.dart';
import 'package:music_app/ui/views/create_account/create_account_view.dart';
import 'package:music_app/ui/views/bottom_bar/bottom_bar_view.dart';
import 'package:music_app/ui/views/my_playlist/my_playlist_view.dart';
import 'package:music_app/ui/views/swipe/swipe_view.dart';
import 'package:music_app/ui/views/event/event_view.dart';
import 'package:music_app/ui/views/shop/shop_view.dart';
import 'package:music_app/ui/views/forgotpassword/forgotpassword_view.dart';
import 'package:music_app/ui/views/otp_verify/otp_verify_view.dart';
import 'package:music_app/ui/views/changepassword/changepassword_view.dart';
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart';
import 'package:music_app/ui/views/userprofile/presentation/userprofile_view.dart';
import 'package:music_app/ui/views/bottom_popup/bottom_popup_view.dart';
import 'package:music_app/ui/views/paylist_popup/paylist_popup_view.dart';
import 'package:music_app/ui/views/search/search_view.dart';
import 'package:music_app/ui/views/search_details/search_details_view.dart';
import 'package:music_app/ui/views/notification/notification_view.dart';
import 'package:music_app/ui/views/calendar/calendar_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: PasswordView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: CreateAccountView),
    MaterialRoute(page: BottomBarView),
    MaterialRoute(page: MyPlaylistView),
    MaterialRoute(page: SwipeView),
    MaterialRoute(page: EventView),
    MaterialRoute(page: ShopView),
    MaterialRoute(page: ForgotpasswordView),
    MaterialRoute(page: OtpVerifyView),
    MaterialRoute(page: ChangepasswordView),
    MaterialRoute(page: RightmenuView),
    MaterialRoute(page: UserprofileView),
    MaterialRoute(page: BottomPopupView),
    MaterialRoute(page: PaylistPopupView),
    MaterialRoute(page: SearchView),
    MaterialRoute(page: SearchDetailsView),
    MaterialRoute(page: NotificationView),
    MaterialRoute(page: CalendarView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
