// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['user_id'] as int,
      json['user_name'] as String,
      json['password'] as String,
      json['role'] as int,
      json['is_delete'] as int);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'user_name': instance.user_name,
      'password': instance.password,
      'role': instance.role,
      'is_delete': instance.is_delete
    };
