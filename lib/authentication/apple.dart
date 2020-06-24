import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:atletico_app/endpoints/authentication/apple.dart';

Widget appleSignIn() {
  return SignInWithAppleButton(
    onPressed: () async {
      final credentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
        webAuthenticationOptions:
            WebAuthenticationOptions(clientId: null, redirectUri: null),
      );
      getAppleCredentials(credentials);
    },
  );
}
