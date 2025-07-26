class HomefeedPublicPostModel {
  bool? success;
  List<PublicPostData>? data;
  Pagination? pagination;

  HomefeedPublicPostModel({this.success, this.data, this.pagination});

  HomefeedPublicPostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PublicPostData>[];
      json['data'].forEach((v) {
        data!.add(new PublicPostData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class PublicPostData {
  int? commentsCount;
  String? content;
  bool? active;
  List<MediaItems>? mediaItems;
  String? resourceType;
  String? privacy;
  String? userId;
  String? status;
  String? posttitle;
  int? views;
  String? createdAt;
  String? postId;
  ReactionsCount? reactionsCount;
  int? totalReactions;
  PostedBy? postedBy;
  String? updatedAt;

  bool isImageSelected = false;

  PublicPostData(
      {this.commentsCount,
      this.content,
      this.active,
      this.mediaItems,
      this.resourceType,
      this.privacy,
      this.userId,
      this.status,
      this.posttitle,
      this.views,
      this.createdAt,
      this.postId,
      this.reactionsCount,
      this.totalReactions,
      this.postedBy,
      this.updatedAt});

  PublicPostData.fromJson(Map<String, dynamic> json) {
    commentsCount = json['commentsCount'];
    content = json['content'];
    active = json['active'];
    if (json['mediaItems'] != null) {
      mediaItems = <MediaItems>[];
      json['mediaItems'].forEach((v) {
        mediaItems!.add(new MediaItems.fromJson(v));
      });
    }
    resourceType = json['resourceType'];
    privacy = json['privacy'];
    userId = json['userId'];
    status = json['status'];
    posttitle = json['posttitle'];
    views = json['views'];
    createdAt = json['createdAt'];
    postId = json['postId'];
    reactionsCount = json['reactionsCount'] != null
        ? new ReactionsCount.fromJson(json['reactionsCount'])
        : null;
    totalReactions = json['totalReactions'];
    postedBy = json['postedBy'] != null
        ? new PostedBy.fromJson(json['postedBy'])
        : null;
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentsCount'] = this.commentsCount;
    data['content'] = this.content;
    data['active'] = this.active;
    if (this.mediaItems != null) {
      data['mediaItems'] = this.mediaItems!.map((v) => v.toJson()).toList();
    }
    data['resourceType'] = this.resourceType;
    data['privacy'] = this.privacy;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['posttitle'] = this.posttitle;
    data['views'] = this.views;
    data['createdAt'] = this.createdAt;
    data['postId'] = this.postId;
    if (this.reactionsCount != null) {
      data['reactionsCount'] = this.reactionsCount!.toJson();
    }
    data['totalReactions'] = this.totalReactions;
    if (this.postedBy != null) {
      data['postedBy'] = this.postedBy!.toJson();
    }
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class MediaItems {
  String? playlistId;
  String? description;
  int? likesCount;
  String? title;
  String? coverImageUrl;
  int? tracks;
  String? videoId;
  String? fileName;
  String? mimeType;
  String? s3Key;
  String? mediaUrl;
  String? audioId;
  int? index;
  String? imageId;
  String? status;

  MediaItems(
      {this.playlistId,
      this.description,
      this.likesCount,
      this.title,
      this.coverImageUrl,
      this.tracks,
      this.videoId,
      this.fileName,
      this.mimeType,
      this.s3Key,
      this.mediaUrl,
      this.audioId,
      this.index,
      this.imageId,
      this.status});

  MediaItems.fromJson(Map<String, dynamic> json) {
    playlistId = json['playlistId'];
    description = json['description'];
    likesCount = json['likesCount'];
    title = json['title'];
    coverImageUrl = json['coverImageUrl'];
    tracks = json['tracks'];
    videoId = json['videoId'];
    fileName = json['fileName'];
    mimeType = json['mimeType'];
    s3Key = json['s3Key'];
    mediaUrl = json['mediaUrl'];
    audioId = json['audioId'];
    index = json['index'];
    imageId = json['imageId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlistId'] = this.playlistId;
    data['description'] = this.description;
    data['likesCount'] = this.likesCount;
    data['title'] = this.title;
    data['coverImageUrl'] = this.coverImageUrl;
    data['tracks'] = this.tracks;
    data['videoId'] = this.videoId;
    data['fileName'] = this.fileName;
    data['mimeType'] = this.mimeType;
    data['s3Key'] = this.s3Key;
    data['mediaUrl'] = this.mediaUrl;
    data['audioId'] = this.audioId;
    data['index'] = this.index;
    data['imageId'] = this.imageId;
    data['status'] = this.status;
    return data;
  }
}

class ReactionsCount {
  Map<String, int> counts = {};

  ReactionsCount({Map<String, int>? counts}) {
    if (counts != null) {
      this.counts = counts;
    }
  }

  ReactionsCount.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      if (value is int) {
        counts[key] = value;
      }
    });
  }

  Map<String, dynamic> toJson() {
    return counts;
  }
}

class PostedBy {
  String? userId;
  String? firstName;
  String? lastName;
  String? avatarUrl;
  String? email;
  String? userType;

  PostedBy(
      {this.userId,
      this.firstName,
      this.lastName,
      this.avatarUrl,
      this.email,
      this.userType});

  PostedBy.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    avatarUrl = json['avatarUrl'];
    email = json['email'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['avatarUrl'] = this.avatarUrl;
    data['email'] = this.email;
    data['userType'] = this.userType;
    return data;
  }
}

class Pagination {
  int? totalCount;
  int? totalPages;
  int? currentPage;
  int? pageSize;
  bool? hasMore;
  Null? lastEvaluatedKey;

  Pagination(
      {this.totalCount,
      this.totalPages,
      this.currentPage,
      this.pageSize,
      this.hasMore,
      this.lastEvaluatedKey});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    hasMore = json['hasMore'];
    lastEvaluatedKey = json['lastEvaluatedKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    data['pageSize'] = this.pageSize;
    data['hasMore'] = this.hasMore;
    data['lastEvaluatedKey'] = this.lastEvaluatedKey;
    return data;
  }
}
