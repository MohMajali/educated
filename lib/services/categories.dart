import 'dart:io';
import 'package:educatednearby/fun/goto.dart';
import 'package:educatednearby/models/category.dart';
import 'package:educatednearby/repo.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  static Future<Object> getCategory() async {
    try {
      String url = 'http://192.248.144.136/api/category.php';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Success(response: categoryFromJson(response.body));
      } else {
        funtions.message("No Internet Connection");
        return Failure(code: 100, errorResponse: "Invalid response");
      }
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

  static Future<Object> category(var id) async {
    try {
      String url =
          'http://192.248.144.136/api/catlist.php?service_ID=' + id.toString();
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Success(response: categoryFromJson(response.body));
      } else {
        funtions.message("No Internet Connection");
        return Failure(code: 100, errorResponse: "Invalid response");
      }
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
