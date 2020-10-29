import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appletoken.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(fieldRename: FieldRename.snake)
class AppleToken extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final String tokenType;
  @HiveField(2)
  final String refreshToken;
  @HiveField(3)
  final int expiresIn;

  AppleToken(
      {this.accessToken, this.tokenType, this.expiresIn, this.refreshToken});

  factory AppleToken.fromJson(Map<String, dynamic> json) =>
      _$AppleTokenFromJson(json);
  Map<String, dynamic> toJson() => _$AppleTokenToJson(this);

  factory AppleToken.loadToken() {
    var box = Hive.box('user_information');
    if (!box.containsKey('apple_token_data')) return AppleToken();
    Map<String, dynamic> json = box.get('apple_token_data');
    return AppleToken(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        refreshToken: json['refresh_token'],
        expiresIn: json['expires_in']);
  }

  @override
  List<Object> get props => [accessToken, tokenType, refreshToken, expiresIn];

  bool hasToken() {
    return Hive.box('user_information').containsKey('apple_token_data');
  }
}
