import 'package:cached_network_image/cached_network_image.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/constant/urls.dart';
import 'package:educatednearby/fun/goto.dart';
import 'package:educatednearby/models/store.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/screens/singleservice.dart';
import 'package:educatednearby/view_model/search_vendor.dart';
import 'package:educatednearby/view_model/store_view.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';

class StoreScreen extends StatefulWidget {
  final int distance, id;
  const StoreScreen({Key key, this.distance, this.id}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  double distance;
  List<Widget> stores = new List<Widget>();
  var lang = sharedPreferences.getString("lang");
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSearching = false;
  TextEditingController controller = new TextEditingController();
  SearchViewModel searchViewModel;
  @override
  void initState() {
    super.initState();
    funtions.getLatLag();
  }

  @override
  Widget build(BuildContext context) {
    StoreViewModel storeViewModel = context.watch<StoreViewModel>();
    searchViewModel = context.read<SearchViewModel>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(getLang(context, "Stores")),
          backgroundColor: yellow,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.search),
                      title: TextField(
                        onTap: () {
                          setState(() {
                            _isSearching = true;
                          });
                        },
                        controller: controller,
                        decoration: const InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: onSearchTextChanged,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                            _isSearching = false;
                            controller.clear();
                            searchViewModel.store.clear();
                            // onSearchTextChanged('');
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              _isSearching == true
                  ? searchViewModel.store.isNotEmpty ||
                          controller.text.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchViewModel.store.length,
                          itemBuilder: (context, i) {
                            Store store = searchViewModel.store[i];
                            return InkWell(
                              onTap: () async {
                                await toScreen(store, storeViewModel);
                              },
                              child: Card(
                                child: ListTile(
                                  leading: store.logo == null
                                      ? const CircleAvatar(
                                          radius: 60,
                                          backgroundImage: NetworkImage(
                                              "http://192.248.144.136/userImage/userDefault.jpg"))
                                      : CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              "http://192.248.144.136/userImage/" +
                                                  store.logo),
                                          backgroundColor: Colors.white,
                                        ),
                                  title: lang == 'ar'
                                      ? Text(store.nameAr)
                                      : Text(store.nameEn),
                                ),
                                margin: const EdgeInsets.all(0.0),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchViewModel.store.length,
                          itemBuilder: (context, index) {
                            Store store = searchViewModel.store[index];
                            return InkWell(
                              onTap: () async {
                                await toScreen(store, storeViewModel);
                              },
                              child: Card(
                                child: ListTile(
                                    leading: store.logo == null
                                        ? const CircleAvatar(
                                            radius: 60,
                                            backgroundImage: NetworkImage(
                                                "http://192.248.144.136/userImage/userDefault.jpg"))
                                        : CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                "http://192.248.144.136/userImage/" +
                                                    store.logo),
                                            backgroundColor: Colors.white,
                                          ),
                                    title: lang == 'ar'
                                        ? Text(store.nameAr)
                                        : Text(store.nameEn)),
                                margin: const EdgeInsets.all(0.0),
                              ),
                            );
                          },
                        )
                  : _storeUi(storeViewModel)
            ],
          ),
        ));
  }

  onSearchTextChanged(String text) async {
    String nameEn = text;
    print(nameEn);
    _isSearching == false ? _isSearching = true : null;
    if (text.isEmpty) {
      setState(() {});
      return;
    } else {
      searchViewModel.searchVendor(nameEn);
    }

    setState(() {});
  }

  _storeUi(StoreViewModel storeViewModel) {
    if (storeViewModel.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (storeViewModel.store.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Text(getLang(context, "nodata")),
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
            leading: store.logo == null
                ? Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: Api.imagurl + 'userDefault.jpg',
                      placeholder: (context, url) => Container(
                          child:
                              const Center(child: CircularProgressIndicator())),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          "http://192.248.144.136/userImage/" + store.logo,
                      placeholder: (context, url) => Container(
                          child:
                              const Center(child: CircularProgressIndicator())),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
            title: lang == 'ar'
                ? Text(
                    store.nameAr,
                    style: const TextStyle(color: yellow, fontSize: 20),
                  )
                : Text(
                    store.nameEn,
                    style: const TextStyle(color: yellow, fontSize: 20),
                  ),
            onTap: () async {
              await toScreen(store, storeViewModel);
            },
          ),
        ));
      }
    }

    return Column(
      children: stores.isEmpty ? [Text(getLang(context, "nodata"))] : stores,
    );
  }

  Future<void> toScreen(Store store, StoreViewModel storeViewModel) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(store.latitude, store.longitude);
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
                serviceId: store.id.toString(),
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
  }
}
