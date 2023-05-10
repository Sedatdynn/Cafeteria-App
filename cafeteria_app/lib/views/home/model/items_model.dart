import 'package:cafeteria_app/core/init/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part "items_model.g.dart";

@JsonSerializable(createToJson: false)
class ItemsModel extends BaseModel<ItemsModel> {
  final List<Days>? days;

  ItemsModel({this.days});

  Map<String, dynamic>? toJson() {
    return null;
  }

  @override
  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return _$ItemsModelFromJson(json);
  }

  @override
  List<Object?> get props => [];

  @override
  ItemsModel fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class Days extends BaseModel<Days> {
  final int? id;
  final String? day;
  final List<Contents>? contents;

  Days({this.id, this.day, this.contents});

  @override
  factory Days.fromJson(Map<String, dynamic> json) {
    return _$DaysFromJson(json);
  }

  @override
  List<Object?> get props => [id, day, contents];

  @override
  Days fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class Contents extends BaseModel<Contents> {
  final String? name;
  final List<Foods>? foods;

  Contents({this.name, this.foods});

  @override
  factory Contents.fromJson(Map<String, dynamic> json) {
    return _$ContentsFromJson(json);
  }

  @override
  List<Object?> get props => [name, foods];

  @override
  Contents fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class Foods extends BaseModel<Foods> {
  final String? fname;
  final int? price;
  bool? isSelected;

  Foods({this.fname, this.price, this.isSelected});

  @override
  factory Foods.fromJson(Map<String, dynamic> json) {
    return _$FoodsFromJson(json);
  }

  @override
  List<Object?> get props => [fname, price, isSelected];

  @override
  Foods fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }
}
