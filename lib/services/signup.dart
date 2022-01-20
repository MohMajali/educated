import 'dart:convert';
import 'dart:io';
import 'package:educatednearby/helper/sharedpredman.dart';
import 'package:educatednearby/screens/home_page.dart';
import 'package:educatednearby/screens/service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../repo.dart';

class SignupAPI {
  static Future<Object> signup(String phone, String email, String password,
      String address, String name, BuildContext context) async {
    try {
      String url = 'http://192.248.144.136/api/signup.php';
      var response = await http.post(Uri.parse(url), body: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        "address": address
      });
      var json = jsonDecode(response.body);
      json['message'];
      if (response.statusCode == 200) {
        if (!json['error']) {
          String emailFromJson = json['user']['email'];
          String phoneFromJson = json['user']['phone'];
          String addressFromJson = json['user']['address'];
          String nameFromJson = json['user']['name'];
          String imageFromJson = json['user']['profile_photo_path'];
          int idFromJson = json['user']['id'];
          SharedPref.storeUserData(emailFromJson, nameFromJson, phoneFromJson,
              addressFromJson, idFromJson, imageFromJson);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => const ServiceScreen()),
              (Route<dynamic> route) => false);
          return Success(response: json['message'].toString());
        } else {
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
      }
      return Failure(code: 100, errorResponse: "Invalid response");
    } on HttpException {
      return Failure(code: 101, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: 102, errorResponse: "Invalid format");
    } catch (ex) {
      return Failure(code: 103, errorResponse: "Unkown Error");
    }
  }
}
