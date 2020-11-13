import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'token.g.dart';

@HiveType()
@JsonSerializable(fieldRename: FieldRename.snake)
class Token extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final String tokenType;
  @HiveField(2)
  final String idToken;
  @HiveField(3)
  final String expiresIn;
  @HiveField(4)
  final String providerId;

  Token(
      {this.accessToken,
      this.tokenType,
      this.idToken,
      this.expiresIn,
      this.providerId});
  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
  Map<String, dynamic> makeHeader() =>
      {"Authorization": "$tokenType $accessToken"};

  @override
  List<Object> get props => [accessToken, tokenType, idToken, expiresIn];

  bool hasToken() {
    return Hive.box('user_information').containsKey('token_data');
  }

  @override
  String toString() =>
      'Token accessToken: $accessToken tokenType: $tokenType idToken: $idToken expiresIn: $expiresIn providerId: $providerId';
}
