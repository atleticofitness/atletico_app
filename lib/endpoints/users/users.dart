import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;

@jsonSerializable
class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String birthDate;
  final bool isActive;
  final String createdDate;
  final String lastLoginDate;
  User(
      {this.id,
      this.email,
      this.username,
      this.password,
      this.firstName,
      this.lastName,
      this.birthDate,
      this.isActive,
      this.createdDate,
      this.lastLoginDate});
}
