// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppleTokenAdapter extends TypeAdapter<AppleToken> {
  @override
  final int typeId = 1;

  @override
  AppleToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppleToken(
      accessToken: fields[0] as String,
      tokenType: fields[1] as String,
      expiresIn: fields[3] as int,
      refreshToken: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppleToken obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.tokenType)
      ..writeByte(2)
      ..write(obj.refreshToken)
      ..writeByte(3)
      ..write(obj.expiresIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppleTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppleToken _$AppleTokenFromJson(Map<String, dynamic> json) {
  return AppleToken(
    accessToken: json['access_token'] as String,
    tokenType: json['token_type'] as String,
    expiresIn: json['expires_in'] as int,
    refreshToken: json['refresh_token'] as String,
  );
}

Map<String, dynamic> _$AppleTokenToJson(AppleToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
    };
