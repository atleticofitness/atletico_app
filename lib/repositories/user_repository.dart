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
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await firebaseAuth.signInWithCredential(credential);
    return firebaseAuth.currentUser;
  }

  Future<User> signInWithFacebook() async {
    final facebookAuth = await facebookSignIn
        .logIn(['public_profile', 'user_birthday', 'email']);
    switch (facebookAuth.status) {
      case FacebookLoginStatus.loggedIn:
        final AuthCredential credential =
            FacebookAuthProvider.credential(facebookAuth.accessToken.token);
        await firebaseAuth.signInWithCredential(credential);
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
    await firebaseAuth.signInWithCredential(credentials);
    return firebaseAuth.currentUser;
  }

  Future<UserCredential> signInWithCredentials(
      String email, String password) async {
    UserCredential credential;
    try {
      credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (fbError) {
      print(fbError);
    }
    return credential;
  }

  Future<void> signUp({String email, String password}) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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
}
