import 'package:music_app/ui/views/notification/model/notification_model.dart';
import 'package:stacked/stacked.dart';

class NotificationViewModel extends BaseViewModel {
  final notificationModel = [
    NotificationModel(
      title: 'Login Success',
      date: '28/11/2024 - 10:40 AM',
      subTitle: 'Your Login Successfully',
    ),
    NotificationModel(
      title: 'App Update',
      date: '28/11/2024 - 12:40 PM',
      subTitle: 'INDEEZ Update for today',
    ),
    NotificationModel(
      title: 'Profile Created',
      date: '21/11/2024 - 11:40 AM',
      subTitle: 'Your Profile Created Successfully',
    ),
  ];
}
