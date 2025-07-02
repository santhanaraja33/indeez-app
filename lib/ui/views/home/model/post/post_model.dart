class PostModel {
  bool? success;
  List<Data>? data;
  LastEvaluatedKey? lastEvaluatedKey;

  PostModel({this.success, this.data, this.lastEvaluatedKey});

  PostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    lastEvaluatedKey = json['lastEvaluatedKey'] != null
        ? new LastEvaluatedKey.fromJson(json['lastEvaluatedKey'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.lastEvaluatedKey != null) {
      data['lastEvaluatedKey'] = this.lastEvaluatedKey!.toJson();
    }
    return data;
  }
}

class Data {
  int? commentsCount;
  String? content;
  int? likesCount;
  bool? active;
  String? resourceType;
  String? privacy;
  String? userId;
  String? status;
  String? posttitle;
  String? createdAt;
  int? views;
  String? postId;
  ReactionsCount? reactionsCount;
  int? totalReactions;
  List<MediaItems>? mediaItems;
  String? updatedAt;

  Data(
      {this.commentsCount,
      this.content,
      this.likesCount,
      this.active,
      this.resourceType,
      this.privacy,
      this.userId,
      this.status,
      this.posttitle,
      this.createdAt,
      this.views,
      this.postId,
      this.reactionsCount,
      this.totalReactions,
      this.mediaItems,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    commentsCount = json['commentsCount'];
    content = json['content'];
    likesCount = json['likesCount'];
    active = json['active'];
    resourceType = json['resourceType'];
    privacy = json['privacy'];
    userId = json['userId'];
    status = json['status'];
    posttitle = json['posttitle'];
    createdAt = json['createdAt'];
    views = json['views'];
    postId = json['postId'];
    reactionsCount = json['reactionsCount'] != null
        ? new ReactionsCount.fromJson(json['reactionsCount'])
        : null;
    totalReactions = json['totalReactions'];
    if (json['mediaItems'] != null) {
      mediaItems = <MediaItems>[];
      json['mediaItems'].forEach((v) {
        mediaItems!.add(new MediaItems.fromJson(v));
      });
    }
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentsCount'] = this.commentsCount;
    data['content'] = this.content;
    data['likesCount'] = this.likesCount;
    data['active'] = this.active;
    data['resourceType'] = this.resourceType;
    data['privacy'] = this.privacy;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['posttitle'] = this.posttitle;
    data['createdAt'] = this.createdAt;
    data['views'] = this.views;
    data['postId'] = this.postId;
    if (this.reactionsCount != null) {
      data['reactionsCount'] = this.reactionsCount!.toJson();
    }
    data['totalReactions'] = this.totalReactions;
    if (this.mediaItems != null) {
      data['mediaItems'] = this.mediaItems!.map((v) => v.toJson()).toList();
    }
    data['updatedAt'] = this.updatedAt;
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

class LastEvaluatedKey {
  String? postId;

  LastEvaluatedKey({this.postId});

  LastEvaluatedKey.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    return data;
  }
}
