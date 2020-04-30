import 'package:json_annotation/json_annotation.dart';

part 'restaurant_obj.g.dart';

@JsonSerializable()
class RestaurantObj extends Object {
  @JsonKey(name: 'restaurant')
  List<Restaurant> restaurant;

  @JsonKey(name: 'type')
  List<Type> type;

  RestaurantObj(
    this.restaurant,
    this.type,
  );

  factory RestaurantObj.fromJson(Map<String, dynamic> srcJson) =>
      _$RestaurantObjFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RestaurantObjToJson(this);
}

@JsonSerializable()
class Restaurant extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'rating')
  double rating;

  @JsonKey(name: 'note')
  String note;

  @JsonKey(name: 'dishes')
  List<Dishes> dishes;

  Restaurant(
    this.id,
    this.title,
    this.type,
    this.rating,
    this.note,
    this.dishes,
  );

  factory Restaurant.fromJson(Map<String, dynamic> srcJson) =>
      _$RestaurantFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}

@JsonSerializable()
class Dishes extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'restaurant_id')
  int restaurantId;

  @JsonKey(name: 'rating')
  double rating;

  @JsonKey(name: 'note')
  String note;

  Dishes(
    this.id,
    this.title,
    this.restaurantId,
    this.rating,
    this.note,
  );

  factory Dishes.fromJson(Map<String, dynamic> srcJson) =>
      _$DishesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DishesToJson(this);
}

@JsonSerializable()
class Type extends Object {
  @JsonKey(name: 'type')
  String type;

  Type(
    this.type,
  );

  factory Type.fromJson(Map<String, dynamic> srcJson) =>
      _$TypeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
