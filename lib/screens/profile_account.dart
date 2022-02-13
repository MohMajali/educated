import 'dart:convert';
import 'dart:io';
import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/constant/urls.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/services/updates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../repo.dart';

class ProfileAccount extends StatefulWidget {
  final int id;
  const ProfileAccount({Key key, this.id}) : super(key: key);

  @override
  _ProfileAccountState createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  String name = sharedPreferences.getString("name");
  String address = sharedPreferences.getString("address");
  String mail = sharedPreferences.getString("mail");
  String phone = sharedPreferences.getString("phone");
  String userImage = sharedPreferences.getString("image");
  TextEditingController usernameCrl = TextEditingController();
  TextEditingController emailCrl = TextEditingController();
  TextEditingController addressCrl = TextEditingController();
  TextEditingController phoneCrl = TextEditingController();

  final _keyUserName = GlobalKey<FormState>();
  final _keyEmail = GlobalKey<FormState>();
  final _keyPhone = GlobalKey<FormState>();
  final _keyAddress = GlobalKey<FormState>();

  File images;
  String image;
  final imagePicker = ImagePicker();

  Future getImage(ImageSource src) async {
    final pickedFile = await imagePicker.pickImage(source: src);

    setState(() {
      if (pickedFile != null) {
        images = File(pickedFile.path);
      } else {}
    });
  }

  Future getUserImage() async {
    try {
      String url =
          "http://209.250.226.82/api/userImage.php?id=" + widget.id.toString();
      var response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        image = json['user']['profile_photo_path'];
      }
      return Failure(code: 100, errorResponse: "Invalid response");
    } on HttpException {
      return Failure(code: 101, errorResponse: "No Internet");
    } on FormatException {
      return Failure(code: 102, errorResponse: "Invalid format");
    } catch (ex) {
      return Failure(code: 103, errorResponse: "Unkown Error");
    }
  }

  void putVars() async {
    setState(() {
      usernameCrl.text = name;
      emailCrl.text = mail;
      addressCrl.text = address;
      phoneCrl.text = phone;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserImage();
    putVars();
    print(phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: yellow,
        title: Text(getLang(context, "profile"),
            style: const TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Stack(
            children: [
              CircleAvatar(
                radius: 65,
                backgroundImage: images == null
                    ? NetworkImage(Api.imagurl + userImage)
                    : FileImage(File(images.path)),
              ),
              Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheetUser()),
                          );
                        },
                        child: const Icon(
                          Icons.camera_alt,
                          color: yellow,
                          size: 30.0,
                        ),
                      )
                    ],
                  ))
            ],
          )),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _keyPhone,
              child: TextFormField(
                style: const TextStyle(
                  color: black,
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
                decoration: secoundaryInputDecoration2(
                    context,
                    phone,
                    null,
                    const Icon(
                      Icons.phone_android,
                      color: yellow,
                    )),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _keyUserName,
              child: TextFormField(
                style: const TextStyle(color: black),
                cursorColor: blue,
                controller: usernameCrl,
                validator: (val) {
                  if (val.isEmpty) {
                    return getLang(context, "FieldRequired");
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration2(
                    context,
                    name,
                    null,
                    const Icon(
                      Icons.person,
                      color: yellow,
                    )),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _keyAddress,
              child: TextFormField(
                style: const TextStyle(color: black),
                cursorColor: blue,
                controller: addressCrl,
                validator: (val) {
                  if (val.isEmpty) {
                    return getLang(context, "FieldRequired");
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration2(
                    context,
                    address,
                    null,
                    const Icon(
                      Icons.person,
                      color: yellow,
                    )),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _keyEmail,
              child: TextFormField(
                style: const TextStyle(color: black),
                cursorColor: blue,
                controller: emailCrl,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = RegExp(pattern);
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
                decoration: secoundaryInputDecoration2(
                    context,
                    mail,
                    null,
                    const Icon(
                      Icons.email,
                      color: yellow,
                    )),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextButton(
                child: Text(getLang(context, "Save"),
                    style: const TextStyle(fontSize: 14, color: yellow)),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: yellow)))),
                onPressed: () async {
                  String phoneText = phoneCrl.text.toString();
                  String nameText = usernameCrl.text;
                  String addressText = addressCrl.text;
                  String mailText = emailCrl.text;

                  if (_keyPhone.currentState.validate() &&
                      _keyUserName.currentState.validate() &&
                      _keyAddress.currentState.validate() &&
                      _keyEmail.currentState.validate()) {
                    setState(() {
                      sharedPreferences.remove("phone");
                      sharedPreferences.setString("phone", phoneText);
                      sharedPreferences.remove("name");
                      sharedPreferences.setString("name", nameText);
                      sharedPreferences.remove("address");
                      sharedPreferences.setString("address", addressText);
                      sharedPreferences.remove("mail");
                      sharedPreferences.setString("mail", mailText);
                    });
                    await updates(widget.id, mailText, nameText, phoneText,
                        addressText, context);
                    imageBase64(image, images);
                  }
                }),
          )
        ],
      ),
    );
  }

  void imageBase64(String imageApi, File images) async {
    var date = DateTime.now();
    if (images != null) {
      imageApi = widget.id.toString() + '.' + images.path.split('.').last;

      String imageDecode = base64Encode(images.readAsBytesSync());
      await profile(widget.id, imageApi, imageDecode, context);
      sharedPreferences.remove("image");
      sharedPreferences.setString("image", imageApi);
      // print("image " + imageApi);
      // print("image Decode " + imageDecode.toString());
    }
  }

  Widget bottomSheetUser() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            getLang(context, "ProfilePicture"),
            style: const TextStyle(
              fontSize: 20.0,
              fontFamily: 'Simpletax',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.photo),
              onPressed: () async {
                getImage(ImageSource.gallery);
              },
              label: Text(getLang(context, "Gallery"),
                  style: const TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
            FlatButton.icon(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                getImage(ImageSource.camera);
              },
              label: Text(getLang(context, "Camera"),
                  style: const TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
          ])
        ],
      ),
    );
  }
}
