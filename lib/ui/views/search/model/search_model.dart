class SearchModel {
  String? image;
  String? title;
  String? subTitle;

  SearchModel({this.image, this.title, this.subTitle});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["subTitle"] is String) {
      subTitle = json["subTitle"];
    }
  }

  static List<SearchModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(SearchModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> tempData = <String, dynamic>{};
    tempData["image"] = image;
    tempData["title"] = title;
    tempData["subTitle"] = subTitle;
    return tempData;
  }
}
