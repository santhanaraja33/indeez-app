class ParentReplyCommentsModel {
  bool? success;
  String? message;
  Data? data;

  ParentReplyCommentsModel({this.success, this.message, this.data});

  ParentReplyCommentsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? commentId;
  String? postId;
  String? userId;
  String? commentText;
  String? createdAt;
  String? status;
  int? likesCount;
  int? repliesCount;
  String? parentCommentId;

  Data(
      {this.commentId,
      this.postId,
      this.userId,
      this.commentText,
      this.createdAt,
      this.status,
      this.likesCount,
      this.repliesCount,
      this.parentCommentId});

  Data.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    postId = json['postId'];
    userId = json['userId'];
    commentText = json['commentText'];
    createdAt = json['createdAt'];
    status = json['status'];
    likesCount = json['likesCount'];
    repliesCount = json['repliesCount'];
    parentCommentId = json['parentCommentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['postId'] = this.postId;
    data['userId'] = this.userId;
    data['commentText'] = this.commentText;
    data['createdAt'] = this.createdAt;
    data['status'] = this.status;
    data['likesCount'] = this.likesCount;
    data['repliesCount'] = this.repliesCount;
    data['parentCommentId'] = this.parentCommentId;
    return data;
  }
}
