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
  String? content;
  String? privacy;
  String? status;
  int? views;
  String? createdAt;
  String? postId;
  int? commentsCount;
  bool? active;
  List<MediaItems>? mediaItems;
  String? resourceType;
  String? userId;
  String? updatedAt;
  String? posttitle;
  ReactionsCount? reactionsCount;
  int? totalReactions;

  bool isImageSelected = false;

  PublicPostData(
      {this.content,
      this.privacy,
      this.status,
      this.views,
      this.createdAt,
      this.postId,
      this.commentsCount,
      this.active,
      this.mediaItems,
      this.resourceType,
      this.userId,
      this.updatedAt,
      this.posttitle,
      this.reactionsCount,
      this.totalReactions});

  PublicPostData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    privacy = json['privacy'];
    status = json['status'];
    views = json['views'];
    createdAt = json['createdAt'];
    postId = json['postId'];
    commentsCount = json['commentsCount'];
    active = json['active'];
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
    data['views'] = this.views;
    data['createdAt'] = this.createdAt;
    data['postId'] = this.postId;
    data['commentsCount'] = this.commentsCount;
    data['active'] = this.active;
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

class Pagination {
  int? totalCount;
  int? totalPages;
  int? currentPage;
  int? pageSize;
  bool? hasMore;
  String? lastEvaluatedKey;

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
