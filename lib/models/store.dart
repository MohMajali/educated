// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

List<Store> storeFromJson(String str) => List<Store>.from(json.decode(str).map((x) => Store.fromJson(x)));

String storeToJson(List<Store> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Store {
  Store({
    this.id,
    this.nameEn,
    this.nameAr,
    this.subCatId,
    this.latitude,
    this.longitude,
    this.logo,
    this.email,
    this.descEn,
    this.descAr,
    this.phone,
    this.userId,
    this.name,
    this.userMail,
    this.resume,
  });

  final int id;
  final String nameEn;
  final String nameAr;
  final int subCatId;
  final double latitude;
  final double longitude;
  final String logo;
  final String email;
  final String descEn;
  final String descAr;
  final String phone;
  final int userId;
  final String name;
  final String userMail;
  final dynamic resume;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    nameEn: json["name_en"],
    nameAr: json["name_ar"],
    subCatId: json["sub_cat_id"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    logo: json["logo"],
    email: json["email"],
    descEn: json["desc_en"],
    descAr: json["desc_ar"],
    phone: json["phone"],
    userId: json["userId"],
    name: json["name"],
    userMail: json["userMail"],
    resume: json["resume"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_en": nameEn,
    "name_ar": nameAr,
    "sub_cat_id": subCatId,
    "latitude": latitude,
    "longitude": longitude,
    "logo": logo,
    "email": email,
    "desc_en": descEn,
    "desc_ar": descAr,
    "phone": phone,
    "userId": userId,
    "name": name,
    "userMail": userMail,
    "resume": resume,
  };
}
