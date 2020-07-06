import 'dart:async';
import 'package:atletico_app/endpoints/users/users.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, SerializationOptions, DeserializationOptions, CaseStyle;
import 'package:dio/dio.dart';

var dio = Dio(BaseOptions(
  baseUrl: atleticoURL
));
var serializeOption =
    SerializationOptions(indent: '', caseStyle: CaseStyle.Snake);
var deserializeOption = DeserializationOptions(caseStyle: CaseStyle.Camel);

Future<bool> checkIfEmailExists(String email) async {
  var response = await dio.post("/registration/check-email",
      data: JsonMapper.toJson({"email": email}));
  if (response.statusCode == 200) {
    var body = JsonMapper.fromJson<Map<String, dynamic>>(response.data);
    return body["valid_email"];
  }
  throw EmailNotFoundException(
      "There was an issue checking if the email existed.");
}

Future<User> sendSignUpInfomation(User user) async {
  var response = await dio.post("/registration/new-user",
      data: JsonMapper.toJson(user, serializeOption));
  if (response.statusCode == 200) {
    return JsonMapper.fromJson<User>(response.data, deserializeOption);
  }
  throw AccountNotCreatedException("Could not create the user.");
}

Future<String> getToken(String email, String password) async {
  try {
    var response =await dio.post("/token",
        data: FormData.fromMap({"username": email, "password": password}));
    var tokenData = JsonMapper.fromJson<Map<String, dynamic>>(response.data);
    return tokenData["access_token"];
  } on DioError catch (error) {
    if (error.response.statusCode == 401)
      throw CouldNotObtainTokenError("Could not obtain token from server, either account does not exist or the credentials are wrong.");
    else
      throw Exception(error.toString());
  }
}

class EmailNotFoundException implements Exception {
  final String message;

  const EmailNotFoundException([this.message = ""]);
}

class AccountNotCreatedException implements Exception {
  final String message;

  const AccountNotCreatedException([this.message = ""]);
}

class CouldNotObtainTokenError implements Exception {
  final String message;

  const CouldNotObtainTokenError([this.message = ""]);
}
