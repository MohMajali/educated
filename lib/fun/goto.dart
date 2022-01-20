import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class funtions {
  static void push(BuildContext context, Widget goto) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => goto),
    );
  }

  static Future getPer(BuildContext context) async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text(
                  "Services Not Enabled",
                  style: TextStyle(
                      fontFamily: 'Simpletax',
                      fontSize: 15,
                      color: Colors.black),
                ),
                content: const Text(
                  'Open Your Location',
                  style: TextStyle(
                      fontFamily: 'Simpletax',
                      fontSize: 12,
                      color: Colors.black45),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ));
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per == await Geolocator.requestPermission();

      getLatLag();
    } else {
      getLatLag();
    }
    // print(per);
    return per;
  }

  static double lat;
  static double long;
  static var currentLocation;
  static Future<void> getLatLag() async {
    currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);
    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    return [lat, long];
    // setState(() {});
  }

  static void message(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
