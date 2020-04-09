import 'package:json_annotation/json_annotation.dart'; 
  
part 'wish_list.g.dart';


@JsonSerializable()
  class WishList extends Object {

  @JsonKey(name: 'wish')
  List<Wish> wish;

  WishList(this.wish,);

  factory WishList.fromJson(Map<String, dynamic> srcJson) => _$WishListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WishListToJson(this);

}

  
@JsonSerializable()
  class Wish extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'datetime_create')
  int datetimeCreate;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'is_delete')
  int isDelete;

  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'user')
  User user;

  Wish(this.id,this.datetimeCreate,this.status,this.title,this.isDelete,this.userId,this.user,);

  factory Wish.fromJson(Map<String, dynamic> srcJson) => _$WishFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WishToJson(this);

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

  
