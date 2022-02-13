import 'dart:convert';
import 'dart:io';
import 'package:educatednearby/constant/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../repo.dart';
import 'package:educatednearby/fun/goto.dart';

Future updates(int id, String mail, String name, String phone, String address,
    BuildContext context) async {
  try {
    String mailUrl = "http://192.248.144.136/api/updates.php";
    var response = await http.post(Uri.parse(mailUrl), body: {
      "id": id.toString(),
      "mail": mail,
      "name": name,
      "phone": phone,
      "address": address
    });
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: json['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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

Future CV(int id, String cv, String cvDecode, String natID, String natDecode,
    BuildContext context) async {
  try {
    String mailUrl = "http://192.248.144.136/api/updateCv.php";
    var response = await http.post(Uri.parse(mailUrl), body: {
      "id": id.toString(),
      "CV": cv.toString(),
      "CVDECODE": cvDecode.toString(),
      "NATID": natID.toString(),
      "NATIDDECODE": natDecode.toString()
    });
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: json['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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

Future profile(
    int id, String image, String decode, BuildContext context) async {
  try {
    String mailUrl = "http://192.248.144.136/api/updateProfile.php";
    var response = await http.post(Uri.parse(mailUrl), body: {
      "id": id.toString(),
      "image": image,
      "imageDecode": decode,
    });
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: json['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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

Future national(
    int id, String natID, String natDecode, BuildContext context) async {
  try {
    String mailUrl = "http://192.248.144.136/api/updateNational.php";
    var response = await http.post(Uri.parse(mailUrl), body: {
      "id": id.toString(),
      "NATID": natID.toString(),
      "NATIDDECODE": natDecode.toString()
    });
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: json['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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

Future cvOnly(int id, String cv, String cvDecode, BuildContext context) async {
  try {
    String mailUrl = "http://192.248.144.136/api/cvOnly.php";
    var response = await http.post(Uri.parse(mailUrl), body: {
      "id": id.toString(),
      "CV": cv.toString(),
      "CVDECODE": cvDecode.toString(),
    });
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: json['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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
