// To parse this JSON data, do
//
//     final services = servicesFromJson(jsonString);

import 'dart:convert';

List<Services> servicesFromJson(String str) =>
    List<Services>.from(json.decode(str).map((x) => Services.fromJson(x)));

String servicesToJson(List<Services> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Services {
  Services({
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

  factory Services.fromJson(Map<String, dynamic> json) => Services(
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
