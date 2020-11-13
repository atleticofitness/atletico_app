import 'package:atletico_app/endpoints/login.dart';
import 'package:atletico_app/models/token.dart';
import 'package:atletico_app/routes/router.gr.dart';
import 'package:hive/hive.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignIn {
  final String clientId;
  final String redirectUri;

  const AppleSignIn({this.clientId, this.redirectUri})
      : assert(clientId != null),
        assert(redirectUri != null);

  Future<Token> logIn(List<AppleIDAuthorizationScopes> scopes) async {
    final AuthorizationCredentialAppleID request =
        await SignInWithApple.getAppleIDCredential(
      scopes: scopes,
      webAuthenticationOptions: WebAuthenticationOptions(
          clientId: this.clientId, redirectUri: Uri.parse(this.redirectUri)),
    );

    Token appleToken = await getAppleCredentials(request);
    return appleToken;
  }

  Future<String> authenticateUserToWidget(String userIdentifier) async {
    CredentialState state =
        await SignInWithApple.getCredentialState(userIdentifier);
    String widgetPage;
    switch (state) {
      case CredentialState.authorized:
        widgetPage = Routes.homePageWidget;
        break;
      case CredentialState.revoked:
        var box = await Hive.openBox('token');
        box.clear();
        widgetPage = Routes.loginWidget;
        break;
      case CredentialState.notFound:
        widgetPage = Routes.loginWidget;
        break;
    }
    return widgetPage;
  }
}
