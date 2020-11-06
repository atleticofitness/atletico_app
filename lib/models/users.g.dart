// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    email: json['email'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    birthDate: json['birth_date'] as String,
    isActive: json['is_active'] as bool,
    createdDate: json['created_date'] as String,
    lastLoginDate: json['last_login_date'] as String,
    emailVerified: json['email_verified'] as bool,
    appleSubscriberID: json['apple_subscriber_i_d'] as String,
    isPrivateEmail: json['is_private_email'] as bool,
    realAppleUserStatus: json['real_apple_user_status'] as int,
    googleSubscriberID: json['google_subscriber_i_d'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'birth_date': instance.birthDate,
      'is_active': instance.isActive,
      'created_date': instance.createdDate,
      'last_login_date': instance.lastLoginDate,
      'email_verified': instance.emailVerified,
      'apple_subscriber_i_d': instance.appleSubscriberID,
      'is_private_email': instance.isPrivateEmail,
      'real_apple_user_status': instance.realAppleUserStatus,
      'google_subscriber_i_d': instance.googleSubscriberID,
    };
