import 'package:json_annotation/json_annotation.dart'; 
  
part 'food_list.g.dart';


@JsonSerializable()
  class FoodList extends Object {

  @JsonKey(name: 'food')
  List<Food> food;

  FoodList(this.food,);

  factory FoodList.fromJson(Map<String, dynamic> srcJson) => _$FoodListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FoodListToJson(this);

}

  
@JsonSerializable()
  class Food extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'food_name')
  String foodName;

  @JsonKey(name: 'is_delete')
  int isDelete;

  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'user')
  User user;

  Food(this.id,this.type,this.foodName,this.isDelete,this.userId,this.user,);

  factory Food.fromJson(Map<String, dynamic> srcJson) => _$FoodFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FoodToJson(this);

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

  
