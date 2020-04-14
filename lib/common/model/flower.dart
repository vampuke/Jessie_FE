import 'package:json_annotation/json_annotation.dart'; 
  
part 'flower.g.dart';


@JsonSerializable()
  class Flower extends Object {

  @JsonKey(name: 'flower_log')
  List<Flower_log> flowerLog;

  @JsonKey(name: 'flower')
  int flower;

  Flower(this.flowerLog,this.flower,);

  factory Flower.fromJson(Map<String, dynamic> srcJson) => _$FlowerFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FlowerToJson(this);

}

  
@JsonSerializable()
  class Flower_log extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'datetime')
  int datetime;

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'quantity')
  int quantity;

  Flower_log(this.id,this.datetime,this.reason,this.quantity,);

  factory Flower_log.fromJson(Map<String, dynamic> srcJson) => _$Flower_logFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Flower_logToJson(this);

}

  
