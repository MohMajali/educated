import 'dart:io';

import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/models/cvs.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:educatednearby/fun/goto.dart';
import '../repo.dart';

class CVApi {
  static Future<Object> getCV(int id) async {
    try {
      String url = 'http://192.248.144.136/api/getCv.php?id=' + id.toString();
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Success(response: cvsFromJson(response.body));
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
