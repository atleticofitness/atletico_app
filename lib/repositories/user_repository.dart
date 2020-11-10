import 'package:atletico_app/authentication/apple_signin.dart';
import 'package:atletico_app/models/token.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:hive/hive.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserRepository {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FacebookLogin facebookSignIn;
  final AppleSignIn appleSignIn;

  UserRepository(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignin,
      FacebookLogin facebookSignIn,
      SignInWithApple appleSignIn})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        googleSignIn = googleSignin ?? GoogleSignIn(),
        facebookSignIn = facebookSignIn ?? FacebookLogin(),
        appleSignIn = appleSignIn ??
            AppleSignIn(
                clientId: appleSignInClientId,
                redirectUri: '$localAtleticoURL/login/sign-in-with-apple');

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    _handleSignInCredentials(credentials);
    Token token = Token(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
        providerId: credentials.providerId);
    token.save();
    return firebaseAuth.currentUser;
  }

  Future<User> signInWithFacebook() async {
    final facebookAuth = await facebookSignIn
        .logIn(['public_profile', 'user_birthday', 'email']);
    switch (facebookAuth.status) {
      case FacebookLoginStatus.loggedIn:
        String accessToken = facebookAuth.accessToken.token;
        final AuthCredential credentials =
            FacebookAuthProvider.credential(accessToken);
        _handleSignInCredentials(credentials);
        Token token =
            Token(accessToken: accessToken, providerId: credentials.providerId);
        token.save();
        break;
      case FacebookLoginStatus.cancelledByUser:
        return null;
        break;
      case FacebookLoginStatus.error:
        return null;
        break;
    }
    return firebaseAuth.currentUser;
  }

  Future<User> signInWithApple() async {
    Token appleAuth = await appleSignIn.logIn([
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
    ]);
    final OAuthCredential credentials = OAuthProvider('apple.com').credential(
        accessToken: appleAuth.accessToken, idToken: appleAuth.idToken);
    _handleSignInCredentials(credentials);
    appleAuth.save();
    return firebaseAuth.currentUser;
  }

  Future<String> signInWithCredentials(String email, String password) async {
    try {
      UserCredential userCredentials =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var box = Hive.box('user_information');
      bool rememberMe = box.get('remember_me', defaultValue: false);
      if (rememberMe) {
        Token token = Token(
            accessToken: userCredentials.credential.token.toString(),
            providerId: userCredentials.credential.providerId);
        token.save();
      }
    } on FirebaseAuthException catch (fbError) {
      return fbError.code;
    }
    return null;
  }

  Future<String> signUpAndLogin({String email, String password}) async {
    try {
      UserCredential userCredentials =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _handleSignInCredentials(userCredentials.credential);
    } on FirebaseAuthException catch (fbError) {
      return fbError.code;
    }
    return null;
  }

  Future<void> signOut() async {
    return Future.wait([
      firebaseAuth.signOut(),
      googleSignIn.signOut(),
      facebookSignIn.logOut(),
      appleSignIn.logOut()
    ]);
  }

  bool isSignedIn() {
    return firebaseAuth.currentUser != null;
  }

  User getUser() {
    return firebaseAuth.currentUser;
  }

  void _handleSignInCredentials(AuthCredential credential) async {
    try {
      await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (fbError) {
      if (fbError.code == "account-exists-with-different-credential")
        firebaseAuth.currentUser.linkWithCredential(fbError.credential);
      print(fbError.code);
    }
  }

  factory UserRepository.users() {
    return UserRepository();
  }
}
