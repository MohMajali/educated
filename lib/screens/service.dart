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

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  int id = sharedPreferences.getInt("userID");
  double distance;
  List<Widget> stores = new List<Widget>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    funtions.getPer(context);
  }

  @override
  Widget build(BuildContext context) {
    CategoryViewModel categoryViewModel = context.watch<CategoryViewModel>();
    SubCategoryViewModel subCategoryViewModel =
        context.watch<SubCategoryViewModel>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          title: const Text("Educated Nearby"),
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
              _categoryUi(categoryViewModel, subCategoryViewModel),
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
        height: MediaQuery.of(context).size.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (categoryViewModel.category.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
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
                margin: const EdgeInsets.only(left: 15, right: 15),
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

  // _categoryUi(
  //     CategoryViewModel categoryViewModel,
  //     SubCategoryViewModel subCategoryViewModel,
  //     StoreViewModel storeViewModel) {
  //   bool _customTileExpanded = false;
  //   if (categoryViewModel.loading) {
  //     return SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.1,
  //       child: const CircularProgressIndicator(),
  //     );
  //   }

  //   if (categoryViewModel.category.isEmpty) {
  //     return SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.1,
  //       child: const Text("No Data to show"),
  //     );
  //   } else {
  //     return ListView.builder(
  //       scrollDirection: Axis.vertical,
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemBuilder: (context, index) {
  //         Category category = categoryViewModel.category[index];
  //         return ExpansionTile(
  //           onExpansionChanged: (value) async {
  //             setState(() => _customTileExpanded = value);
  //             int id = category.id;
  //             value ? await subCategoryViewModel.getSubCategories(id) : null;
  //           },
  //           title: ListTile(
  //             title: Text(
  //               category.nameEn,
  //               style: const TextStyle(color: Colors.white, fontSize: 20),
  //             ),
  //             onTap: () {},
  //           ),
  //           trailing: Icon(
  //             _customTileExpanded ? Icons.expand_more : Icons.expand_more,
  //           ),
  //           children: [_subCategoryUi(subCategoryViewModel, storeViewModel)],
  //         );
  //       },
  //       itemCount: null == categoryViewModel.category
  //           ? 0
  //           : categoryViewModel.category.length,
  //     );
  //   }
  // }

  // _subCategoryUi(SubCategoryViewModel subCategoryViewModel,
  //     StoreViewModel storeViewModel) {
  //   bool _customTileExpanded = false;
  //   if (subCategoryViewModel.loading) {
  //     return SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.1,
  //       child: const CircularProgressIndicator(),
  //     );
  //   }

  //   if (subCategoryViewModel.subCategory.isEmpty) {
  //     return SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.1,
  //       child: const Text("No Data to show"),
  //     );
  //   } else {
  //     return ListView.builder(
  //       scrollDirection: Axis.vertical,
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemBuilder: (_, index) {
  //         Subcategory subcategory = subCategoryViewModel.subCategory[index];

  //         return ExpansionTile(
  //           onExpansionChanged: (value) async {
  //             setState(() => _customTileExpanded = value);
  //             int id = subcategory.id;
  //             value ? _storeUi(storeViewModel, id) : null;
  //           },
  //           title: ListTile(
  //             title: Text(
  //               subcategory.nameEn,
  //               style: const TextStyle(color: Colors.white, fontSize: 20),
  //             ),
  //             onTap: () {
  //               // print(_storeUi(storeViewModel));
  //             },
  //           ),
  //           trailing: Icon(
  //             _customTileExpanded ? Icons.expand_more : Icons.expand_more,
  //           ),
  //           children: stores.isEmpty ? [const Text('No Data to show')] : stores,
  //         );
  //       },
  //       itemCount: null == subCategoryViewModel.subCategory
  //           ? 0
  //           : subCategoryViewModel.subCategory.length,
  //     );
  //   }
  // }

  // _storeUi(StoreViewModel storeViewModel, int id) async {
  //   await storeViewModel.getStore(id);
  //   bool _customTileExpanded = false;
  //   if (storeViewModel.loading) {
  //     return SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.1,
  //       child: const CircularProgressIndicator(),
  //     );
  //   }

  //   if (storeViewModel.store.isEmpty) {
  //     return SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.1,
  //       child: const Text("No Data to show"),
  //     );
  //   }
  //   stores.clear();
  // for (final store in storeViewModel.store) {
  //   distance = Geolocator.distanceBetween(
  //       lat, long, store.latitude, store.longitude);
  //   int indistance = distance.round().toInt();
  //   double distanceInKilo = indistance / 1000;

  //   if (distanceInKilo <= 3) {
  //     stores.add(Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: ListTile(
  //         title: Text(
  //           store.nameEn,
  //           style: const TextStyle(color: yellow, fontSize: 20),
  //         ),
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => SingleServiceScreen(
  //                       logo: store.logo,
  //                       nameEn: store.nameEn,
  //                       email: store.email,
  //                       phone: store.phone,
  //                       descEn: store.descEn,
  //                       descAr: store.descAr,
  //                       lat: store.latitude,
  //                       long: store.longitude,
  //                     )),
  //           );
  //         },
  //       ),
  //     ));
  //   }
  // }
  // }
}
