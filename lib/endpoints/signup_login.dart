import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:atletico_app/util/constants.dart';

var client = http.Client();



Future<bool> checkIfEmailExists(String email) async {
  var response = await client.post("$atleticoURL/registration/check-email", body: {"email": email});
  bool found = false;
  if (response.statusCode == 200) {
    var body = json.decode(response.body);
    found = body["valid_email"];
  } else {
    throw EmailNotFoindException("There was an issue checking if the email existed.");
  }
  return found;
}

Future<bool> sendSignUpInfomation(Set data) async {
  return false;
}

class EmailNotFoindException implements Exception {

  final String message;

  const EmailNotFoindException([this.message = ""]);
}