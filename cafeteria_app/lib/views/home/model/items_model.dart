class ItemsModel {
  List<Days>? days;

  ItemsModel({this.days});

  ItemsModel.fromJson(Map<String, dynamic> json) {
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(Days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (days != null) {
      data['days'] = days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  int? id;
  String? day;
  List<Contents>? contents;

  Days({this.id, this.day, this.contents});

  Days.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contents {
  String? name;
  List<Foods>? foods;

  Contents({this.name, this.foods});

  Contents.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(Foods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (foods != null) {
      data['foods'] = foods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Foods {
  int? fiyat;
  String? fname;
  bool? isSelected;

  Foods({this.fiyat, this.fname, this.isSelected});

  Foods.fromJson(Map<String, dynamic> json) {
    fiyat = json['fiyat'];
    fname = json['fname'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fiyat'] = fiyat;
    data['fname'] = fname;
    data['isSelected'] = isSelected;
    return data;
  }
}
