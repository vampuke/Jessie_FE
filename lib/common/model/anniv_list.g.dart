// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniv_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnivList _$AnnivListFromJson(Map<String, dynamic> json) {
  return AnnivList(
    (json['anniv'] as List)
        ?.map(
            (e) => e == null ? null : Anniv.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AnnivListToJson(AnnivList instance) => <String, dynamic>{
      'anniv': instance.anniv,
    };

Anniv _$AnnivFromJson(Map<String, dynamic> json) {
  return Anniv(
    json['id'] as int,
    json['title'] as String,
    json['datetime'] as int,
    json['datetime_create'] as int,
    json['is_delete'] as int,
  );
}

Map<String, dynamic> _$AnnivToJson(Anniv instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'datetime': instance.datetime,
      'datetime_create': instance.datetimeCreate,
      'is_delete': instance.isDelete,
    };
