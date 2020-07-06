import 'dart:async';
import 'package:atletico_app/data/users.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper;
import 'package:atletico_app/endpoints/client.dart'
    show dio, serializeOption, deserializeOption;

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

class EmailNotFoundException implements Exception {
  final String message;

  const EmailNotFoundException([this.message = ""]);
}

class AccountNotCreatedException implements Exception {
  final String message;

  const AccountNotCreatedException([this.message = ""]);
}
