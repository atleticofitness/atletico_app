import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<http.Response> getAppleCredentials(
    AuthorizationCredentialAppleID credentials) async {
  // This is the endpoint that will convert an authorization code obtained
  // via Sign in with Apple into a session in your system
  final signInWithAppleEndpoint = Uri(
    scheme: 'https',
    host: 'flutter-sign-in-with-apple-example.glitch.me',
    path: '/sign_in_with_apple',
    queryParameters: <String, String>{
      'code': credentials.authorizationCode,
      'firstName': credentials.givenName,
      'lastName': credentials.familyName,
      'useBundleId': Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
      if (credentials.state != null) 'state': credentials.state,
    },
  );

  final session = await http.Client().post(
    signInWithAppleEndpoint,
  );
  return session;
}
