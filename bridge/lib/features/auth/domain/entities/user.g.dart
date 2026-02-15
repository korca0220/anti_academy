// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      avatarUrl: json['avatar_url'] as String?,
      introduction: json['introduction'] as String?,
      mannerTemperature:
          (json['manner_temperature'] as num?)?.toDouble() ?? 36.5,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'avatar_url': instance.avatarUrl,
      'introduction': instance.introduction,
      'manner_temperature': instance.mannerTemperature,
      'created_at': instance.createdAt.toIso8601String(),
    };
