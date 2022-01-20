import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/drawer/home_drawer.dart';
import 'package:educatednearby/drawer/logindrawer.dart';
import 'package:educatednearby/fun/goto.dart';
import 'package:educatednearby/models/category.dart';
import 'package:educatednearby/screens/subcategroy.dart';
import 'package:educatednearby/view_model/category_view.dart';
import 'package:educatednearby/view_model/subcat_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';
import 'addservice.dart';

class CategoryScreen extends StatefulWidget {
  final int serviceID;
  const CategoryScreen({Key key, this.serviceID}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int id = sharedPreferences.getInt("userID");
  @override
  Widget build(BuildContext context) {
    CategoryViewModel categoryViewModel = context.watch<CategoryViewModel>();
    SubCategoryViewModel subCategoryViewModel =
        context.watch<SubCategoryViewModel>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          title: const Text("Category"),
          backgroundColor: yellow,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  if (id == null) {
                    _showAlert("Please log in first");
                  } else {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddService(
                                  userID: id,
                                  latitude: funtions.lat,
                                  langitude: funtions.long,
                                )));
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ),
        drawer: id == null
            ? HomeDrawer()
            : HomeDrawerLogin(
                id: id,
              ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              _categoryUi(categoryViewModel, subCategoryViewModel)
            ],
          ),
        ));
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

  _categoryUi(CategoryViewModel categoryViewModel,
      SubCategoryViewModel subCategoryViewModel) {
    if (categoryViewModel.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: const CircularProgressIndicator(),
      );
    }

    if (categoryViewModel.category.isEmpty) {
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
          itemCount: null == categoryViewModel.category
              ? 0
              : categoryViewModel.category.length,
          itemBuilder: (context, index) {
            Category category = categoryViewModel.category[index];
            return InkWell(
              onTap: () async {
                await subCategoryViewModel.getSubCategories(category.id);
                // Navigator.of(context).pop();
                funtions.push(context, const SubCategoryScreen());
              },
              child: Container(
                margin: const EdgeInsets.only(left: 15),
                alignment: Alignment.center,
                child: Text(category.nameEn),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
              ),
            );
          });
    }
  }
}
