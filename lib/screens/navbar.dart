import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/main.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/screens/profile_account.dart';
import 'package:educatednearby/screens/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  NavBar({
    Key key,
  }) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentTsb = 0;
  final List<Widget> screens = [
    ServiceScreen(),
    const ProfileAccount(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = ServiceScreen();
  var id = sharedPreferences.getInt("userID");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: yellow,
        child: const Icon(
          Icons.home,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            currentScreen = const ServiceScreen();
            currentTsb = 0;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    minWidth: 150,
                    onPressed: () {
                      setState(() {
                        // currentScreen = Notifications();
                        // currentTsb=1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.assignment,
                          color: yellow,
                        ),
                        Text(
                          getLang(context, "notifications"),
                          style: TextStyle(fontSize: 10, color: yellow),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 150,
                    onPressed: () {
                      if (id != null) {
                        setState(() {
                          currentScreen = const ProfileAccount();
                          currentTsb = 2;
                        });
                      } else {
                        _showAlert(getLang(context, "lognfirst"));
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          color: yellow,
                        ),
                        Text(
                          getLang(context, "profile"),
                          style: TextStyle(fontSize: 10, color: yellow),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
}
