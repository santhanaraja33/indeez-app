import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/rightmenu/model/rightmenu_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RightmenuViewModel extends BaseViewModel {
  bool showAppBar = true;
  final navigationService = locator<NavigationService>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final drawerItems = [
    DrawerItem(ksSearch, Icons.search, 'dashboard_info', '', ''),
    DrawerItem(ksHome, Icons.home, 'dashboard_info', '', ''),
    DrawerItem(ksCalendar, Icons.calendar_month, 'dashboard_info', '', ''),
    DrawerItem(ksNotifications, Icons.notifications, 'dashboard_info', '', ''),
    DrawerItem(ksAccountDetails, Icons.settings, 'dashboard_info', '', ''),
    DrawerItem(ksLogout, Icons.logout, 'dashboard_info', '', ''),
  ];
  bool isSelected = false;
  int selectedDrawerIndex = 0;
  selectedDrawerItems(int index) {
    isSelected = !isSelected;
    rebuildUi();
  }

  onSelectItem(int index) {
    selectedDrawerIndex = index;
    rebuildUi();
  }

  onSelectMenuItem(int index, BuildContext context) {
    selectedDrawerIndex = index;
    rebuildUi();
    DrawerItem selectedItem = (drawerItems)[index];
    String selectedMenuName = selectedItem.title ?? '';
    if (selectedMenuName.contains(ksAccountDetails)) {
      navigationService.back();
      navigationService.navigateToUserprofileView();
    } else if (selectedMenuName.contains(ksHome)) {
      navigationService.back();
      navigationService.navigateToBottomBarView();
    } else if (selectedMenuName.contains(ksDeleteAccount)) {
      navigationService.back();
    } else if (selectedMenuName.contains(ksDMS)) {
      navigationService.back();
      Clipboard.setData(ClipboardData(
        text: '${ksAppName.toUpperCase()}\n $ksPlayStoreLink',
      ));
      Share.share(
        '${ksAppName.toUpperCase()}\n $ksPlayStoreLink',
        subject: '${ksAppName.toUpperCase()}\n $ksPlayStoreLink',
      );
    } else if (selectedMenuName.contains(ksSearch)) {
      navigationService.back();
      navigationService.navigateToSearchView();
    } else if (selectedMenuName.contains(ksCalendar)) {
      navigationService.back();
      navigationService.navigateToCalendarView();
    } else if (selectedMenuName.contains(ksMediaquality)) {
      navigationService.back();
    } else if (selectedMenuName.contains(ksNotifications)) {
      navigationService.back();
      navigationService.navigateToNotificationView();
    } else if (selectedMenuName.contains(ksLogout)) {
      navigationService.back();
      Theme.of(context).platform == TargetPlatform.iOS
          ? showiOSAlertDialog(context, '', '')
          : showAndroidAlertDialog(context, '', '');
    } else {
      navigationService.back();
      navigationService.navigateToBottomBarView();
    }
  }
  //

  showAndroidAlertDialog(
      BuildContext context, String vehicleNumber, String vehicleID) {
    Widget cancelButton = TextButton(
      child: Text(
        ksCancel,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        navigationService.back();
      },
    );
    Widget continueButton = TextButton(
        child: Text(
          ksLogout,
          style: GoogleFonts.lato(color: kcRed, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          if (context.mounted) {
            Navigator.pop(context, ksCancel);
          }
          doLogout();
        });

    AlertDialog alert = AlertDialog(
      title: Text(
        ksLogout,
        style: GoogleFonts.lato(
          fontSize: size_16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        '$ksLogoutHint?',
        style: GoogleFonts.lato(
          fontSize: size_16,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showiOSAlertDialog(
      BuildContext context, String vehicleNumber, String vehicleID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            ksLogout,
            style: GoogleFonts.lato(
              fontSize: size_16,
              color: kcBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '$ksLogoutHint?',
            style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          actions: [
            CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(
                  ksCancel,
                  style: GoogleFonts.lato(
                    fontSize: size_16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  navigationService.back();
                }),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                ksLogout,
                style:
                    GoogleFonts.lato(color: kcRed, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                if (context.mounted) {
                  navigationService.back();
                }
                rebuildUi();
                doLogout();
              },
            ),
          ],
        );
      },
    );
  }

  doLogout() async {
    navigationService.navigateToPasswordView();
    rebuildUi();
  }
}
