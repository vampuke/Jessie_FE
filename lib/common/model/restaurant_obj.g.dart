// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantObj _$RestaurantObjFromJson(Map<String, dynamic> json) {
  return RestaurantObj(
    (json['restaurant'] as List)
        ?.map((e) =>
            e == null ? null : Restaurant.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['type'] as List)
        ?.map(
            (e) => e == null ? null : Type.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RestaurantObjToJson(RestaurantObj instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant,
      'type': instance.type,
    };

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return Restaurant(
    json['id'] as int,
    json['title'] as String,
    json['type'] as String,
    (json['rating'] as num)?.toDouble(),
    json['note'] as String,
    (json['dishes'] as List)
        ?.map((e) =>
            e == null ? null : Dishes.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'rating': instance.rating,
      'note': instance.note,
      'dishes': instance.dishes,
    };

Dishes _$DishesFromJson(Map<String, dynamic> json) {
  return Dishes(
    json['id'] as int,
    json['title'] as String,
    json['restaurant_id'] as int,
    (json['rating'] as num)?.toDouble(),
    json['note'] as String,
  );
}

Map<String, dynamic> _$DishesToJson(Dishes instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'restaurant_id': instance.restaurantId,
      'rating': instance.rating,
      'note': instance.note,
    };

Type _$TypeFromJson(Map<String, dynamic> json) {
  return Type(
    json['type'] as String,
  );
}

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'type': instance.type,
    };
