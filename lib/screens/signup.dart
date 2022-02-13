import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/services/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _keyUserName = GlobalKey<FormState>();
  final _keyEmail = GlobalKey<FormState>();
  final _keyPassword = GlobalKey<FormState>();
  final _keyConfirmPassword = GlobalKey<FormState>();
  final _keyPhone = GlobalKey<FormState>();
  final _keyAddress = GlobalKey<FormState>();

  TextEditingController usernameCrl = TextEditingController();
  TextEditingController passwordCrl = TextEditingController();
  TextEditingController confirmPasswordCrl = TextEditingController();
  TextEditingController phoneCrl = TextEditingController();
  TextEditingController emailCrl = TextEditingController();
  TextEditingController addressCrl = TextEditingController();

  bool _passwordVisibleSignUp1 = false;
  bool _passwordVisibleSignUp2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: yellow,
        body: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            // textHomePage(
            //     context, "Signup with", 20, FontWeight.bold, 2, null, yellow),
            sizedBoxHomePage(10),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Form(
                key: _keyPhone,
                child: TextFormField(
                  style: const TextStyle(
                    color: blue,
                  ),
                  cursorColor: blue,
                  controller: phoneCrl,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9]"))
                  ],
                  validator: (val) {
                    if (val.isEmpty) {
                      return getLang(context, "FieldRequired");
                    } else if (val.length != 10) {
                      return getLang(context, "Phonenumbermustbe10digits");
                    }
                    return null;
                  },
                  decoration: secoundaryInputDecoration(
                      context,
                      getLang(context, "PhoneNumber"),
                      null,
                      const Icon(
                        Icons.phone_android,
                        color: yellow,
                      )),
                ),
              ),
            ),
            sizedBoxHomePage(10),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Form(
                key: _keyUserName,
                child: TextFormField(
                  style: const TextStyle(color: blue),
                  cursorColor: blue,
                  controller: usernameCrl,
                  validator: (val) {
                    if (val.isEmpty) {
                      return getLang(context, "FieldRequired");
                    }
                    return null;
                  },
                  decoration: secoundaryInputDecoration(
                      context,
                      getLang(context, "UserName"),
                      null,
                      const Icon(
                        Icons.person,
                        color: yellow,
                      )),
                ),
              ),
            ),
            sizedBoxHomePage(10),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Form(
                key: _keyAddress,
                child: TextFormField(
                  style: const TextStyle(color: blue),
                  cursorColor: blue,
                  controller: addressCrl,
                  validator: (val) {
                    if (val.isEmpty) {
                      return getLang(context, "FieldRequired");
                    }
                    return null;
                  },
                  decoration: secoundaryInputDecoration(
                      context,
                      getLang(context, "Address"),
                      null,
                      const Icon(
                        Icons.home,
                        color: yellow,
                      )),
                ),
              ),
            ),
            sizedBoxHomePage(10),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Form(
                key: _keyEmail,
                child: TextFormField(
                  style: TextStyle(color: blue),
                  cursorColor: blue,
                  controller: emailCrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (value.isEmpty) {
                      return getLang(context, "FieldRequired");
                    }
                    if (value.length > 50) {
                      return getLang(context, "validateless50");
                    } else if (!regex.hasMatch(value)) {
                      return getLang(context, "Entervalidemail");
                    } else {
                      emailCrl.text = value;
                    }
                    return null;
                  },
                  decoration: secoundaryInputDecoration(
                      context,
                      getLang(context, "Email"),
                      null,
                      const Icon(
                        Icons.email,
                        color: yellow,
                      )),
                ),
              ),
            ),
            sizedBoxHomePage(10),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Form(
                key: _keyPassword,
                child: TextFormField(
                  style: const TextStyle(color: blue),
                  cursorColor: blue,
                  controller: passwordCrl,
                  obscureText: !_passwordVisibleSignUp1,
                  validator: (val) {
                    if (val.isEmpty) {
                      return getLang(context, "FieldRequired");
                    } else if (val.length < 6) {
                      return getLang(context, "passeq0ormore");
                    } else if (val.length > 30) {
                      return getLang(context, "validateless30");
                    }
                    return null;
                  },
                  decoration: secoundaryInputDecoration(
                      context,
                      getLang(context, "Password"),
                      IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisibleSignUp1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: yellow,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisibleSignUp1 =
                                  !_passwordVisibleSignUp1;
                            });
                          }),
                      const Icon(
                        Icons.lock,
                        color: yellow,
                      )),
                ),
              ),
            ),
            sizedBoxHomePage(10),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Form(
                key: _keyConfirmPassword,
                child: TextFormField(
                  style: const TextStyle(color: blue),
                  cursorColor: blue,
                  controller: confirmPasswordCrl,
                  validator: (val) {
                    if (val.isEmpty) {
                      return getLang(context, "FieldRequired");
                    } else if (val.length < 6) {
                      return getLang(context, "passeq0ormore");
                    } else if (val.length > 30) {
                      return getLang(context, "validateless30");
                    } else if (passwordCrl.text != confirmPasswordCrl.text) {
                      return getLang(context, "PasswordNotMatch");
                    }
                    return null;
                  },
                  obscureText: !_passwordVisibleSignUp2,
                  decoration: secoundaryInputDecoration(
                      context,
                      getLang(context, "ConfirmPassword"),
                      IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisibleSignUp2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: yellow,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisibleSignUp2 =
                                  !_passwordVisibleSignUp2;
                            });
                          }),
                      const Icon(
                        Icons.lock,
                        color: yellow,
                      )),
                ),
              ),
            ),
            sizedBoxHomePage(10),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: GestureDetector(
                onTap: () async {
                  String name = usernameCrl.text;
                  String phone = phoneCrl.text;
                  String address = addressCrl.text;
                  String mail = emailCrl.text;
                  String password = passwordCrl.text;
                  if (_keyPhone.currentState.validate() &&
                      _keyUserName.currentState.validate() &&
                      _keyEmail.currentState.validate() &&
                      _keyPassword.currentState.validate() &&
                      _keyConfirmPassword.currentState.validate() &&
                      _keyAddress.currentState.validate() &&
                      _keyConfirmPassword.currentState.validate()) {
                    await SignupAPI.signup(
                        phone, mail, password, address, name, context);
                  } else {
                    // return print('object');
                  }
                },
                child: submit(context, getLang(context, "SIGNUP"), black),
              ),
            )
          ],
        ));
  }
}
