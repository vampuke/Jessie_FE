import 'package:json_annotation/json_annotation.dart'; 
  
part 'user.g.dart';


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

  
