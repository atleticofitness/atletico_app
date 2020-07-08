import 'dart:async';
import 'package:atletico_app/data/token.dart';
import 'package:atletico_app/data/users.dart';
import 'package:atletico_app/endpoints/client.dart' show dio;
import 'package:dio/dio.dart' show DioError, Options;

Future<User> getCurrentUser(Token token) async {
  try {
    var response = await dio.get("/users/me/", options: Options(headers: token.makeHeader()));
    return User.fromJson(response.data);
  } on DioError catch (error) {
    print(error.response.headers);
    print(error.response.data);
    throw CurrentUserNotFoundException(error.toString());
  }
}

class CurrentUserNotFoundException implements Exception {
  final String message;

  const CurrentUserNotFoundException([this.message = ""]);
}
