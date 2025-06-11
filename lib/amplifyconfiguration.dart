const amplifyconfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "IdentityManager": {
          "Default": {}
        },

        "CognitoUserPool": {
          "Default": {
            "PoolId": "us-west-2_yQAnVLeIR",
            "AppClientId": "gcdvf03t4358m5kvu1ckrkd9g",
            "Region": "us-west-2"
          }
        },
       "Auth": {
          "Default": {
            "authenticationFlowType": "USER_SRP_AUTH",
            "usernameAttributes": ["email"],
            "signupAttributes": [
              "email", "name"
             ],
            "passwordProtectionSettings": {
                "passwordPolicyMinLength": 8,
                "passwordPolicyCharacters": []
            }
          }
        }
      }
    }
  }
}''';

/*
amplify init
amplify add auth
# Select: Email based login
amplify push
*/
