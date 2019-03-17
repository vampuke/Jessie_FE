import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {

  User(
      this.user_id,
      this.user_name,
      this.password,
      this.role,
      this.is_delete);

  int user_id;
  String user_name;
  String password;
  int role;
  int is_delete;


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);


  Map<String, dynamic> toJson() => _$UserToJson(this);

  User.empty();

}
