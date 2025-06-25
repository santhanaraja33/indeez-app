// class UserprofileModel {
//   List<Users>? users;

//   UserprofileModel({this.users});

//   UserprofileModel.fromJson(Map<String, dynamic> json) {
//     if (json['users'] != null) {
//       users = <Users>[];
//       json['users'].forEach((v) {
//         users!.add(new Users.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.users != null) {
//       data['users'] = this.users!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Users {
//   bool? acceptPrivacyPolicy;
//   String? userType;
//   String? bio;
//   String? lastName;
//   String? avatarUrl;
//   String? createdAt;
//   String? email;
//   String? firstName;
//   String? updatedAt;
//   String? userId;
//   bool? acceptTerms;
//   String? phone;
//   String? zipCode;

//   Users(
//       {this.acceptPrivacyPolicy,
//       this.userType,
//       this.bio,
//       this.lastName,
//       this.avatarUrl,
//       this.createdAt,
//       this.email,
//       this.firstName,
//       this.updatedAt,
//       this.userId,
//       this.acceptTerms,
//       this.phone,
//       this.zipCode});

//   Users.fromJson(Map<String, dynamic> json) {
//     acceptPrivacyPolicy = json['acceptPrivacyPolicy'];
//     userType = json['userType'];
//     bio = json['bio'];
//     lastName = json['lastName'];
//     avatarUrl = json['avatarUrl'];
//     createdAt = json['createdAt'];
//     email = json['email'];
//     firstName = json['firstName'];
//     updatedAt = json['updatedAt'];
//     userId = json['userId'];
//     acceptTerms = json['acceptTerms'];
//     phone = json['phone'];
//     zipCode = json['zipCode'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['acceptPrivacyPolicy'] = this.acceptPrivacyPolicy;
//     data['userType'] = this.userType;
//     data['bio'] = this.bio;
//     data['lastName'] = this.lastName;
//     data['avatarUrl'] = this.avatarUrl;
//     data['createdAt'] = this.createdAt;
//     data['email'] = this.email;
//     data['firstName'] = this.firstName;
//     data['updatedAt'] = this.updatedAt;
//     data['userId'] = this.userId;
//     data['acceptTerms'] = this.acceptTerms;
//     data['phone'] = this.phone;
//     data['zipCode'] = this.zipCode;
//     return data;
//   }
// }
