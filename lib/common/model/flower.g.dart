// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flower _$FlowerFromJson(Map<String, dynamic> json) {
  return Flower(
    (json['flower_log'] as List)
        ?.map((e) =>
            e == null ? null : Flower_log.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['flower'] as int,
  );
}

Map<String, dynamic> _$FlowerToJson(Flower instance) => <String, dynamic>{
      'flower_log': instance.flowerLog,
      'flower': instance.flower,
    };

Flower_log _$Flower_logFromJson(Map<String, dynamic> json) {
  return Flower_log(
    json['id'] as int,
    json['datetime'] as int,
    json['reason'] as String,
    json['quantity'] as int,
  );
}

Map<String, dynamic> _$Flower_logToJson(Flower_log instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datetime': instance.datetime,
      'reason': instance.reason,
      'quantity': instance.quantity,
    };
