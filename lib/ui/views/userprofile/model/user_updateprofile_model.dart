class UserUpdateprofileModel {
  String? message;
  UpdatedAttributes? updatedAttributes;

  UserUpdateprofileModel({this.message, this.updatedAttributes});

  UserUpdateprofileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    updatedAttributes = json['updatedAttributes'] != null
        ? new UpdatedAttributes.fromJson(json['updatedAttributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.updatedAttributes != null) {
      data['updatedAttributes'] = this.updatedAttributes!.toJson();
    }
    return data;
  }
}

class UpdatedAttributes {
  bool? acceptPrivacyPolicy;
  String? userType;
  String? bio;
  String? lastName;
  String? avatarUrl;
  String? createdAt;
  String? email;
  String? firstName;
  String? updatedAt;
  String? userId;
  bool? acceptTerms;
  String? phone;
  String? zipCode;

  UpdatedAttributes(
      {this.acceptPrivacyPolicy,
      this.userType,
      this.bio,
      this.lastName,
      this.avatarUrl,
      this.createdAt,
      this.email,
      this.firstName,
      this.updatedAt,
      this.userId,
      this.acceptTerms,
      this.phone,
      this.zipCode});

  UpdatedAttributes.fromJson(Map<String, dynamic> json) {
    acceptPrivacyPolicy = json['acceptPrivacyPolicy'];
    userType = json['userType'];
    bio = json['bio'];
    lastName = json['lastName'];
    avatarUrl = json['avatarUrl'];
    createdAt = json['createdAt'];
    email = json['email'];
    firstName = json['firstName'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    acceptTerms = json['acceptTerms'];
    phone = json['phone'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acceptPrivacyPolicy'] = this.acceptPrivacyPolicy;
    data['userType'] = this.userType;
    data['bio'] = this.bio;
    data['lastName'] = this.lastName;
    data['avatarUrl'] = this.avatarUrl;
    data['createdAt'] = this.createdAt;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    data['acceptTerms'] = this.acceptTerms;
    data['phone'] = this.phone;
    data['zipCode'] = this.zipCode;
    return data;
  }
}
