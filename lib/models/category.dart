// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
  });

  final int id;
  final String nameEn;
  final String nameAr;
  final String image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
        "image": image,
      };
}
