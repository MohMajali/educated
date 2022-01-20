import 'dart:io';
import 'package:educatednearby/models/store.dart';
import 'package:educatednearby/repo.dart';
import 'package:http/http.dart' as http;

class StoresApi {
  static Future<Object> getStores(int storeId) async {
    try {
      String url =
          'http://192.248.144.136/api/stores.php?id=' + storeId.toString();
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Success(response: storeFromJson(response.body));
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
