import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
part 'users.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(fieldRename: FieldRename.snake)
class User extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String firstName;
  @HiveField(5)
  final String lastName;
  @HiveField(6)
  final String birthDate;
  @HiveField(7)
  final bool isActive;
  @HiveField(8)
  final String createdDate;
  @HiveField(9)
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
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
