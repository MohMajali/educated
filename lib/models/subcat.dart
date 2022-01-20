// To parse this JSON data, do
//
//     final subcategory = subcategoryFromJson(jsonString);

import 'dart:convert';

List<Subcategory> subcategoryFromJson(String str) => List<Subcategory>.from(
    json.decode(str).map((x) => Subcategory.fromJson(x)));

String subcategoryToJson(List<Subcategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subcategory {
  Subcategory({
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
    this.storeId,
  });

  final int id;
  final String nameEn;
  final String nameAr;
  final String image;
  final int storeId;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        image: json["image"],
        storeId: json["store_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
        "image": image,
        "store_id": storeId,
      };
}
