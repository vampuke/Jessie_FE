// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodList _$FoodListFromJson(Map<String, dynamic> json) {
  return FoodList(
    (json['food'] as List)
        ?.map(
            (e) => e == null ? null : Food.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FoodListToJson(FoodList instance) => <String, dynamic>{
      'food': instance.food,
    };

Food _$FoodFromJson(Map<String, dynamic> json) {
  return Food(
    json['id'] as int,
    json['type'] as int,
    json['food_name'] as String,
    json['is_delete'] as int,
    json['user_id'] as int,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'food_name': instance.foodName,
      'is_delete': instance.isDelete,
      'user_id': instance.userId,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['user_id'] as int,
    json['user_name'] as String,
    json['role'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'role': instance.role,
    };
