import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../repo.dart';

class AddServiceApi {
  static Future<Object> addService(
      String subCat,
      String nameEn,
      String nameAr,
      String phone,
      String email,
      String address,
      String descEn,
      String descAr,
      int userId,
      double late,
      double lang,
      String logo,
      BuildContext context) async {
    try {
      String url = 'http://192.248.144.136/api/insertStore.php';
      var response = await http.post(Uri.parse(url), body: {
        "subCat": subCat,
        "nameEn": nameEn,
        "nameAr": nameAr,
        "phone": phone,
        "email": email,
        "address": address,
        "descEn": descEn,
        "descAr": descAr,
        "userId": userId.toString(),
        "late": late.toString(),
        "lang": lang.toString(),
        "logo": logo
      });

      var json = jsonDecode(response.body);
      // print(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: json['message'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return Success(response: json['message'].toString());
      }
      return Failure(code: 100, errorResponse: "Invalid response");
    } on HttpException {
      return Failure(code: 101, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: 102, errorResponse: "Invalid format");
    } catch (ex) {
      print(ex);
      return Failure(code: 103, errorResponse: "Unkown Error");
    }
  }
}
