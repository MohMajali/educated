import 'dart:io';
import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/configirations.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/models/store.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/screens/navbar.dart';
import 'package:educatednearby/screens/singleservice.dart';
import 'package:educatednearby/screens/splach_content.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:educatednearby/fun/goto.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = "help";
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: yellow,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  SharedPreferences sharedPreferences;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Education NearBy",
      "image": "assets/images/education.png"
    }
  ];

  @override
  void initState() {
    super.initState();
    iniDynamicLink();
  }

  List<Store> singleService = [];

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

        Navigator.push(
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
        Navigator.push(
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]["text"],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(flex: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(),
                    SplahButton(
                      text: getLang(context, "Continue"),
                      press: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => NavBar()));
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? null : null,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class SplahButton extends StatelessWidget {
  const SplahButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(60),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        // color: Color(0xFFF27E63),
        // color: Colors.black,
        color: Colors.black,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// void navigateUser(BuildContext context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var status = prefs.getBool('Remember') ?? false;
//   if (status) {
//     Navigator.pushReplacement(
//         context, new MaterialPageRoute(builder: (context) => MainPage()));
//   } else {
//     Navigator.pushReplacement(
//         context, new MaterialPageRoute(builder: (context) => HomePage()));
//   }
// }
