// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    @required this.id,
    @required this.nameEn,
    @required this.nameAr,
    @required this.imagePath,
  });

  final int id;
  final String nameEn;
  final String nameAr;
  final dynamic imagePath;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
        "image_path": imagePath,
      };
}
