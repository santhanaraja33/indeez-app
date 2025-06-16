

class PasswordModel {
	AuthenticationResult? authenticationResult;
	ChallengeParameters? challengeParameters;

	PasswordModel({this.authenticationResult, this.challengeParameters});

	PasswordModel.fromJson(Map<String, dynamic> json) {
		authenticationResult = json['AuthenticationResult'] != null ? AuthenticationResult.fromJson(json['AuthenticationResult']) : null;
		challengeParameters = json['ChallengeParameters'] != null ?  ChallengeParameters.fromJson(json['ChallengeParameters']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		if (this.authenticationResult != null) {
      data['AuthenticationResult'] = this.authenticationResult!.toJson();
    }
		if (this.challengeParameters != null) {
      data['ChallengeParameters'] = this.challengeParameters!.toJson();
    }
		return data;
	}
}

class AuthenticationResult {
	String? accessToken;
	int? expiresIn;
	String? idToken;
	String? refreshToken;
	String? tokenType;

	AuthenticationResult({this.accessToken, this.expiresIn, this.idToken, this.refreshToken, this.tokenType});

	AuthenticationResult.fromJson(Map<String, dynamic> json) {
		accessToken = json['AccessToken'];
		expiresIn = json['ExpiresIn'];
		idToken = json['IdToken'];
		refreshToken = json['RefreshToken'];
		tokenType = json['TokenType'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['AccessToken'] = this.accessToken;
		data['ExpiresIn'] = this.expiresIn;
		data['IdToken'] = this.idToken;
		data['RefreshToken'] = this.refreshToken;
		data['TokenType'] = this.tokenType;
		return data;
	}
}

class ChallengeParameters {


	ChallengeParameters({});

	ChallengeParameters.fromJson(Map<String, dynamic> json) {
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		return data;
	}
}