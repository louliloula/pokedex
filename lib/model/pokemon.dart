import 'package:equatable/equatable.dart';

class Pokemon  {
  String? sId;
  int? pkdxId;
  int? nationalId;
  String? name;
  int? iV;
  String? oldImageUrl;
  String? description;
  String? imageUrl;
  List<String>? types;
  List<Evolutions>? evolutions;
  bool isFavorite = false;

  Pokemon(
      {this.sId,
        this.pkdxId,
        this.nationalId,
        this.name,
        this.iV,
        this.oldImageUrl,
        this.description,
        this.imageUrl,
        this.types,
        this.evolutions,
        this.isFavorite = false});

  Pokemon.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    pkdxId = json['pkdx_id'];
    nationalId = json['national_id'];
    name = json['name'];
    iV = json['__v'];
    oldImageUrl = json['old_image_url'];
    description = json['description'];
    imageUrl = json['image_url'];
    types = json['types'].cast<String>();
    if (json['evolutions'] != null) {
      evolutions = <Evolutions>[];
      json['evolutions'].forEach((v) {
        evolutions!.add(new Evolutions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['pkdx_id'] = this.pkdxId;
    data['national_id'] = this.nationalId;
    data['name'] = this.name;
    data['__v'] = this.iV;
    data['old_image_url'] = this.oldImageUrl;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['types'] = this.types;
    if (this.evolutions != null) {
      data['evolutions'] = this.evolutions!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class Evolutions  {
  int? level;
  String? method;
  String? to;
  String? sId;

  Evolutions({this.level, this.method, this.to, this.sId});

  Evolutions.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    method = json['method'];
    to = json['to'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['method'] = this.method;
    data['to'] = this.to;
    data['_id'] = this.sId;
    return data;
  }


}
