import 'dart:convert';
import 'dart:io';
import 'package:educatednearby/helper/sharedpredman.dart';
import 'package:educatednearby/screens/navbar.dart';
import 'package:educatednearby/screens/play_video.dart';
import 'package:educatednearby/screens/service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:educatednearby/fun/goto.dart';
import '../repo.dart';

class LoginAPI {
  static Future<Object> login(
      String email, String password, BuildContext context) async {
    try {
      String url = 'http://192.248.144.136/api/login.php';
      var response = await http.post(Uri.parse(url), body: {
        "email": email,
        "password": password,
      });
      var json = jsonDecode(response.body);
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
          // PlayVideo();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => PlayVideo()),
              (Route<dynamic> route) => false);
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (BuildContext context) => NavBar()),
          //     (Route<dynamic> route) => false);
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
        }
        return Success(response: json['message'].toString());
      }

      funtions.message("No Internet Connection");
      return Failure(code: 100, errorResponse: "Invalid response");
    } on HttpException {
      funtions.message("No Internet Connection");
      return Failure(code: 101, errorResponse: "No Internet");
    } on FormatException {
      funtions.message("No Internet Connection");
      return Failure(code: 102, errorResponse: "Invalid format");
    } catch (ex) {
      funtions.message("No Internet Connection");
      return Failure(code: 103, errorResponse: "Unkown Error");
    }
  }
}
