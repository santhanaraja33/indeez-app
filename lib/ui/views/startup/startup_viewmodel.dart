import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isLoggedIn = await SharedPreferencesHelper.getLoginStatus();
    print('startup loggedin $isLoggedIn');
    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
    // SharedPreferencesHelper.clearAll();
    if (isLoggedIn) {
      _navigationService.replaceWithBottomBarView();
    } else {
      _navigationService.replaceWithEmailView();
    }
  }
}
