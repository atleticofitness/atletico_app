import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'token.g.dart';

@HiveType(typeId: 0)
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

  factory Token.load() {
    var box = Hive.box('user_information');
    if (!box.containsKey('token_data')) return null;
    Map<String, dynamic> json = box.get('token_data');
    return Token(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        idToken: json['id_token'],
        expiresIn: json['expires_in'],
        providerId: json['provider_id']);
  }

  factory Token.delete() {
    var box = Hive.box('user_information');
    if (box.containsKey('token_data')) box.delete('token_data');
    return null;
  }

  @override
  List<Object> get props => [accessToken, tokenType, idToken, expiresIn];

  bool hasToken() {
    return Hive.box('user_information').containsKey('token_data');
  }
}
