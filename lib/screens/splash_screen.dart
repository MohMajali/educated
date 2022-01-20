import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/configirations.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/screens/home_page.dart';
import 'package:educatednearby/screens/service.dart';
import 'package:educatednearby/screens/splach_content.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = "help";
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: brown,
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
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Creative Store, Let’s shop!",
      "image": "assets/images/picweb1.png"
    },
    {
      "text": "نحن نساعدك للتواصل مع المحلات",
      "image": "assets/images/picweb2.png"
    },
    {
      "text": "We show the easy way to shop.",
      "image": "assets/images/picweb3.png"
    },
    {"text": "Just stay at home with us", "image": "assets/images/picweb4.png"},
  ];

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
                      text: "Continue",
                      press: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ServiceScreen()));
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
        color: currentPage == index ? blue : Colors.white,
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
        color: yellow,
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
