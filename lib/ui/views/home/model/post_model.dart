class Post {
  bool? success;
  List<Data>? data;
  Null lastEvaluatedKey;

  Post({this.success, this.data, this.lastEvaluatedKey});

  Post.fromJson(Map<String, dynamic> json) {
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
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['lastEvaluatedKey'] = lastEvaluatedKey;
    return data;
  }
}

class Data {
  Null content;
  String? fileName;
  String? privacy;
  String? mimeType;
  String? status;
  String? createdAt;
  int? views;
  String? postId;
  int? commentsCount;
  int? likesCount;
  String? resourceType;
  String? userId;
  String? s3Key;

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
      this.likesCount,
      this.resourceType,
      this.userId,
      this.s3Key});

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
    likesCount = json['likesCount'];
    resourceType = json['resourceType'];
    userId = json['userId'];
    s3Key = json['s3Key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = content;
    data['fileName'] = fileName;
    data['privacy'] = privacy;
    data['mimeType'] = mimeType;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['views'] = views;
    data['postId'] = postId;
    data['commentsCount'] = commentsCount;
    data['likesCount'] = likesCount;
    data['resourceType'] = resourceType;
    data['userId'] = userId;
    data['s3Key'] = s3Key;
    return data;
  }
}
