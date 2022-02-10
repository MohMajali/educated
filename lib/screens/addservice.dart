import 'dart:convert';
import 'dart:io';
import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/fun/goto.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/services/addservice.dart';
import 'package:educatednearby/view_model/category_view.dart';
import 'package:educatednearby/view_model/subcat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';

class AddService extends StatefulWidget {
  final int userID;
  final double latitude;
  final double langitude;
  const AddService({Key key, this.userID, this.latitude, this.langitude})
      : super(key: key);

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  String _sevice;
  String _cat;
  String _subcat;
  var lang = sharedPreferences.getString("lang");

  final _keynameEn = GlobalKey<FormState>();
  final _keynameAr = GlobalKey<FormState>();
  final _keyPhone = GlobalKey<FormState>();
  final _keyMail = GlobalKey<FormState>();
  final _keyAddress = GlobalKey<FormState>();
  final _keydescEn = GlobalKey<FormState>();
  final _keydescAr = GlobalKey<FormState>();
  TextEditingController storeNameEn = TextEditingController();
  TextEditingController storeNameAr = TextEditingController();
  TextEditingController storePhone = TextEditingController();
  TextEditingController storeMail = TextEditingController();
  TextEditingController storeAddress = TextEditingController();
  TextEditingController storeDescEn = TextEditingController();
  TextEditingController storeDescAr = TextEditingController();

  File images;
  String image;
  final imagePicker = ImagePicker();
  String imageDecode;

  Future getImage(ImageSource src) async {
    final pickedFile = await imagePicker.pickImage(source: src);

    setState(() {
      if (pickedFile != null) {
        images = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    // ServiceViewModel serviceViewModel = context.watch<ServiceViewModel>();
    CategoryViewModel categoryListViewModel =
        context.watch<CategoryViewModel>();
    SubCategoryViewModel subCategoryViewModel =
        context.watch<SubCategoryViewModel>();
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(getLang(context, "AddService")),
          backgroundColor: yellow,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView(
          children: [
            Center(
                child: Stack(
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundImage: images == null
                      ? const AssetImage("assets/images/userdefault.jpg")
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
            const SizedBox(
              height: 10,
            ),
            // _serviceUi(
            //     serviceViewModel, categoryListViewModel, subCategoryViewModel),
            const SizedBox(
              height: 10,
            ),
            _categoryUi(categoryListViewModel, subCategoryViewModel),
            const SizedBox(
              height: 10,
            ),
            _subCat(subCategoryViewModel),
            const SizedBox(
              height: 10,
            ),
            detailsUi()
          ],
        ));
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

  Future<void> imageBase64() async {
    var date = DateTime.now();
    if (images != null) {
      image = widget.userID.toString() +
          date.second.toString() +
          '.' +
          images.path.split('.').last;

      imageDecode = base64Encode(images.readAsBytesSync());
      return [image, imageDecode];
    }
  }

  _categoryUi(CategoryViewModel categoryListViewModel,
      SubCategoryViewModel subCategoryViewModel) {
    if (categoryListViewModel.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: const CircularProgressIndicator(),
      );
    }

    return Container(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .05, 0,
            MediaQuery.of(context).size.width * .05, 0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    value: _cat,
                    iconSize: 30,
                    icon: const Icon(Icons.add),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text(getLang(context, "Service"),
                        style: const TextStyle(color: yellow)),
                    onChanged: (String newValue) async {
                      setState(() {
                        _cat = newValue;
                        _subcat = null;
                      });
                      await subCategoryViewModel.getSubCategories(_cat);
                    },
                    items: categoryListViewModel.category.map((category) {
                          return DropdownMenuItem(
                              value: category.id.toString(),
                              child: lang == 'en'
                                  ? Text(
                                      category.nameEn,
                                      style: const TextStyle(color: yellow),
                                    )
                                  : Text(
                                      category.nameAr,
                                      style: const TextStyle(color: yellow),
                                    ));
                        }).toList() ??
                        [],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  _subCat(SubCategoryViewModel subCategoryViewModel) {
    if (subCategoryViewModel.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: const CircularProgressIndicator(),
      );
    }

    return Container(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .05, 0,
            MediaQuery.of(context).size.width * .05, 0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    value: _subcat,
                    iconSize: 30,
                    icon: const Icon(Icons.add),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text(getLang(context, "Subcategory"),
                        style: TextStyle(color: yellow)),
                    onChanged: (String newValue) {
                      setState(() {
                        _subcat = newValue;

                        // insertBrand(proID, _brand);
                      });
                    },
                    items: subCategoryViewModel.subCategory.map((subCategory) {
                          return DropdownMenuItem(
                              value: subCategory.id.toString(),
                              child: lang == 'en'
                                  ? Text(
                                      subCategory.nameEn,
                                      style: const TextStyle(color: yellow),
                                    )
                                  : Text(
                                      subCategory.nameAr,
                                      style: const TextStyle(color: yellow),
                                    ));
                        }).toList() ??
                        [],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  detailsUi() {
    return Container(
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .05, 0,
          MediaQuery.of(context).size.width * .05, 0),
      color: Colors.grey[900],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _keynameEn,
              child: TextFormField(
                style: const TextStyle(
                  color: black,
                ),
                cursorColor: blue,
                controller: storeNameEn,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return getLang(context, "FieldRequired");
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    getLang(context, "NameinEnglish"),
                    null,
                    const Icon(
                      Icons.store,
                      color: yellow,
                    )),
              ),
            ),
          ),
          sizedBoxHomePage(10),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Text(
              getLang(context, "optional*"),
              style: const TextStyle(color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _keynameAr,
              child: TextFormField(
                style: const TextStyle(
                  color: black,
                ),
                cursorColor: blue,
                controller: storeNameAr,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return getLang(context, "FieldRequired");
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    getLang(context, "NameinArabic"),
                    null,
                    const Icon(
                      Icons.store,
                      color: yellow,
                    )),
              ),
            ),
          ),
          sizedBoxHomePage(10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _keyPhone,
              child: TextFormField(
                style: const TextStyle(
                  color: black,
                ),
                cursorColor: blue,
                controller: storePhone,
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
                    getLang(context, "phone"),
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _keyMail,
              child: TextFormField(
                style: const TextStyle(
                  color: black,
                ),
                cursorColor: blue,
                controller: storeMail,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  if (val.isEmpty) {
                    return getLang(context, "FieldRequired");
                  }
                  if (val.length > 50) {
                    return getLang(context, "validateless50");
                  } else if (!regex.hasMatch(val)) {
                    return getLang(context, "Entervalidemail");
                  } else {
                    storeMail.text = val;
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    getLang(context, "Email"),
                    null,
                    const Icon(
                      Icons.mail,
                      color: yellow,
                    )),
              ),
            ),
          ),
          sizedBoxHomePage(10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _keyAddress,
              child: TextFormField(
                style: const TextStyle(
                  color: black,
                ),
                cursorColor: blue,
                controller: storeAddress,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return getLang(context, "FieldRequired");
                  } else {
                    storeAddress.text = val;
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    getLang(context, "Address"),
                    null,
                    const Icon(
                      Icons.location_city,
                      color: yellow,
                    )),
              ),
            ),
          ),
          sizedBoxHomePage(10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _keydescEn,
              child: TextFormField(
                style: const TextStyle(
                  color: black,
                ),
                cursorColor: blue,
                controller: storeDescEn,
                maxLines: 10,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return getLang(context, "FieldRequired");
                  } else {
                    storeDescEn.text = val;
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context, getLang(context, "Description"), null, null),
              ),
            ),
          ),
          sizedBoxHomePage(10),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Text(
              getLang(context, "optional*"),
              style: const TextStyle(color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _keydescAr,
              child: TextFormField(
                style: const TextStyle(
                  color: black,
                ),
                cursorColor: blue,
                controller: storeDescAr,
                maxLines: 10,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return getLang(context, "FieldRequired");
                  } else {
                    storeDescEn.text = val;
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(context,
                    getLang(context, "Description(Arabic)"), null, null),
              ),
            ),
          ),
          sizedBoxHomePage(10),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: GestureDetector(
              onTap: () async {
                String nameEn = storeNameEn.text;
                String nameAr = storeNameAr.text;
                String phone = storePhone.text;
                String mail = storeMail.text;
                String address = storeAddress.text;
                String descEn = storeDescEn.text;
                String descAr = storeDescAr.text;
                await imageBase64();

                if (_keynameEn.currentState.validate() &&
                    _keyPhone.currentState.validate() &&
                    _keyMail.currentState.validate() &&
                    _keyAddress.currentState.validate() &&
                    _keydescEn.currentState.validate() &&
                    _subcat != null &&
                    _cat != null) {
                  await AddServiceApi.addService(
                      _subcat,
                      nameEn,
                      nameAr,
                      phone,
                      mail,
                      address,
                      descEn,
                      descAr,
                      widget.userID,
                      funtions.lat,
                      funtions.long,
                      image,
                      imageDecode,
                      context);
                } else if (_cat == null || _subcat == null) {
                  Fluttertoast.showToast(
                      msg: getLang(context, "PleaseSelectCategory"),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: submit(context, getLang(context, "submit"), yellow),
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
