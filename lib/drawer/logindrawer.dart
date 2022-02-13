import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/constant/urls.dart';
import 'package:educatednearby/helper/sharedpredman.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/screens/certification.dart';
import 'package:educatednearby/screens/navbar.dart';
import 'package:educatednearby/screens/profile_account.dart';
import 'package:educatednearby/screens/service.dart';
import 'package:educatednearby/view_model/cv_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';

class HomeDrawerLogin extends StatefulWidget {
  final int id;
  const HomeDrawerLogin({Key key, this.id}) : super(key: key);
  @override
  _HomeDrawerLoginState createState() => _HomeDrawerLoginState();
}

class _HomeDrawerLoginState extends State<HomeDrawerLogin> {
  String lang = sharedPreferences.getString("lang");
  String mail = sharedPreferences.getString("mail");
  String name = sharedPreferences.getString("name");
  String image = sharedPreferences.getString("image");
  String phone;

  @override
  void initState() {
    super.initState();
    // getPref();
  }

  @override
  Widget build(BuildContext context) {
    CvViewModel cvViewModel = context.watch<CvViewModel>();
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
            // const Divider(
            //   color: Colors.white,
            //   thickness: 0.75,
            // ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: Text(
                getLang(context, "profile"),
                style: const TextStyle(
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
              title: Text(
                getLang(context, "Cirtifications"),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              leading: const Icon(Icons.wb_incandescent,
                  color: Colors.white, size: 25),
              onTap: () async {
                await cvViewModel.getCVs(widget.id);
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
                lang == "en"
                    ? MyApp.setLocale(context, Locale("ar", ""))
                    : MyApp.setLocale(context, Locale("en", ""));
                setState(() {
                  lang == "en" ? lang = "ar" : lang = "en";
                });
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => NavBar(),
                  ),
                );
              },
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.75,
            ),
            ListTile(
              title: Text(
                getLang(context, "LogOut"),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              leading: const Icon(Icons.logout, color: Colors.white, size: 25),
              onTap: () async {
                SharedPref.userLogOut();
                // Navigator.of(context).pop();
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => NavBar(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
