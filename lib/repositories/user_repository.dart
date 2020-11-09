import 'package:atletico_app/authentication/apple_signin.dart';
import 'package:atletico_app/models/token.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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
                clientID: appleSignInClientID,
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
    return firebaseAuth.currentUser;
  }

  Future<User> signInWithFacebook() async {
    final facebookAuth = await facebookSignIn
        .logIn(['public_profile', 'user_birthday', 'email']);
    switch (facebookAuth.status) {
      case FacebookLoginStatus.loggedIn:
        final AuthCredential credentials =
            FacebookAuthProvider.credential(facebookAuth.accessToken.token);
        _handleSignInCredentials(credentials);
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
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
    return firebaseAuth.currentUser;
  }

  Future<User> signInWithCredentials(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (fbError) {
      print(fbError.code);
    }
    return firebaseAuth.currentUser;
  }

  Future<User> signUp({String email, String password}) async {
    try {
      UserCredential userCredentials =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _handleSignInCredentials(userCredentials.credential);
    } on FirebaseAuthException catch (fbError) {
      print(fbError.code);
    }
    return firebaseAuth.currentUser;
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
    }
  }

  factory UserRepository.users() {
    return UserRepository();
  }
}
