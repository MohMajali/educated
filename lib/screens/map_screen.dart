import 'dart:async';
import 'dart:collection';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/fun/goto.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/screens/singleservice.dart';
import 'package:educatednearby/view_model/store_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';

import '../main.dart';

class MapScreen extends StatefulWidget {
  final int id;
  final int distances;

  MapScreen({Key key, this.id, this.distances});

  @override
  _MapScreenState createState() => _MapScreenState(this.id);
}

class _MapScreenState extends State<MapScreen> {
  int id;

  _MapScreenState(this.id);

  CameraPosition _initialCamera;
  GoogleMapController _googleMapController;

  // Marker marker;
  Circle circle;
  double lat, long;
  double distance;
  var currentLocation;
  StreamSubscription<Position> ps;
  BitmapDescriptor pinLocationIcon;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var myMarkers = HashSet<Marker>();
  var lang = sharedPreferences.getString("lang");

  Future<void> getLatLag() async {
    currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);
    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    _initialCamera = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
    myMarkers.add(Marker(
        markerId: MarkerId(getLang(context, "MyLocation")),
        position: LatLng(lat, long),
        icon: pinLocationIcon));
    setState(() {});
  }

  Set<Marker> myMarker = {};

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/person.png');
  }

  @override
  void dispose() {
    super.dispose();
    if (ps != null && myMarkers != null) {
      ps.cancel();
      myMarkers.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    getLatLag();
    funtions.getLatLag();
    setCustomMapPin();
  }

  @override
  Widget build(BuildContext context) {
    StoreViewModel storeViewModel = context.watch<StoreViewModel>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          backgroundColor: yellow,
          centerTitle: true,
          title: Text(getLang(context, "Maps")),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: const Icon(Icons.arrow_back))),
      body: _initialCamera == null
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()))
          : GoogleMap(
              initialCameraPosition: _initialCamera,
              onMapCreated: (GoogleMapController googleMap) {
                _googleMapController = googleMap;
                setState(() {
                  _setMakers(storeViewModel);
                });
              },
              markers: myMarkers,
              circles: Set.of((circle != null) ? [circle] : [])),
    );
  }

  _setMakers(StoreViewModel storeViewModel) async {
    // await storeViewModel.getStore(id);
    if (storeViewModel.loading) {
      return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Center(child: CircularProgressIndicator()));
    }

    if (storeViewModel.store.isEmpty) {
    } else {
      setState(() {
        myMarkers.clear();
        for (final store in storeViewModel.store) {
          distance = Geolocator.distanceBetween(
              funtions.lat, funtions.long, store.latitude, store.longitude);
          int indistance = distance.round().toInt();
          double distanceInKilo = indistance / 1000;

          print(funtions.lat.toString() +
              ' JJJJSSSSSSS ' +
              funtions.long.toString());

          if (distanceInKilo <= widget.distances) {
            myMarkers.add(Marker(
                markerId: lang == 'ar'
                    ? MarkerId(store.nameAr)
                    : MarkerId(store.nameEn),
                position: LatLng(store.latitude, store.longitude),
                infoWindow: InfoWindow(
                    title: lang == 'ar' ? store.nameAr : store.nameEn,
                    snippet: lang == 'ar' ? store.descAr : store.descEn,
                    onTap: () async {
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              store.latitude, store.longitude);
                      String street = placemarks[0].street;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleServiceScreen(
                                  logo: store.logo,
                                  nameEn: store.nameEn,
                                  nameAr: store.nameAr,
                                  email: store.email,
                                  phone: store.phone,
                                  descEn: store.descEn,
                                  descAr: store.descAr,
                                  lat: store.latitude,
                                  long: store.longitude,
                                  street: street.toString(),
                                  cv: store.resume,
                                  id: store.userId.toString(),
                                )),
                      ).then((value) {
                        setState(() {
                          if (value == true) {
                            storeViewModel.getStore(widget.id);
                          } else {
                            null;
                          }
                        });
                      });
                    })));
          } else {
            print('NOPEEEEEEE');
          }
        }
      });
    }
  }

  // Widget getBottomSheet(String name, String mail, String description,
  //     double lat, double long, String phone, String street) {
  //   return Stack(
  //     children: <Widget>[
  //       Container(
  //         margin: const EdgeInsets.only(top: 32),
  //         color: Colors.white,
  //         child: Column(
  //           children: <Widget>[
  //             Container(
  //               color: Colors.blueAccent,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       name,
  //                       style:
  //                           const TextStyle(color: Colors.white, fontSize: 14),
  //                     ),
  //                     const SizedBox(
  //                       height: 5,
  //                     ),
  //                     Row(
  //                       children: const <Widget>[
  //                         Text("4.5",
  //                             style:
  //                                 TextStyle(color: Colors.white, fontSize: 12)),
  //                         Icon(
  //                           Icons.star,
  //                           color: Colors.yellow,
  //                         ),
  //                         SizedBox(
  //                           width: 20,
  //                         ),
  //                         Text("970 Folowers",
  //                             style:
  //                                 TextStyle(color: Colors.white, fontSize: 14))
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 5,
  //                     ),
  //                     Text(description,
  //                         style: const TextStyle(
  //                             color: Colors.white, fontSize: 14)),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             Row(
  //               children: <Widget>[
  //                 const SizedBox(
  //                   width: 20,
  //                 ),
  //                 const Icon(
  //                   Icons.map,
  //                   color: Colors.blue,
  //                 ),
  //                 const SizedBox(
  //                   width: 20,
  //                 ),
  //                 street != null
  //                     ? Text(street)
  //                     : Text(lat.toString() + ',' + long.toString())
  //               ],
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             InkWell(
  //               onTap: () {
  //                 launch("tel:+96207" + phone);
  //               },
  //               child: Row(
  //                 children: <Widget>[
  //                   const SizedBox(
  //                     width: 20,
  //                   ),
  //                   const Icon(
  //                     Icons.call,
  //                     color: Colors.blue,
  //                   ),
  //                   const SizedBox(
  //                     width: 20,
  //                   ),
  //                   Text(phone)
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Align(
  //           alignment: Alignment.topRight,
  //           child: FloatingActionButton(
  //               child: const Icon(Icons.navigation),
  //               onPressed: () {
  //                 navigateTo(lat, long);
  //               }),
  //         ),
  //       )
  //     ],
  //   );
  // }

  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("https://maps.google.com/?q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
