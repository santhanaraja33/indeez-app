import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotpasswordViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  void navigationToOTPView() {
    navigationService.navigateToOtpVerifyView(email: '');
  }
}
