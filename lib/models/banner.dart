// To parse this JSON data, do
//
//     final banners = bannersFromJson(jsonString);

import 'dart:convert';

List<Banners> bannersFromJson(String str) =>
    List<Banners>.from(json.decode(str).map((x) => Banners.fromJson(x)));

String bannersToJson(List<Banners> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Banners {
  Banners({
    this.id,
    this.titleEn,
    this.titleAr,
    this.image,
    this.locationId,
  });

  final int id;
  final String titleEn;
  final String titleAr;
  final String image;
  final String locationId;

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
        id: json["id"],
        titleEn: json["title_en"],
        titleAr: json["title_ar"],
        image: json["image"],
        locationId: json["location_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_en": titleEn,
        "title_ar": titleAr,
        "image": image,
        "location_id": locationId,
      };
}
