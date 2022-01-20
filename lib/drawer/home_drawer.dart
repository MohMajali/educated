import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/main.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/screens/login.dart';
import 'package:educatednearby/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatefulWidget {
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  var lang;
  String mail;
  String phone;

  Future getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      lang = sharedPreferences.getString("lang");
      mail = sharedPreferences.getString("mail");
      phone = sharedPreferences.getString("phone");

      sharedPreferences.commit();
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: yellow,
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                            },
                            child: RichText(
                              text: TextSpan(
                                text: getLang(context, "Login"),
                                style: const TextStyle(
                                  color: blue,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Simpletax',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ));
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: getLang(context, "SignUp"),
                                  style: const TextStyle(
                                    color: blue,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Simpletax',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            ListTile(
              title: Text(
                getLang(context, "Privacy"),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              leading:
                  const Icon(Icons.privacy_tip, color: Colors.white, size: 25),
              onTap: () {},
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: Text(
                getLang(context, "TermsAndConditions"),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              leading: const Icon(Icons.assignment_late,
                  color: Colors.white, size: 25),
              onTap: () {},
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: Text(
                getLang(context, "AboutUs"),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              leading: const Icon(Icons.wb_incandescent,
                  color: Colors.white, size: 25),
              onTap: () {},
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: Text(
                getLang(context, "ContactUs"),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              leading: const Icon(Icons.contact_phone_outlined,
                  color: Colors.white, size: 25),
              onTap: () {},
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: Text(
                getLang(context, "Language"),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.shop, color: Colors.white, size: 25),
              onTap: () {
                print(lang);
                lang == "en"
                    ? MyApp.setLocale(context, Locale("ar", ""))
                    : MyApp.setLocale(context, Locale("en", ""));
                setState(() {
                  lang == "en" ? lang = "ar" : lang = "en";
                });
              },
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: Text(
                getLang(context, "Login"),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              leading: const Icon(Icons.logout, color: Colors.white, size: 25),
              onTap: () async {
                // SharedPreferences sharedPreferences =
                //     await SharedPreferences.getInstance();
                // sharedPreferences.setBool("isLogged", false);
                // sharedPreferences.clear();
                // Navigator.of(context).pushAndRemoveUntil(
                //   CupertinoPageRoute(builder: (context) => HomePage()),
                //   (_) => false,
                // );

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            )
          ],
        ),
      ),
    );
  }
}
