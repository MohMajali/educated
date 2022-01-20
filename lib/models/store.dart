// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

List<Store> storeFromJson(String str) =>
    List<Store>.from(json.decode(str).map((x) => Store.fromJson(x)));

String storeToJson(List<Store> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Store {
  Store({
    this.id,
    this.nameEn,
    this.nameAr,
    this.serviceTypeId,
    this.latitude,
    this.longitude,
    this.logo,
    this.email,
    this.phone,
    this.descEn,
    this.descAr,
  });

  final int id;
  final String nameEn;
  final String nameAr;
  final int serviceTypeId;
  final double latitude;
  final double longitude;
  final String logo;
  final String email;
  final String phone;
  final String descEn;
  final String descAr;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        serviceTypeId: json["service_type_id"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        logo: json["logo"],
        email: json["email"],
        phone: json["phone"],
        descEn: json["desc_en"],
        descAr: json["desc_ar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
        "service_type_id": serviceTypeId,
        "latitude": latitude,
        "longitude": longitude,
        "logo": logo,
        "email": email,
        "phone": phone,
        "desc_en": descEn,
        "desc_ar": descAr,
      };
}
