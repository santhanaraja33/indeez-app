class GetReactionsModel {
  bool? success;
  List<GetReactions>? data;

  GetReactionsModel({this.success, this.data});

  GetReactionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <GetReactions>[];
      json['data'].forEach((v) {
        data!.add(new GetReactions.fromJson(v));
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

class GetReactions {
  String? createdAt;
  String? postId;
  String? reactionId;
  String? reactionType;
  String? userId;
  User? user;

  GetReactions(
      {this.createdAt,
      this.postId,
      this.reactionId,
      this.reactionType,
      this.userId,
      this.user});

  GetReactions.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    postId = json['postId'];
    reactionId = json['reactionId'];
    reactionType = json['reactionType'];
    userId = json['userId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['postId'] = this.postId;
    data['reactionId'] = this.reactionId;
    data['reactionType'] = this.reactionType;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
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
