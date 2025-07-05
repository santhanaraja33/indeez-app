class GetUserFollowingListModel {
  List<Following>? following;

  GetUserFollowingListModel({this.following});

  GetUserFollowingListModel.fromJson(Map<String, dynamic> json) {
    if (json['following'] != null) {
      following = <Following>[];
      json['following'].forEach((v) {
        following!.add(new Following.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.following != null) {
      data['following'] = this.following!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Following {
  String? avatarUrl;
  String? email;
  String? firstName;
  String? lastName;
  String? userId;

  Following(
      {this.avatarUrl, this.email, this.firstName, this.lastName, this.userId});

  Following.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatarUrl'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarUrl'] = this.avatarUrl;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userId'] = this.userId;
    return data;
  }
}
