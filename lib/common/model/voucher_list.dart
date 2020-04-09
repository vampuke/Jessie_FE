import 'package:json_annotation/json_annotation.dart'; 
  
part 'voucher_list.g.dart';


@JsonSerializable()
  class VoucherList extends Object {

  @JsonKey(name: 'voucher')
  List<Voucher> voucher;

  VoucherList(this.voucher,);

  factory VoucherList.fromJson(Map<String, dynamic> srcJson) => _$VoucherListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VoucherListToJson(this);

}

  
@JsonSerializable()
  class Voucher extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'datetime_create')
  String datetimeCreate;

  @JsonKey(name: 'datetime_expire')
  String datetimeExpire;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'is_delete')
  int isDelete;

  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'user')
  User user;

  Voucher(this.id,this.title,this.datetimeCreate,this.datetimeExpire,this.status,this.isDelete,this.userId,this.user,);

  factory Voucher.fromJson(Map<String, dynamic> srcJson) => _$VoucherFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VoucherToJson(this);

}

  
@JsonSerializable()
  class User extends Object {

  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'user_name')
  String userName;

  @JsonKey(name: 'role')
  int role;

  User(this.userId,this.userName,this.role,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}

  
