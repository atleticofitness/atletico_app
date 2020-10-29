import 'package:atletico_app/models/token.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'apple_token.dart';
part 'tokens.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(fieldRename: FieldRename.snake)
class Tokens extends HiveObject with EquatableMixin {
  @HiveField(0)
  final AppleToken appleToken;
  @HiveField(1)
  final Token token;
  Tokens({this.appleToken, this.token});
  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);
  Map<String, dynamic> toJson() => _$TokensToJson(this);

  factory Tokens.loadToken() {
    var box = Hive.box('user_information');
    if (!box.containsKey('token_data')) return Tokens();
    Map<String, dynamic> json = box.get('token_data');
    return Tokens(appleToken: json['apple_token'], token: json['token']);
  }

  @override
  List<Object> get props => [appleToken, token];

  bool hasToken() {
    return Hive.box('user_information').containsKey('tokens');
  }
}
