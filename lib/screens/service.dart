import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/constant/urls.dart';
import 'package:educatednearby/drawer/home_drawer.dart';
import 'package:educatednearby/drawer/logindrawer.dart';
import 'package:educatednearby/fun/goto.dart';
import 'package:educatednearby/models/category.dart';
import 'package:educatednearby/models/store.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/screens/singleservice.dart';
import 'package:educatednearby/screens/subcategroy.dart';
import 'package:educatednearby/view_model/category_view.dart';
import 'package:educatednearby/view_model/subcat_view.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/src/provider.dart';
import '../main.dart';
import 'addservice.dart';
import 'package:http/http.dart' as http;

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  int id = sharedPreferences.getInt("userID");
  double distance;
  var lang = sharedPreferences.getString("lang");
  List<Widget> stores = new List<Widget>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var fbm = FirebaseMessaging.instance;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  List<Store> singleService = [];

  initalMessage() async {
    var msg = await FirebaseMessaging.instance.getInitialMessage();
    if (msg != null) {
      //do sth
    } else {
      //do sth else
    }
  }

  @override
  void initState() {
    super.initState();
    iniDynamicLink();
    funtions.getPer(context);
    initalMessage();
    fbm.getToken().then((value) {
      // print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: "@mipmap/educationLogo",
              ),
            ));
      }
    });
//when i click notify **************************************************
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });

    FirebaseMessaging.instance.subscribeToTopic(id.toString());
  }

  @override
  Widget build(BuildContext context) {
    CategoryViewModel categoryViewModel = context.watch<CategoryViewModel>();
    SubCategoryViewModel subCategoryViewModel =
        context.watch<SubCategoryViewModel>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(getLang(context, "EducatedNearby")),
          backgroundColor: yellow,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  if (id == null) {
                    _showAlert(getLang(context, "lognfirst"));
                  } else {
                    // Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddService(
                                  userID: id,
                                  latitude: funtions.lat,
                                  langitude: funtions.long,
                                ))).then((value) {
                      if (value == true) {
                        categoryViewModel.getCategories();
                        // _categoryUi(categoryViewModel, subCategoryViewModel);
                      }
                    });
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ),
        drawer: id == null
            ? HomeDrawer()
            : HomeDrawerLogin(
                id: id,
              ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              _categoryUi(categoryViewModel, subCategoryViewModel),
            ],
          ),
        ));
  }

  void _showAlert(String title) {
    showDialog(
        context: context,
        builder: (BuildContext con) {
          return AlertDialog(
            content: Text(title),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  _categoryUi(CategoryViewModel categoryViewModel,
      SubCategoryViewModel subCategoryViewModel) {
    if (categoryViewModel.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (categoryViewModel.category.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Text(getLang(context, "nodata")),
      );
    } else {
      return GridView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 4,
        ),
        itemBuilder: (_, index) {
          Category category = categoryViewModel.category[index];

          return InkWell(
            onTap: () async {
              await subCategoryViewModel.getSubCategories(category.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SubCategoryScreen(
                          id: category.id,
                        )),
              ).then((value) {
                setState(() {
                  if (value == true) {
                    categoryViewModel.getCategories();
                    // _categoryUi(categoryViewModel, subCategoryViewModel);
                  } else {
                    null;
                  }
                });
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      // offset: const Offset(3, 3),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: category.imagePath == null
                            ? Image.asset(
                                "assets/images/educationlogo.png",
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: Api.categoryurl + category.imagePath,
                                placeholder: (context, url) => Container(
                                    child: const Center(
                                        child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: Container(
                          color: yellow,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: lang == 'en'
                                        ? category.nameEn
                                        : category.nameAr,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: null == categoryViewModel.category
            ? 0
            : categoryViewModel.category.length,
      );
    }
  }

  Future<void> iniDynamicLink() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (data != null) {
      if (data.link.pathSegments.contains('SingleServiceScreen')) {
        String id = data.link.queryParameters['serviceid'];
        await getService(id).then((value) {
          setState(() {
            singleService = value;
          });
        });

        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleServiceScreen(
                    serviceId: id,
                    singleService: singleService,
                  )),
        );
      }
    }

    dynamicLinks.onLink.listen((dynamicLinkData) async {
      // Navigator.pushNamed(context, dynamicLinkData.link.path);
      final Uri deeplink = dynamicLinkData.link;
      if (deeplink != null) {
        String id = deeplink.queryParameters['id'];
        await getService(id).then((value) {
          setState(() {
            singleService = value;
          });
        });

        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleServiceScreen(
                    serviceId: id,
                    singleService: singleService,
                  )),
        );
        // print(deeplink.queryParameters['id']);
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
    // return route;
  }

  static Future<List<Store>> getService(var id) async {
    try {
      String url =
          'http://192.248.144.136/api/signleService.php?id=' + id.toString();
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<Store> singleServiceList = storeFromJson(response.body);
        return singleServiceList;
      }
      funtions.message("No Internet Connection");
      return List<Store>();
    } on HttpException {
      funtions.message("No Internet Connection");
      return List<Store>();
    } on FormatException {
      funtions.message("No Internet Connection");
      return List<Store>();
    } catch (ex) {
      funtions.message("No Internet Connection");
      return List<Store>();
    }
  }
}
