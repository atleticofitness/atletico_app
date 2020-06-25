import 'dart:async';
import 'package:atletico_app/endpoints/users/users.dart';
import 'package:http/http.dart' as http;
import 'package:atletico_app/util/constants.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper;

var client = http.Client();

Future<bool> checkIfEmailExists(String email) async {
  var response = await client.post("$atleticoURL/registration/check-email",
      body: JsonMapper.toJson({"email": email}));
  bool found = false;
  if (response.statusCode == 200) {
    var body = JsonMapper.fromJson<Map<String, dynamic>>(response.body);
    found = body["valid_email"];
  } else {
    throw EmailNotFoundException(
        "There was an issue checking if the email existed.");
  }
  return found;
}

Future<User> sendSignUpInfomation(User user) async {
  var response = await client.post("$atleticoURL/registration/new-user",
      body: JsonMapper.toJson(user));
  User newUser;
  if (response.statusCode == 200) {
    newUser = JsonMapper.fromJson<User>(response.body);
  } else {
    throw AccountNotCreatedException("Could not create the user.");
  }
  return newUser;
}

class EmailNotFoundException implements Exception {
  final String message;

  const EmailNotFoundException([this.message = ""]);
}

class AccountNotCreatedException implements Exception {
  final String message;

  const AccountNotCreatedException([this.message = ""]);
}
