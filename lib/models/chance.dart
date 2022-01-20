// To parse this JSON data, do
//
//     final chance = chanceFromJson(jsonString);

import 'dart:convert';

List<Chance> chanceFromJson(String str) =>
    List<Chance>.from(json.decode(str).map((x) => Chance.fromJson(x)));

String chanceToJson(List<Chance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chance {
  Chance({
    this.id,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
  });

  final int id;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;

  factory Chance.fromJson(Map<String, dynamic> json) => Chance(
        id: json["id"],
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        descriptionEn: json["description_en"],
        descriptionAr: json["description_ar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
        "description_en": descriptionEn,
        "description_ar": descriptionAr,
      };
}
