import 'package:atletico_app/authentication/apple_signin.dart';
import 'package:atletico_app/endpoints/login.dart';
import 'package:atletico_app/models/token.dart';
import 'package:atletico_app/models/users.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:hive/hive.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserRepository {
  final GoogleSignIn googleSignIn;
  final FacebookLogin facebookSignIn;
  final AppleSignIn appleSignIn;

  UserRepository(
      {
      GoogleSignIn googleSignin,
      FacebookLogin facebookSignIn,
      SignInWithApple appleSignIn})
      : googleSignIn = googleSignin ?? GoogleSignIn(),
        facebookSignIn = facebookSignIn ?? FacebookLogin(),
        appleSignIn = appleSignIn ??
            AppleSignIn(
                clientId: appleSignInClientId,
                redirectUri: '$localAtleticoURL/login/sign-in-with-apple');

  Future<Token> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    Token token = await verifyGoogleToken(idToken: googleAuth.idToken);
    _storeToken(token);
    localToken = token;
    return token;
  }

  Future<Token> signInWithApple() async {
    Token token = await appleSignIn.logIn([
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
    ]);
    _storeToken(token);
    localToken = token;
    return token;
  }

  Future<Token> signInWithCredentials(String email, String password) async {
    Token token = await getToken(email: email, password: password);
    var box = Hive.box('user_information');
    bool rememberMe = box.get('remember_me', defaultValue: false);
    if (rememberMe)
      _storeToken(token);
    localToken = token;
    return token;
  }


  Future<User> signInWithFacebook() async {
    final facebookAuth = await facebookSignIn
        .logIn(['public_profile', 'user_birthday', 'email']);
    switch (facebookAuth.status) {
      case FacebookLoginStatus.loggedIn:

        break;
      case FacebookLoginStatus.cancelledByUser:
        return null;
        break;
      case FacebookLoginStatus.error:
        return null;
        break;
    }
    return null;
  }

  Future<void> signOut() async {
    var box = await Hive.openBox('token');
    box.clear();
    localToken = null;
    return Future.wait([
      googleSignIn.signOut(),
      facebookSignIn.logOut()
    ]);
  }


  void _storeToken(Token token) async {
    var box = await Hive.openBox('token');
    box.add(token);
  }

  factory UserRepository.users() {
    return UserRepository();
  }
}
