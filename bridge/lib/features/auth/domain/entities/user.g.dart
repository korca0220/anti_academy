// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      introduction: json['introduction'] as String?,
      mannerTemperature:
          (json['mannerTemperature'] as num?)?.toDouble() ?? 36.5,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'introduction': instance.introduction,
      'mannerTemperature': instance.mannerTemperature,
      'createdAt': instance.createdAt.toIso8601String(),
    };
