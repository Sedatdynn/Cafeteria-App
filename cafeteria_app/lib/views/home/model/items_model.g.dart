// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsModel _$ItemsModelFromJson(Map<String, dynamic> json) => ItemsModel(
      days: (json['days'] as List<dynamic>?)
          ?.map((e) => Days.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Days _$DaysFromJson(Map<String, dynamic> json) => Days(
      id: json['id'] as int?,
      day: json['day'] as String?,
      contents: (json['contents'] as List<dynamic>?)
          ?.map((e) => Contents.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Contents _$ContentsFromJson(Map<String, dynamic> json) => Contents(
      name: json['name'] as String?,
      foods: (json['foods'] as List<dynamic>?)
          ?.map((e) => Foods.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Foods _$FoodsFromJson(Map<String, dynamic> json) => Foods(
      fname: json['fname'] as String?,
      price: json['price'] as int?,
      isSelected: json['isSelected'] as bool?,
    );
