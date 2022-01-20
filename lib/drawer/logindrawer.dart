import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/constant/urls.dart';
import 'package:educatednearby/helper/sharedpredman.dart';
import 'package:educatednearby/screens/certification.dart';
import 'package:educatednearby/screens/home_page.dart';
import 'package:educatednearby/screens/profile_account.dart';
import 'package:educatednearby/screens/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomeDrawerLogin extends StatefulWidget {
  final int id;
  const HomeDrawerLogin({Key key, this.id}) : super(key: key);
  @override
  _HomeDrawerLoginState createState() => _HomeDrawerLoginState();
}

class _HomeDrawerLoginState extends State<HomeDrawerLogin> {
  String lang;
  String mail = sharedPreferences.getString("mail");
  String name = sharedPreferences.getString("name");
  String image = sharedPreferences.getString("image");
  String phone;

  @override
  void initState() {
    super.initState();
    // getPref();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: yellow,
        child: ListView(
          children: <Widget>[
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileAccount(),
                  ));
                },
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  accountName: Text(
                    mail,
                    style: const TextStyle(color: blue),
                  ),
                  accountEmail: Text(
                    name,
                    style: const TextStyle(color: blue),
                  ),
                  currentAccountPicture: ClipOval(
                      child: image == null
                          ? Image.asset(
                              'assets/images/userdefault.jpg',
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              Api.imagurl + image,
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "PrivacyPolicy",
                style: TextStyle(
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
              title: const Text(
                "TermsAndConditions",
                style: TextStyle(
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
              title: const Text(
                "AboutUs",
                style: TextStyle(
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
              title: const Text(
                "ContactUs",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              leading: const Icon(Icons.contact_phone_outlined,
                  color: Colors.white, size: 25),
              onTap: () {},
            ),
            // const Divider(
            //   color: Colors.white,
            //   thickness: 0.75,
            // ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: const Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading:
                  const Icon(Icons.settings, color: Colors.white, size: 25),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileAccount(
                            id: widget.id,
                          )),
                );
              },
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: const Text(
                "Cirtifications",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              leading: const Icon(Icons.wb_incandescent,
                  color: Colors.white, size: 25),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Certifications(
                            id: widget.id,
                          )),
                );
              },
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: const Text(
                "Language",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.shop, color: Colors.white, size: 25),
              onTap: () {
                // if (lang.toString() == "en") {
                //   AjwaaDriverApp.setLocale(context, Locale("ar", ""));
                // } else {
                //   AjwaaDriverApp.setLocale(context, Locale("en", ""));
                // }
                // Navigator.pop(context);
              },
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: const Text(
                "Log Out",
                style: TextStyle(
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
                SharedPref.userLogOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ServiceScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
