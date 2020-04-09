import 'package:json_annotation/json_annotation.dart'; 
  
part 'anniv_list.g.dart';


@JsonSerializable()
  class AnnivList extends Object {

  @JsonKey(name: 'anniv')
  List<Anniv> anniv;

  AnnivList(this.anniv,);

  factory AnnivList.fromJson(Map<String, dynamic> srcJson) => _$AnnivListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AnnivListToJson(this);

}

  
@JsonSerializable()
  class Anniv extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'datetime')
  int datetime;

  @JsonKey(name: 'datetime_create')
  int datetimeCreate;

  @JsonKey(name: 'is_delete')
  int isDelete;

  Anniv(this.id,this.title,this.datetime,this.datetimeCreate,this.isDelete,);

  factory Anniv.fromJson(Map<String, dynamic> srcJson) => _$AnnivFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AnnivToJson(this);

}

  
