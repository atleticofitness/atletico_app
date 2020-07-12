import 'dart:async';
import 'package:atletico_app/data/users.dart';
import 'package:atletico_app/endpoints/client.dart' show dio;

Future<bool> checkIfEmailExists(String email) async {
  var response =
      await dio.post("/registration/check-email", data: {"email": email});
  if (response.statusCode == 200) {
    return response.data["validEmail"];
  }
  throw EmailNotFoundException(
      "There was an issue checking if the email existed.");
}

Future<bool> sendRegistrationInfomation(User user) async {
  var response = await dio.post("/registration/new-user", data: user.toJson());
  if (response.statusCode == 200) return true;
  if (response.statusCode == 400) return false;
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
