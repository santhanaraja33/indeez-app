import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateAccountViewModel extends BaseViewModel {
  bool isChecked = false;
  final navigationService = locator<NavigationService>();

  void navigationToBottomBar() {
    navigationService.navigateToBottomBarView();
  }

  void checkBoxSelected(bool value) {
    isChecked = value;
    rebuildUi();
  }
}
