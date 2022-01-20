import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/drawer/home_drawer.dart';
import 'package:educatednearby/drawer/logindrawer.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/screens/service.dart';
import 'package:educatednearby/view_model/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  int userId;
  double lat, long;
  BannerViewModel bannerViewModel;
  var currentLocation;
  Future getPer() async {
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
                    child: Text('Okay'),
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
    print(per);
    return per;
  }

  Future<void> getLatLag() async {
    currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);
    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    setState(() {});
  }

  void getShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getInt("userID");
    // print(userId);
  }

  @override
  void initState() {
    super.initState();
    getShared();
    getPer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        title: Text(getLang(context, "EducatedNearby")),
        backgroundColor: yellow,
        centerTitle: true,
      ),
      drawer: userId == null
          ? HomeDrawer()
          : HomeDrawerLogin(
              id: userId,
            ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          cardMainPage(
              context,
              getLang(context, "Service"),
              ServiceScreen(
                  // id: userId,
                  ),
              Image.asset(
                "assets/images/at_home.png",
                height: 80,
              )),
        ],
      )),
    );
  }

  // _bannerUi(BannerViewModel bannerViewModel) {
  //   if (bannerViewModel.loading) {
  //     return Container();
  //   }

  //   if (bannerViewModel.banner.isEmpty) {
  //     return const Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   }
  //   return SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.262,
  //       child: CarouselSlider.builder(
  //           itemCount: bannerViewModel.banner.length,
  //           itemBuilder: (context, index, i) {
  //             Banners banner = bannerViewModel.banner[index];

  //             return InkWell(
  //               onTap: () {
  //                 print(banner.id);
  //               },
  //               child: Container(
  //                 height: MediaQuery.of(context).size.height * 0.25,
  //                 width: MediaQuery.of(context).size.width,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(0), color: null),
  //                 child: ListTile(
  //                   title: Image.network(
  //                     "https://www.rei.com/dam/winter_camping_checklist_hero_lg.jpg",
  //                     fit: BoxFit.cover,
  //                   ),
  //                   subtitle: Text(
  //                     banner.titleEn,
  //                     style: const TextStyle(color: blue, fontSize: 20),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //           options: CarouselOptions(
  //               autoPlay: true,
  //               enlargeCenterPage: true,
  //               viewportFraction: 1,
  //               reverse: true,
  //               autoPlayInterval: const Duration(seconds: 3),
  //               height: MediaQuery.of(context).size.height)));
  // }

  // _newsUi(NewsViewModel newsViewModel) {
  //   if (newsViewModel.loading) {
  //     return Container();
  //   }

  //   if (newsViewModel.news.isEmpty) {
  //     return const Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   }
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height * 0.1,
  //     child: ListView.separated(
  //         scrollDirection: Axis.horizontal,
  //         physics: const ClampingScrollPhysics(),
  //         shrinkWrap: true,
  //         itemBuilder: (context, index) {
  //           News news = newsViewModel.news[index];
  //           if (newsViewModel.news.length == 0) {
  //             return const Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           }
  //           return InkWell(
  //             onTap: () {
  //               print(news.id);
  //             },
  //             child: Container(
  //               margin: const EdgeInsets.only(right: 10, left: 10),
  //               height: MediaQuery.of(context).size.height * 0.25,
  //               width: 200,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(20), color: blue),
  //               child: ListTile(
  //                 title: Text(
  //                   news.newsEn,
  //                   textAlign: TextAlign.center,
  //                   style: const TextStyle(color: Colors.white),
  //                 ),
  //                 subtitle: Text(
  //                   news.publishingDate,
  //                   style: const TextStyle(color: Colors.white),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //         separatorBuilder: (context, index) => const Divider(),
  //         itemCount: newsViewModel.news.length),
  //   );
  // }
}
