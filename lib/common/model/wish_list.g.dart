// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishList _$WishListFromJson(Map<String, dynamic> json) {
  return WishList(
    (json['wish'] as List)
        ?.map(
            (e) => e == null ? null : Wish.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WishListToJson(WishList instance) => <String, dynamic>{
      'wish': instance.wish,
    };

Wish _$WishFromJson(Map<String, dynamic> json) {
  return Wish(
    json['id'] as int,
    json['datetime_create'] as int,
    json['status'] as int,
    json['title'] as String,
    json['is_delete'] as int,
    json['user_id'] as int,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WishToJson(Wish instance) => <String, dynamic>{
      'id': instance.id,
      'datetime_create': instance.datetimeCreate,
      'status': instance.status,
      'title': instance.title,
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
