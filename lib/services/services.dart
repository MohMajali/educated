import 'dart:io';
import 'package:educatednearby/models/service.dart';
import 'package:http/http.dart' as http;
import '../repo.dart';

class ServicesApi {
  static Future<Object> getService() async {
    try {
      String url = 'http://209.250.226.82/api/services.php';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        return Success(response: servicesFromJson(response.body));
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
