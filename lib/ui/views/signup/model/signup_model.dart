//signup api response model
class SignUpModel {
  String? message;
  String? userId;

  SignUpModel({this.message, this.userId});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userId'] = this.userId;
    return data;
  }
}

//signup api parameters model
class SignupUserInfo {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String zipCode;
  final String password;
  final String userType;
  final String userId;
  final bool acceptPrivacyPolicy;
  SignupUserInfo({required this.firstName, required this.lastName, required this.email, required this.phoneNumber, required this.zipCode, required this.password, required this.userType, required this.userId, required this.acceptPrivacyPolicy});

  // Convert object to Map
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'zipCode': zipCode,
        'password': password,
        'userType': userType,
        'userId': userId,
        'acceptPrivacyPolicy': acceptPrivacyPolicy,
      };

  // Convert Map to object
  factory SignupUserInfo.fromJson(Map<String, dynamic> json) => SignupUserInfo(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        zipCode: json['zipCode'],
        password: json['password'],
        userType: json['userType'],
        userId: json['userId'],
        acceptPrivacyPolicy: json['acceptPrivacyPolicy'],
      );
}