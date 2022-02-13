import 'dart:io';
import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/models/store.dart';
import 'package:educatednearby/repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:educatednearby/fun/goto.dart';

class StoresApi {
  static Future<Object> getStores(int storeId) async {
    try {
      String url =
          'http://192.248.144.136/api/stores.php?id=' + storeId.toString();
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Success(response: storeFromJson(response.body));
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

  static Future<Object> searchVendors(String name) async {
    try {
      String url = 'http://192.248.144.136/api/searchvendors.php';
      var response = await http.post(Uri.parse(url), body: {"name": name});

      if (response.statusCode == 200) {
        return Success(response: storeFromJson(response.body));
      }
      funtions.message("No Internet Connection");
      return Failure(code: 100, errorResponse: "Invalid response");
    } on HttpException {
      funtions.message("No Internet Connection");
      return Failure(code: 101, errorResponse: "No Internet");
    } on FormatException {
      funtions.message("No Internet Connection");
      // print(FormatException);
      return Failure(code: 102, errorResponse: "Invalid format");
    } catch (ex) {
      funtions.message("No Internet Connection");
      return Failure(code: 103, errorResponse: "Unkown Error");
    }
  }

  static Future<Object> getService(var id) async {
    try {
      String url =
          'http://192.248.144.136/api/signleService.php?id=' + id.toString();
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Success(response: storeFromJson(response.body));
      }
      funtions.message("No Internet Connection");
      return Failure(code: 100, errorResponse: "Invalid response");
    } on HttpException {
      funtions.message("No Internet Connection");
      return Failure(code: 101, errorResponse: "No Internet");
    } on FormatException {
      funtions.message("No Internet Connection");
      // print(FormatException);
      return Failure(code: 102, errorResponse: "Invalid format");
    } catch (ex) {
      funtions.message("No Internet Connection");
      return Failure(code: 103, errorResponse: "Unkown Error");
    }
  }
}
