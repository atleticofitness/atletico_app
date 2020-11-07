import 'package:atletico_app/endpoints/login.dart';
import 'package:atletico_app/models/token.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignIn {
  final String clientID;
  final String redirectUri;

  const AppleSignIn({this.clientID, this.redirectUri})
      : assert(clientID != null),
        assert(redirectUri != null);

  Future<Token> logIn(List<AppleIDAuthorizationScopes> scopes) async {
    final AuthorizationCredentialAppleID request =
        await SignInWithApple.getAppleIDCredential(
      scopes: scopes,
      webAuthenticationOptions: WebAuthenticationOptions(
          clientId: this.clientID, redirectUri: Uri.parse(this.redirectUri)),
    );

    Token appleToken = await getAppleCredentials(request);
    return appleToken;
  }

  Future<void> logOut() async {}
}
