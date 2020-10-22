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
  Token({this.accessToken, this.tokenType});
  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
  Map<String, dynamic> makeHeader() =>
      {"Authorization": "$tokenType $accessToken"};

  factory Token.loadToken() {
    var box = Hive.box('user_information');
    if (!box.containsKey('token_data')) return Token();
    Map<String, dynamic> json = box.get('token_data');
    return Token(
        accessToken: json['access_token'], tokenType: json['token_type']);
  }

  @override
  List<Object> get props => [accessToken, tokenType];

  bool hasToken() {
    return Hive.box('user_information').containsKey('token_data');
  }
}
