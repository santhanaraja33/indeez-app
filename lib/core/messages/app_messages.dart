class AppMessages {
  //error messages
  static const String headerValueMissed = 'Internal server error';

  static const String mobileNumberEmpty = 'Mobile Number Field is Empty';
  static const String mobileNumberLength = 'Mobile Number max 10 digits';

  static const String otpFieldEmpty = 'OTP Field is Empty';
  static const String otpLength = 'Enter valid OTP';

  static const String errorTitle = 'Error';
  static const String successTitle = 'Success';
  static const String closeTitle = 'Close';

  static const String loginStatusStr = 'loginStatus';
  static const String locationPermissionStatus = 'locationPermission';
  static const String saveGetAddress = 'address';

  static const bool loginStatusBool = true;
  static const String logoutTitleMsg = 'Are you sure\nwant to logout ?';
  static const String logoutBtnMsg = 'Logout';
  static const String cancelBtnMsg = 'Cancel';

  static const String changeTxt = 'Change';
  static const String verifyTxt = 'Verify';
  static const String addTxt = 'Add';

//api response
  static const String refreshToken = 'refreshToken';
  static const String token = 'token';
  static const String contactNo = 'contactNo';

  static const String otpSuccessMsg =
      'Verification code sent to mobile number.';
  static const String otpErrorMsg = 'Contact information is missing.';
  static const String invalidOtp = 'Invalid or expired OTP. Please try again.';
  static const String otpVerification = 'Verification already completed.';
}
