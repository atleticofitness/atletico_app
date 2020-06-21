import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;

@jsonSerializable
class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final bool isActive;
  User(
      {this.id,
      this.email,
      this.username,
      this.password,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.isActive});
}
