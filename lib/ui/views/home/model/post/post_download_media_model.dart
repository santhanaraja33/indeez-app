class PostDownloadMediaModel {
  bool? success;
  String? postId;
  String? resourceType;
  List<MediaFiles>? mediaFiles;

  PostDownloadMediaModel(
      {this.success, this.postId, this.resourceType, this.mediaFiles});

  PostDownloadMediaModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    postId = json['postId'];
    resourceType = json['resourceType'];
    if (json['mediaFiles'] != null) {
      mediaFiles = <MediaFiles>[];
      json['mediaFiles'].forEach((v) {
        mediaFiles!.add(new MediaFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['postId'] = this.postId;
    data['resourceType'] = this.resourceType;
    if (this.mediaFiles != null) {
      data['mediaFiles'] = this.mediaFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MediaFiles {
  String? fileName;
  String? mimeType;
  int? index;
  String? status;
  String? mediaUrl;

  MediaFiles(
      {this.fileName, this.mimeType, this.index, this.status, this.mediaUrl});

  MediaFiles.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    mimeType = json['mimeType'];
    index = json['index'];
    status = json['status'];
    mediaUrl = json['mediaUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['mimeType'] = this.mimeType;
    data['index'] = this.index;
    data['status'] = this.status;
    data['mediaUrl'] = this.mediaUrl;
    return data;
  }
}
