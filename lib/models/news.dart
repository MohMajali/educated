// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  News({
    this.id,
    this.newsEn,
    this.newsAr,
    this.publishingDate,
  });

  final int id;
  final String newsEn;
  final String newsAr;
  final String publishingDate;

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        newsEn: json["news_en"],
        newsAr: json["news_ar"],
        publishingDate: json["publishing_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "news_en": newsEn,
        "news_ar": newsAr,
        "publishing_date": publishingDate,
      };
}
