class NotificationModel {
  String? title;
  String? subTitle;
  String? date;

  NotificationModel({this.title, this.subTitle, this.date});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["subTitle"] is String) {
      subTitle = json["subTitle"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
  }

  static List<NotificationModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(NotificationModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> tempData = <String, dynamic>{};
    tempData["title"] = title;
    tempData["subTitle"] = subTitle;
    tempData["date"] = date;
    return tempData;
  }
}
