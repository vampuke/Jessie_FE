// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherList _$VoucherListFromJson(Map<String, dynamic> json) {
  return VoucherList(
    (json['voucher'] as List)
        ?.map((e) =>
            e == null ? null : Voucher.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VoucherListToJson(VoucherList instance) =>
    <String, dynamic>{
      'voucher': instance.voucher,
    };

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return Voucher(
    json['id'] as int,
    json['title'] as String,
    json['datetime_create'] as String,
    json['datetime_expire'] as String,
    json['status'] as int,
    json['is_delete'] as int,
    json['user_id'] as int,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'datetime_create': instance.datetimeCreate,
      'datetime_expire': instance.datetimeExpire,
      'status': instance.status,
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
