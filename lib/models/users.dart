import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'users.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String birthDate;
  final bool isActive;
  final String createdDate;
  final String lastLoginDate;
  final bool emailVerified;
  final String appleSubscriberID;
  final bool isPrivateEmail;
  final int realAppleUserStatus;
  final String googleSubscriberID;

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
      this.lastLoginDate,
      this.emailVerified,
      this.appleSubscriberID,
      this.isPrivateEmail,
      this.realAppleUserStatus,
      this.googleSubscriberID});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [
        id,
        email,
        username,
        password,
        firstName,
        lastName,
        birthDate,
        isActive,
        createdDate,
        lastLoginDate,
        emailVerified,
        appleSubscriberID,
        isPrivateEmail,
        realAppleUserStatus,
        googleSubscriberID
      ];
}
