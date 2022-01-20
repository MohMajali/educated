// To parse this JSON data, do
//
//     final cvs = cvsFromJson(jsonString);

import 'dart:convert';

List<Cvs> cvsFromJson(String str) =>
    List<Cvs>.from(json.decode(str).map((x) => Cvs.fromJson(x)));

String cvsToJson(List<Cvs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cvs {
  Cvs({
    this.identityPic,
    this.resume,
    this.briefDesc,
  });

  final String identityPic;
  final String resume;
  final dynamic briefDesc;

  factory Cvs.fromJson(Map<String, dynamic> json) => Cvs(
        identityPic: json["identity_pic"],
        resume: json["resume"],
        briefDesc: json["brief_desc"],
      );

  Map<String, dynamic> toJson() => {
        "identity_pic": identityPic,
        "resume": resume,
        "brief_desc": briefDesc,
      };
}
