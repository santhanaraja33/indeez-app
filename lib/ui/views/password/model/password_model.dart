class PasswordModel {
  final AuthenticationResult authenticationResult;
  final Map<String, dynamic> challengeParameters;

  PasswordModel({
    required this.authenticationResult,
    required this.challengeParameters,
  });

  factory PasswordModel.fromJson(Map<String, dynamic> json) {
    return PasswordModel(
      authenticationResult:
          AuthenticationResult.fromJson(json['AuthenticationResult']),
      challengeParameters: json['ChallengeParameters'] ?? {},
    );
  }
}

class AuthenticationResult {
  final String accessToken;
  final int expiresIn;
  final String idToken;
  final String refreshToken;
  final String tokenType;

  AuthenticationResult({
    required this.accessToken,
    required this.expiresIn,
    required this.idToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory AuthenticationResult.fromJson(Map<String, dynamic> json) {
    return AuthenticationResult(
      accessToken: json['AccessToken'] ?? '',
      expiresIn: json['ExpiresIn'] ?? 0,
      idToken: json['IdToken'] ?? '',
      refreshToken: json['RefreshToken'] ?? '',
      tokenType: json['TokenType'] ?? '',
    );
  }
}
