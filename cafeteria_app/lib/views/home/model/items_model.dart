import 'package:json_annotation/json_annotation.dart';

part "items_model.g.dart";

@JsonSerializable()
class ItemsModel {
  List<Days>? days;

  ItemsModel({this.days});

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return _$ItemsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ItemsModelToJson(this);
  }
}

@JsonSerializable()
class Days {
  int? id;
  String? day;
  List<Contents>? contents;

  Days({this.id, this.day, this.contents});

  factory Days.fromJson(Map<String, dynamic> json) {
    return _$DaysFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DaysToJson(this);
  }
}

@JsonSerializable()
class Contents {
  String? name;
  List<Foods>? foods;

  Contents({this.name, this.foods});

  factory Contents.fromJson(Map<String, dynamic> json) {
    return _$ContentsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ContentsToJson(this);
  }
}

@JsonSerializable()
class Foods {
  int? fiyat;
  String? fname;
  bool? isSelected;

  Foods({this.fiyat, this.fname, this.isSelected});

  factory Foods.fromJson(Map<String, dynamic> json) {
    return _$FoodsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FoodsToJson(this);
  }
}
