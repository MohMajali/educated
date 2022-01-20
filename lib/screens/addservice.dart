import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/screens/service.dart';
import 'package:educatednearby/services/addservice.dart';
import 'package:educatednearby/view_model/category_view.dart';
import 'package:educatednearby/view_model/dropcatlist.dart';
import 'package:educatednearby/view_model/service_view.dart';
import 'package:educatednearby/view_model/subcat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    ServiceViewModel serviceViewModel = context.watch<ServiceViewModel>();
    CategoryListViewModel categoryListViewModel = context.watch<CategoryListViewModel>();
    SubCategoryViewModel subCategoryViewModel =
        context.watch<SubCategoryViewModel>();
    return Scaffold(
        backgroundColor: Colors.grey[500],
        appBar: AppBar(
          title: const Text("Add Service"),
          backgroundColor: yellow,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context,true);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const ServiceScreen()),
              // );
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            _serviceUi(
                serviceViewModel, categoryListViewModel, subCategoryViewModel),
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

  _serviceUi(
      ServiceViewModel serviceViewModel,
      CategoryListViewModel categoryViewModel,
      SubCategoryViewModel subCategoryViewModel) {
    if (serviceViewModel.loading) {
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
                    value: _sevice,
                    iconSize: 30,
                    icon: const Icon(Icons.add),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint:
                        const Text("Service", style: TextStyle(color: yellow)),
                    onChanged: (String newValue) {
                      setState(() {
                        _sevice = newValue;
                        _cat = null;
                        _subcat = null;

                        categoryViewModel.getCategories(_sevice);
                      });
                    },
                    items: serviceViewModel.services.map((service) {
                          return DropdownMenuItem(
                              value: service.id.toString(),
                              child: Text(
                                service.nameEn,
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

  _categoryUi(CategoryListViewModel categoryViewModel,
      SubCategoryViewModel subCategoryViewModel) {
    if (categoryViewModel.loading) {
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
                    hint:
                        const Text("Category", style: TextStyle(color: yellow)),
                    onChanged: (String newValue) {
                      setState(() {
                        _cat = newValue;
                        _subcat = null;

                        subCategoryViewModel.getSubCategories(_cat);
                      });
                    },
                    items: categoryViewModel.category.map((category) {
                          return DropdownMenuItem(
                              value: category.id.toString(),
                              child: Text(
                                category.nameEn,
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
                    hint: const Text("Sub Category",
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
                              child: Text(
                                subCategory.nameEn,
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
      color: Colors.grey[500],
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
                    return "Field Required";
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    "Name in English",
                    null,
                    const Icon(
                      Icons.store,
                      color: yellow,
                    )),
              ),
            ),
          ),
          sizedBoxHomePage(10),
          const Padding(
            padding: EdgeInsets.only(right: 200),
            child: Text(
              "optional*",
              style: TextStyle(color: Colors.red),
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
                    return "Field Required";
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    "Name in Arabic",
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
                    return "Field Required";
                  } else if (val.length != 10) {
                    return "Phone number mustbe 10 digits";
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    "Phone Number",
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
                    return "Field Required";
                  }
                  if (val.length > 50) {
                    return "validate less 50";
                  } else if (!regex.hasMatch(val)) {
                    return "Enter valid email";
                  } else {
                    storeMail.text = val;
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    "Store/User Email",
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
                    return "Field Required";
                  } else {
                    storeAddress.text = val;
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    "Store/User Address",
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
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Field Required";
                  } else {
                    storeDescEn.text = val;
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    "Store/User Description",
                    null,
                    const Icon(
                      Icons.location_city,
                      color: yellow,
                    )),
              ),
            ),
          ),
          sizedBoxHomePage(10),
          const Padding(
            padding: EdgeInsets.only(right: 200),
            child: Text(
              "optional*",
              style: TextStyle(color: Colors.red),
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
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Field Required";
                  } else {
                    storeDescEn.text = val;
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context,
                    "Description(Arabic)",
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

                if (_keynameEn.currentState.validate() &&
                    _keyPhone.currentState.validate() &&
                    _keyMail.currentState.validate() &&
                    _keyAddress.currentState.validate() &&
                    _keydescEn.currentState.validate() &&
                    _subcat != null) {
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
                      widget.latitude,
                      widget.langitude,
                      "hi",
                      context);
                  print(widget.latitude);
                } else {
                  Fluttertoast.showToast(
                      msg: "Please Select Category",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: submit(context, "Submit"),
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
