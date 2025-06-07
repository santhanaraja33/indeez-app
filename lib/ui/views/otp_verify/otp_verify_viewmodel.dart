import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OtpVerifyViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  bool isPassword = true;
  void navigationToChangePassword() {
    navigationService.navigateToChangepasswordView();
  }
}
