class PostUpdateModel {
  bool? success;
  String? message;
  String? postId;
  UpdatedPost? updatedPost;
  List<UploadUrls>? uploadUrls;

  PostUpdateModel(
      {this.success,
      this.message,
      this.postId,
      this.updatedPost,
      this.uploadUrls});

  PostUpdateModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    postId = json['postId'];
    updatedPost = json['updatedPost'] != null
        ? new UpdatedPost.fromJson(json['updatedPost'])
        : null;
    if (json['uploadUrls'] != null) {
      uploadUrls = <UploadUrls>[];
      json['uploadUrls'].forEach((v) {
        uploadUrls!.add(new UploadUrls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['postId'] = this.postId;
    if (this.updatedPost != null) {
      data['updatedPost'] = this.updatedPost!.toJson();
    }
    if (this.uploadUrls != null) {
      data['uploadUrls'] = this.uploadUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpdatedPost {
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

  UpdatedPost(
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
      this.posttitle});

  UpdatedPost.fromJson(Map<String, dynamic> json) {
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

class UploadUrls {
  String? fileName;
  String? uploadUrl;

  UploadUrls({this.fileName, this.uploadUrl});

  UploadUrls.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    uploadUrl = json['uploadUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['uploadUrl'] = this.uploadUrl;
    return data;
  }
}
