import 'package:atletico_app/data/token.dart';
import 'package:dio/dio.dart' show DioError, FormData;
import 'package:atletico_app/endpoints/client.dart' show dio;

Future<Token> getToken(String email, String password) async {
  try {
    var response = await dio.post("/token",
        data: FormData.fromMap({"username": email, "password": password, "scope": "me"}));
    return Token.fromJson(response.data);
  } on DioError catch (error) {
    if (error.response.statusCode == 401)
      throw CouldNotObtainTokenError(
          "Could not obtain token from server, either account does not exist or the credentials are wrong.");
    else 
      throw Exception(error.toString());
  }
}

class CouldNotObtainTokenError implements Exception {
  final String message;

  const CouldNotObtainTokenError([this.message = ""]);
}
