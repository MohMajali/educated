// To parse this JSON data, do
//
//     final subcategory = subcategoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Subcategory> subcategoryFromJson(String str) => List<Subcategory>.from(
    json.decode(str).map((x) => Subcategory.fromJson(x)));

String subcategoryToJson(List<Subcategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subcategory {
  Subcategory({
    @required this.id,
    @required this.nameEn,
    @required this.nameAr,
    @required this.imagePath,
  });

  final int id;
  final String nameEn;
  final String nameAr;
  final String imagePath;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
        "image_path": imagePath == null ? null : imagePath,
      };
}
