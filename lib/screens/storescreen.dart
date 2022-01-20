import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/fun/goto.dart';
import 'package:educatednearby/screens/singleservice.dart';
import 'package:educatednearby/view_model/store_view.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/src/provider.dart';

class StoreScreen extends StatefulWidget {
  final int distance,id;
  const StoreScreen({Key key, this.distance,this.id}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  double distance;
  List<Widget> stores = new List<Widget>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    funtions.getLatLag();
  }
  @override
  Widget build(BuildContext context) {
    StoreViewModel storeViewModel = context.watch<StoreViewModel>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          title: const Text("Stores"),
          backgroundColor: yellow,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context,true);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              _storeUi(storeViewModel)
            ],
          ),
        ));
  }

  _storeUi(StoreViewModel storeViewModel) {
    if (storeViewModel.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height ,
        child: const Center(child:  CircularProgressIndicator()),
      );
    }
    if (storeViewModel.store.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: const Text("No Data to show"),
      );
    }
    stores.clear();
    for (final store in storeViewModel.store) {
      distance = Geolocator.distanceBetween(
          funtions.lat, funtions.long, store.latitude, store.longitude);
      int indistance = distance.round().toInt();
      double distanceInKilo = indistance / 1000;

      if (distanceInKilo <= widget.distance) {
        // print(store.nameEn);
        stores.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              store.nameEn,
              style: const TextStyle(color: yellow, fontSize: 20),
            ),
            onTap: () async{
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
                          email: store.email,
                          phone: store.phone,
                          descEn: store.descEn,
                          descAr: store.descAr,
                          lat: store.latitude,
                          long: store.longitude,
                      street: street.toString(),
                      cv: store.resume,
                        )),
              ).then((value) {
                setState(() {
                  if(value == true){
                    storeViewModel.getStore(widget.id);
                  } else {
                    null;
                  }

                });
              });
            },
          ),
        ));
      }
    }

    return Column(
      children: stores.isEmpty ? [const Text('No Data to show')] : stores,
    );
  }
}
