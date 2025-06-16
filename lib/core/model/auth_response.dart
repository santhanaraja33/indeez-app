class AuthResponse {
  final AuthenticationResult authenticationResult;
  final Map<String, dynamic> challengeParameters;

  AuthResponse({
    required this.authenticationResult,
    required this.challengeParameters,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
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
      accessToken: json['AccessToken'],
      expiresIn: json['ExpiresIn'],
      idToken: json['IdToken'],
      refreshToken: json['RefreshToken'],
      tokenType: json['TokenType'],
    );
  }
}
