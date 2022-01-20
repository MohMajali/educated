import 'dart:io';

import 'package:educatednearby/models/cvs.dart';
import 'package:http/http.dart' as http;

import '../repo.dart';

class CVApi {
  static Future<Object> getCV(int id) async {
    try {
      String url = 'http://209.250.226.82/api/getCV.php?id=' + id.toString();
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Success(response: cvsFromJson(response.body));
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
