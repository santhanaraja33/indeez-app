class GetFollowersListModel {
  List<Followers>? followers;

  GetFollowersListModel({this.followers});

  GetFollowersListModel.fromJson(Map<String, dynamic> json) {
    if (json['followers'] != null) {
      followers = <Followers>[];
      json['followers'].forEach((v) {
        followers!.add(new Followers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Followers {
  String? avatarUrl;
  String? email;
  String? firstName;
  String? lastName;
  String? userId;

  Followers(
      {this.avatarUrl, this.email, this.firstName, this.lastName, this.userId});

  Followers.fromJson(Map<String, dynamic> json) {
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
