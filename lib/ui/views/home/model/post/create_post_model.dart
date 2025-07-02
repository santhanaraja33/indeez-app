class CreatePostModel {
  bool? success;
  String? message;
  String? postId;
  List<MediaUploadUrls>? mediaUploadUrls;
  PostData? postData;

  CreatePostModel(
      {this.success,
      this.message,
      this.postId,
      this.mediaUploadUrls,
      this.postData});

  CreatePostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    postId = json['postId'];
    if (json['mediaUploadUrls'] != null) {
      mediaUploadUrls = <MediaUploadUrls>[];
      json['mediaUploadUrls'].forEach((v) {
        mediaUploadUrls!.add(new MediaUploadUrls.fromJson(v));
      });
    }
    postData = json['postData'] != null
        ? new PostData.fromJson(json['postData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['postId'] = this.postId;
    if (this.mediaUploadUrls != null) {
      data['mediaUploadUrls'] =
          this.mediaUploadUrls!.map((v) => v.toJson()).toList();
    }
    if (this.postData != null) {
      data['postData'] = this.postData!.toJson();
    }
    return data;
  }
}

class MediaUploadUrls {
  String? uploadUrl;
  String? fileName;

  MediaUploadUrls({this.uploadUrl, this.fileName});

  MediaUploadUrls.fromJson(Map<String, dynamic> json) {
    uploadUrl = json['uploadUrl'];
    fileName = json['fileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadUrl'] = this.uploadUrl;
    data['fileName'] = this.fileName;
    return data;
  }
}

class PostData {
  String? postId;
  String? userId;
  String? createdAt;
  String? resourceType;
  String? posttitle;
  String? content;
  List<MediaItems>? mediaItems;
  String? privacy;
  String? status;
  int? views;
  int? likesCount;
  int? commentsCount;
  bool? active;

  PostData(
      {this.postId,
      this.userId,
      this.createdAt,
      this.resourceType,
      this.posttitle,
      this.content,
      this.mediaItems,
      this.privacy,
      this.status,
      this.views,
      this.likesCount,
      this.commentsCount,
      this.active});

  PostData.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    resourceType = json['resourceType'];
    posttitle = json['posttitle'];
    content = json['content'];
    if (json['mediaItems'] != null) {
      mediaItems = <MediaItems>[];
      json['mediaItems'].forEach((v) {
        mediaItems!.add(new MediaItems.fromJson(v));
      });
    }
    privacy = json['privacy'];
    status = json['status'];
    views = json['views'];
    likesCount = json['likesCount'];
    commentsCount = json['commentsCount'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['resourceType'] = this.resourceType;
    data['posttitle'] = this.posttitle;
    data['content'] = this.content;
    if (this.mediaItems != null) {
      data['mediaItems'] = this.mediaItems!.map((v) => v.toJson()).toList();
    }
    data['privacy'] = this.privacy;
    data['status'] = this.status;
    data['views'] = this.views;
    data['likesCount'] = this.likesCount;
    data['commentsCount'] = this.commentsCount;
    data['active'] = this.active;
    return data;
  }
}

class MediaItems {
  String? fileName;
  String? mimeType;
  String? s3Key;
  String? mediaUrl;
  int? index;
  String? status;

  MediaItems(
      {this.fileName,
      this.mimeType,
      this.s3Key,
      this.mediaUrl,
      this.index,
      this.status});

  MediaItems.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    mimeType = json['mimeType'];
    s3Key = json['s3Key'];
    mediaUrl = json['mediaUrl'];
    index = json['index'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['mimeType'] = this.mimeType;
    data['s3Key'] = this.s3Key;
    data['mediaUrl'] = this.mediaUrl;
    data['index'] = this.index;
    data['status'] = this.status;
    return data;
  }
}
