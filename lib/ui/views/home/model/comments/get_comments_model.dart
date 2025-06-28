class GetCommentsModel {
  bool? success;
  List<GetComments>? data;

  GetCommentsModel({this.success, this.data});

  GetCommentsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <GetComments>[];
      json['data'].forEach((v) {
        data!.add(new GetComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetComments {
  int? likesCount;
  int? repliesCount;
  String? commentId;
  String? userId;
  String? status;
  String? commentText;
  String? createdAt;
  String? postId;
  User? user;
  List<Replies>? replies;

  GetComments(
      {this.likesCount,
      this.repliesCount,
      this.commentId,
      this.userId,
      this.status,
      this.commentText,
      this.createdAt,
      this.postId,
      this.user,
      this.replies});

  GetComments.fromJson(Map<String, dynamic> json) {
    likesCount = json['likesCount'];
    repliesCount = json['repliesCount'];
    commentId = json['commentId'];
    userId = json['userId'];
    status = json['status'];
    commentText = json['commentText'];
    createdAt = json['createdAt'];
    postId = json['postId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likesCount'] = this.likesCount;
    data['repliesCount'] = this.repliesCount;
    data['commentId'] = this.commentId;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['commentText'] = this.commentText;
    data['createdAt'] = this.createdAt;
    data['postId'] = this.postId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? avatarUrl;
  String? email;
  String? firstName;
  String? lastName;
  String? userId;

  User(
      {this.avatarUrl, this.email, this.firstName, this.lastName, this.userId});

  User.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatarUrl'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarUrl'] = this.avatarUrl;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userId'] = this.userId;
    return data;
  }
}

class Replies {
  int? likesCount;
  int? repliesCount;
  String? commentId;
  String? parentCommentId;
  String? userId;
  String? status;
  String? commentText;
  String? createdAt;
  String? postId;
  User? user;

  Replies(
      {this.likesCount,
      this.repliesCount,
      this.commentId,
      this.parentCommentId,
      this.userId,
      this.status,
      this.commentText,
      this.createdAt,
      this.postId,
      this.user});

  Replies.fromJson(Map<String, dynamic> json) {
    likesCount = json['likesCount'];
    repliesCount = json['repliesCount'];
    commentId = json['commentId'];
    parentCommentId = json['parentCommentId'];
    userId = json['userId'];
    status = json['status'];
    commentText = json['commentText'];
    createdAt = json['createdAt'];
    postId = json['postId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likesCount'] = this.likesCount;
    data['repliesCount'] = this.repliesCount;
    data['commentId'] = this.commentId;
    data['parentCommentId'] = this.parentCommentId;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['commentText'] = this.commentText;
    data['createdAt'] = this.createdAt;
    data['postId'] = this.postId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
