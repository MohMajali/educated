import 'dart:io';
import 'package:educatednearby/models/subcat.dart';
import 'package:educatednearby/repo.dart';
import 'package:http/http.dart' as http;

class SubCategoryApi {
  static Future<Object> getSubCats(var catID) async {
    try {
      String url = 'http://192.248.144.136/api/subCategory.php?catId=' +
          catID.toString();
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Success(response: subcategoryFromJson(response.body));
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
