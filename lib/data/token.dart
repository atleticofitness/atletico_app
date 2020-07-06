import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;

@jsonSerializable
class Token {
  final String accessToken;
  final String tokenType;
  Token({this.accessToken, this.tokenType});
}
