import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/fun/goto.dart';
import 'package:educatednearby/models/subcat.dart';
import 'package:educatednearby/screens/category.dart';
import 'package:educatednearby/screens/map_screen.dart';
import 'package:educatednearby/screens/service.dart';
import 'package:educatednearby/screens/storescreen.dart';
import 'package:educatednearby/view_model/store_view.dart';
import 'package:educatednearby/view_model/subcat_view.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/src/provider.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key key}) : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _number = 1;
  @override
  Widget build(BuildContext context) {
    SubCategoryViewModel subCategoryViewModel =
        context.watch<SubCategoryViewModel>();
    StoreViewModel storeViewModel = context.watch<StoreViewModel>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          title: const Text("Subcategory"),
          backgroundColor: yellow,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                      onChanged: (value) => setState(() => _number = value)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(_number.toString() + " Kilos"),
              const SizedBox(
                height: 10,
              ),
              _subcatUi(subCategoryViewModel, storeViewModel)
            ],
          ),
        ));
  }

  _subcatUi(SubCategoryViewModel subCategoryViewModel,
      StoreViewModel storeViewModel) {
    if (subCategoryViewModel.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: const CircularProgressIndicator(),
      );
    }

    if (subCategoryViewModel.subCategory.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: const Text("No Data to show"),
      );
    } else {
      return GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: null == subCategoryViewModel.subCategory
              ? 0
              : subCategoryViewModel.subCategory.length,
          itemBuilder: (context, index) {
            Subcategory subCategory = subCategoryViewModel.subCategory[index];
            return InkWell(
              onTap: () async {
                // await storeViewModel.getStore(subCategory.id);
                // Navigator.of(context).pop();
                // funtions.push(
                //     context,
                //     StoreScreen(
                //       distance: _number,
                //     ));
                setState(() {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheetLocation(
                        "Choose option", storeViewModel, subCategory.id)),
                  );
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 15),
                alignment: Alignment.center,
                child: Text(subCategory.nameEn),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
              ),
            );
          });
    }
  }

  Widget bottomSheetLocation(
      String text, StoreViewModel storeViewModel, int id) {
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
                // await storeViewModel.getStore(id);
                funtions.push(
                    context,
                    MapScreen(
                      id: id,
                      distances: _number,
                    ));
              },
              label: const Text("Maps",
                  style: TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
            FlatButton.icon(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                await storeViewModel.getStore(id);
                funtions.push(
                    context,
                    StoreScreen(
                      distance: _number,
                    ));
              },
              label: const Text("ListView",
                  style: TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
          ])
        ],
      ),
    );
  }
}
