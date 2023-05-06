import 'package:cafeteria_app/core/init/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part "items_model.g.dart";

@JsonSerializable(createToJson: false)
class ItemsModel extends BaseModel<ItemsModel> {
  List<Days>? days;

  ItemsModel({this.days});

  Map<String, dynamic>? toJson() {
    return null;
  }

  @override
  ItemsModel createObject() {
    return ItemsModel();
  }

  @override
  ItemsModel fromJson(Map<String, dynamic> json) {
    return _$ItemsModelFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class Days {
  int? id;
  String? day;
  List<Contents>? contents;

  Days({this.id, this.day, this.contents});

  factory Days.fromJson(Map<String, dynamic> json) {
    return _$DaysFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class Contents {
  String? name;
  List<Foods>? foods;

  Contents({this.name, this.foods});

  factory Contents.fromJson(Map<String, dynamic> json) {
    return _$ContentsFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class Foods {
  String? fname;
  int? price;
  bool? isSelected;

  Foods({this.fname, this.price, this.isSelected});

  factory Foods.fromJson(Map<String, dynamic> json) {
    return _$FoodsFromJson(json);
  }
}
