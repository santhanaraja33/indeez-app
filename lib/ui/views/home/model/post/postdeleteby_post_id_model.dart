class PostdeletebyPostIdModel {
  bool? success;
  String? message;
  String? postId;

  PostdeletebyPostIdModel({this.success, this.message, this.postId});

  PostdeletebyPostIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['postId'] = this.postId;
    return data;
  }
}
