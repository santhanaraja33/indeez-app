class PostModel {
  bool? success;
  List<Data>? data;
  Null? lastEvaluatedKey;

  PostModel({this.success, this.data, this.lastEvaluatedKey});

  PostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    lastEvaluatedKey = json['lastEvaluatedKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['lastEvaluatedKey'] = this.lastEvaluatedKey;
    return data;
  }
}

class Data {
  String? content;
  String? privacy;
  String? status;
  String? createdAt;
  int? views;
  String? postId;
  int? commentsCount;
  bool? active;
  int? likesCount;
  List<MediaItems>? mediaItems;
  String? resourceType;
  String? userId;
  String? updatedAt;
  String? posttitle;
  ReactionsCount? reactionsCount;
  int? totalReactions;

  Data(
      {this.content,
      this.privacy,
      this.status,
      this.createdAt,
      this.views,
      this.postId,
      this.commentsCount,
      this.active,
      this.likesCount,
      this.mediaItems,
      this.resourceType,
      this.userId,
      this.updatedAt,
      this.posttitle,
      this.reactionsCount,
      this.totalReactions});

  Data.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    privacy = json['privacy'];
    status = json['status'];
    createdAt = json['createdAt'];
    views = json['views'];
    postId = json['postId'];
    commentsCount = json['commentsCount'];
    active = json['active'];
    likesCount = json['likesCount'];
    if (json['mediaItems'] != null) {
      mediaItems = <MediaItems>[];
      json['mediaItems'].forEach((v) {
        mediaItems!.add(new MediaItems.fromJson(v));
      });
    }
    resourceType = json['resourceType'];
    userId = json['userId'];
    updatedAt = json['updatedAt'];
    posttitle = json['posttitle'];
    reactionsCount = json['reactionsCount'] != null
        ? new ReactionsCount.fromJson(json['reactionsCount'])
        : null;
    totalReactions = json['totalReactions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['privacy'] = this.privacy;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['views'] = this.views;
    data['postId'] = this.postId;
    data['commentsCount'] = this.commentsCount;
    data['active'] = this.active;
    data['likesCount'] = this.likesCount;
    if (this.mediaItems != null) {
      data['mediaItems'] = this.mediaItems!.map((v) => v.toJson()).toList();
    }
    data['resourceType'] = this.resourceType;
    data['userId'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['posttitle'] = this.posttitle;
    if (this.reactionsCount != null) {
      data['reactionsCount'] = this.reactionsCount!.toJson();
    }
    data['totalReactions'] = this.totalReactions;
    return data;
  }
}

class MediaItems {
  int? index;
  String? fileName;
  String? mimeType;
  String? s3Key;
  String? mediaUrl;
  String? status;

  MediaItems(
      {this.index,
      this.fileName,
      this.mimeType,
      this.s3Key,
      this.mediaUrl,
      this.status});

  MediaItems.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    fileName = json['fileName'];
    mimeType = json['mimeType'];
    s3Key = json['s3Key'];
    mediaUrl = json['mediaUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['fileName'] = this.fileName;
    data['mimeType'] = this.mimeType;
    data['s3Key'] = this.s3Key;
    data['mediaUrl'] = this.mediaUrl;
    data['status'] = this.status;
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
