import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
part 'token.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(fieldRename: FieldRename.snake)
class Token extends HiveObject {
  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final String tokenType;
  Token({this.accessToken, this.tokenType});
  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
  Map<String, dynamic> makeHeader() =>
      {"Authorization": "$tokenType $accessToken"};
}
