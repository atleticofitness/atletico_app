import 'dart:io';
import 'package:atletico_app/models/token.dart';
import 'package:dio/dio.dart' show DioError, FormData;
import 'package:atletico_app/endpoints/client.dart' show dio;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:dio/dio.dart' show Response;
import 'package:atletico_app/util/constants.dart';

Future<Token> getToken({String email, String password}) async {
  try {
    var response = await dio.post("/login/token",
        data: FormData.fromMap(
            {"username": email, "password": password, "scope": "me"}));
    return Token.fromJson(response.data);
  } on DioError catch (error) {
    if (error.response.statusCode == 401)
      throw CouldNotObtainTokenError(
          "Could not obtain token from server, either account does not exist or the credentials are wrong.");
    throw Exception(error.toString());
  }
}

class CouldNotObtainTokenError implements Exception {
  final String message;

  const CouldNotObtainTokenError([this.message = ""]);
}

Future<Response> getAppleCredentials(
    AuthorizationCredentialAppleID credentials) async {
  // This is the endpoint that will convert an authorization code obtained
  // via Sign in with Apple into a session in your system
  String url = localAtleticoURL.replaceAll("https://", "");
  url = localAtleticoURL.replaceAll("http://", "");
  final signInWithAppleEndpoint = Uri(
    scheme: 'https',
    host: url,
    path: '/login/sign-in-with-apple-creds',
    queryParameters: <String, String>{
      'code': credentials.authorizationCode,
      'firstName': credentials.givenName,
      'lastName': credentials.familyName,
      'useBundleId': Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
      if (credentials.state != null) 'state': credentials.state,
    },
  );

  final session = await dio.postUri(signInWithAppleEndpoint);
  return session;
}
