import 'dart:async';
import 'package:atletico_app/endpoints/users/users.dart';
import 'package:http/http.dart' as http;
import 'package:atletico_app/util/constants.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, SerializationOptions, DeserializationOptions, CaseStyle;

var client = http.Client();
var serializeOption =
    SerializationOptions(indent: '', caseStyle: CaseStyle.Snake);
var deserializeOption = DeserializationOptions(caseStyle: CaseStyle.Camel);

Future<bool> checkIfEmailExists(String email) async {
  var response = await client.post("$atleticoURL/registration/check-email",
      body: JsonMapper.toJson({"email": email}));
  if (response.statusCode == 200) {
    var body = JsonMapper.fromJson<Map<String, dynamic>>(response.body);
    return body["valid_email"];
  }
  throw EmailNotFoundException(
      "There was an issue checking if the email existed.");
}

Future<User> sendSignUpInfomation(User user) async {
  var response = await client.post("$atleticoURL/registration/new-user",
      body: JsonMapper.toJson(user, serializeOption));
  if (response.statusCode == 200) {
    return JsonMapper.fromJson<User>(response.body, deserializeOption);
  }
  throw AccountNotCreatedException("Could not create the user.");
}

Future<String> getToken(String email, String password) async {
  var response = await client.post("$atleticoURL/token",
      body: JsonMapper.toJson({"username": email, "password": password}));
  if (response.statusCode == 200) {
    var tokenData = JsonMapper.fromJson<Map<String, dynamic>>(response.body);
    return tokenData["access_token"];
  }
  return null;
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
