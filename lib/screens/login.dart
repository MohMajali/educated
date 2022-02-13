import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/services/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = true;
  SharedPreferences userShared;
  var result;
  int id;
  var _keyEmail = GlobalKey<FormState>();
  var _keyPassword = GlobalKey<FormState>();
  TextEditingController emailOrPhoneCrl = TextEditingController();
  TextEditingController passwordCrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: yellow,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 50,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      getLang(context, "Login"),
                      style: const TextStyle(fontSize: 30, color: black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      getLang(context, "toyouraccount"),
                      style: const TextStyle(fontSize: 15, color: black),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      textFormFiledHomePage(
                          context,
                          _keyEmail,
                          emailOrPhoneCrl,
                          getLang(context, "Email"),
                          getLang(context, "error"),
                          const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          null,
                          TextInputType.emailAddress,
                          false),
                      sizedBoxHomePage(10),
                      textFormFiledHomePage(
                          context,
                          _keyPassword,
                          passwordCrl,
                          getLang(context, "Password"),
                          getLang(context, "error"),
                          const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          IconButton(
                            icon: Icon(_passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          TextInputType.visiblePassword,
                          _passwordVisible),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: const Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        String email = emailOrPhoneCrl.text;
                        String password = passwordCrl.text;
                        // print(email + ' ' + password);
                        LoginAPI.login(email, password, context);
                      },
                      color: yellow,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        getLang(context, "Login"),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      getLang(context, "Donthaveanaccount"),
                      style: const TextStyle(color: black, fontSize: 20),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'Signup');
                      },
                      child: Text(
                        getLang(context, "signup"),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/education.png"),
                        fit: BoxFit.fitHeight),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
