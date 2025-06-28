class PostbyPostIdModel {
  bool? success;
  Data? data;

  PostbyPostIdModel({this.success, this.data});

  PostbyPostIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? content;
  String? fileName;
  String? privacy;
  String? mimeType;
  String? status;
  String? createdAt;
  int? views;
  String? postId;
  int? commentsCount;
  bool? active;
  int? likesCount;
  String? resourceType;
  String? userId;
  String? posttitle;
  String? mediaUrl;
  String? s3Key;
  ReactionsCount? reactionsCount;
  int? totalReactions;

  Data(
      {this.content,
      this.fileName,
      this.privacy,
      this.mimeType,
      this.status,
      this.createdAt,
      this.views,
      this.postId,
      this.commentsCount,
      this.active,
      this.likesCount,
      this.resourceType,
      this.userId,
      this.posttitle,
      this.mediaUrl,
      this.s3Key,
      this.reactionsCount,
      this.totalReactions});

  Data.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    fileName = json['fileName'];
    privacy = json['privacy'];
    mimeType = json['mimeType'];
    status = json['status'];
    createdAt = json['createdAt'];
    views = json['views'];
    postId = json['postId'];
    commentsCount = json['commentsCount'];
    active = json['active'];
    likesCount = json['likesCount'];
    resourceType = json['resourceType'];
    userId = json['userId'];
    posttitle = json['posttitle'];
    mediaUrl = json['mediaUrl'];
    s3Key = json['s3Key'];
    reactionsCount = json['reactionsCount'] != null
        ? new ReactionsCount.fromJson(json['reactionsCount'])
        : null;
    totalReactions = json['totalReactions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['fileName'] = this.fileName;
    data['privacy'] = this.privacy;
    data['mimeType'] = this.mimeType;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['views'] = this.views;
    data['postId'] = this.postId;
    data['commentsCount'] = this.commentsCount;
    data['active'] = this.active;
    data['likesCount'] = this.likesCount;
    data['resourceType'] = this.resourceType;
    data['userId'] = this.userId;
    data['posttitle'] = this.posttitle;
    data['mediaUrl'] = this.mediaUrl;
    data['s3Key'] = this.s3Key;
    if (this.reactionsCount != null) {
      data['reactionsCount'] = this.reactionsCount!.toJson();
    }
    data['totalReactions'] = this.totalReactions;
    return data;
  }
}

class ReactionsCount {
  int? love;

  ReactionsCount({this.love});

  ReactionsCount.fromJson(Map<String, dynamic> json) {
    love = json['love'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['love'] = this.love;
    return data;
  }
}
