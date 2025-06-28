class CreateReactionsModel {
  bool? success;
  String? message;
  CreateReactions? data;

  CreateReactionsModel({this.success, this.message, this.data});

  CreateReactionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new CreateReactions.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CreateReactions {
  String? reactionId;
  String? userId;
  String? postId;
  String? reactionType;
  String? createdAt;

  CreateReactions(
      {this.reactionId,
      this.userId,
      this.postId,
      this.reactionType,
      this.createdAt});

  CreateReactions.fromJson(Map<String, dynamic> json) {
    reactionId = json['reactionId'];
    userId = json['userId'];
    postId = json['postId'];
    reactionType = json['reactionType'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reactionId'] = this.reactionId;
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    data['reactionType'] = this.reactionType;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
