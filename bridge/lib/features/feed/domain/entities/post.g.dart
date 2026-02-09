// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as String,
      authorId: json['author_id'] as String,
      type: $enumDecode(_$PostTypeEnumMap, json['type']),
      title: json['title'] as String,
      content: json['content'] as String,
      status: $enumDecode(_$PostStatusEnumMap, json['status']),
      imageUrls: (json['image_urls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'type': _$PostTypeEnumMap[instance.type]!,
      'title': instance.title,
      'content': instance.content,
      'status': _$PostStatusEnumMap[instance.status]!,
      'image_urls': instance.imageUrls,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$PostTypeEnumMap = {
  PostType.request: 'request',
  PostType.offer: 'offer',
};

const _$PostStatusEnumMap = {
  PostStatus.open: 'open',
  PostStatus.in_progress: 'in_progress',
  PostStatus.completed: 'completed',
};
