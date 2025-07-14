class CreateAudioPostModel {
  bool? success;
  String? message;
  String? postId;
  String? audioId;
  UploadUrls? uploadUrls;
  PostData? postData;

  CreateAudioPostModel(
      {this.success,
      this.message,
      this.postId,
      this.audioId,
      this.uploadUrls,
      this.postData});

  CreateAudioPostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    postId = json['postId'];
    audioId = json['audioId'];
    uploadUrls = json['uploadUrls'] != null
        ? new UploadUrls.fromJson(json['uploadUrls'])
        : null;
    postData = json['postData'] != null
        ? new PostData.fromJson(json['postData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['postId'] = this.postId;
    data['audioId'] = this.audioId;
    if (this.uploadUrls != null) {
      data['uploadUrls'] = this.uploadUrls!.toJson();
    }
    if (this.postData != null) {
      data['postData'] = this.postData!.toJson();
    }
    return data;
  }
}

class UploadUrls {
  Audio? audio;
  Audio? coverImage;

  UploadUrls({this.audio, this.coverImage});

  UploadUrls.fromJson(Map<String, dynamic> json) {
    audio = json['audio'] != null ? new Audio.fromJson(json['audio']) : null;
    coverImage = json['coverImage'] != null
        ? new Audio.fromJson(json['coverImage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.audio != null) {
      data['audio'] = this.audio!.toJson();
    }
    if (this.coverImage != null) {
      data['coverImage'] = this.coverImage!.toJson();
    }
    return data;
  }
}

class Audio {
  String? uploadUrl;
  String? fileName;

  Audio({this.uploadUrl, this.fileName});

  Audio.fromJson(Map<String, dynamic> json) {
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
    data['commentsCount'] = this.commentsCount;
    data['active'] = this.active;
    return data;
  }
}

class MediaItems {
  String? audioId;
  String? fileName;
  String? mimeType;
  String? s3Key;
  String? mediaUrl;
  String? coverImageUrl;

  MediaItems(
      {this.audioId,
      this.fileName,
      this.mimeType,
      this.s3Key,
      this.mediaUrl,
      this.coverImageUrl});

  MediaItems.fromJson(Map<String, dynamic> json) {
    audioId = json['audioId'];
    fileName = json['fileName'];
    mimeType = json['mimeType'];
    s3Key = json['s3Key'];
    mediaUrl = json['mediaUrl'];
    coverImageUrl = json['coverImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audioId'] = this.audioId;
    data['fileName'] = this.fileName;
    data['mimeType'] = this.mimeType;
    data['s3Key'] = this.s3Key;
    data['mediaUrl'] = this.mediaUrl;
    data['coverImageUrl'] = this.coverImageUrl;
    return data;
  }
}
