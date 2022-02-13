import 'package:cached_network_image/cached_network_image.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/constant/urls.dart';
import 'package:educatednearby/models/subcat.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/screens/map_screen.dart';
import 'package:educatednearby/screens/service.dart';
import 'package:educatednearby/screens/storescreen.dart';
import 'package:educatednearby/view_model/store_view.dart';
import 'package:educatednearby/view_model/subcat_view.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';

class SubCategoryScreen extends StatefulWidget {
  final int id;
  const SubCategoryScreen({Key key, this.id}) : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _number = 1;
  var lang = sharedPreferences.getString("lang");
  int currentTsb = 0;
  Widget currentScreen = const ServiceScreen();
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    SubCategoryViewModel subCategoryViewModel =
        context.watch<SubCategoryViewModel>();
    StoreViewModel storeViewModel = context.watch<StoreViewModel>();
    return Scaffold(
      // key: scaffoldKey,
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(getLang(context, "Subcategory")),
        backgroundColor: yellow,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // PageStorage(
            //   child: currentScreen,
            //   bucket: bucket,
            // ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberPicker(
                    axis: Axis.horizontal,
                    minValue: 0,
                    maxValue: 50,
                    haptics: true,
                    value: _number,
                    textStyle: const TextStyle(color: yellow),
                    onChanged: (value) => setState(() => _number = value)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _number.toString() + ' ' + getLang(context, "Kilos"),
              style: const TextStyle(color: yellow),
            ),
            const SizedBox(
              height: 10,
            ),
            _subcatUi(subCategoryViewModel, storeViewModel)
          ],
        ),
      ),
    );
  }

  _subcatUi(SubCategoryViewModel subCategoryViewModel,
      StoreViewModel storeViewModel) {
    if (subCategoryViewModel.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (subCategoryViewModel.subCategory.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Text(getLang(context, "nodata")),
      );
    } else {
      return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 4,
        ),
        itemBuilder: (_, index) {
          Subcategory subCategory = subCategoryViewModel.subCategory[index];

          return InkWell(
            onTap: () async {
              setState(() {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheetLocation(
                      getLang(context, "option"),
                      storeViewModel,
                      subCategory.id,
                      subCategoryViewModel)),
                );
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      // offset: const Offset(3, 3),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: subCategory.imagePath == null
                            ? Image.asset(
                                "assets/images/educationlogo.png",
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    Api.subcategoryurl + subCategory.imagePath,
                                placeholder: (context, url) => Container(
                                    child: const Center(
                                        child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: Container(
                          color: yellow,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: lang == 'en'
                                        ? subCategory.nameEn
                                        : subCategory.nameAr,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: null == subCategoryViewModel.subCategory
            ? 0
            : subCategoryViewModel.subCategory.length,
      );
    }
  }

  Widget bottomSheetLocation(String text, StoreViewModel storeViewModel, int id,
      SubCategoryViewModel subCategoryViewModel) {
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
            text,
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
              icon: const Icon(Icons.map),
              onPressed: () async {
                await storeViewModel.getStore(id);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapScreen(
                            distances: _number,
                            id: id,
                          )),
                ).then((value) {
                  setState(() {
                    if (value == true) {
                      subCategoryViewModel.getSubCategories(widget.id);
                    } else {
                      null;
                    }
                  });
                });
              },
              label: Text(getLang(context, "Maps"),
                  style: const TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
            FlatButton.icon(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                await storeViewModel.getStore(id);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoreScreen(
                            distance: _number,
                            id: id,
                          )),
                ).then((value) {
                  setState(() {
                    if (value == true) {
                      subCategoryViewModel.getSubCategories(widget.id);
                    } else {
                      null;
                    }
                  });
                });
              },
              label: Text(getLang(context, "ListView"),
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
