import 'package:educatednearby/models/subcat.dart';
import 'package:educatednearby/services/subcategories.dart';
import 'package:flutter/cupertino.dart';
import '../repo.dart';

class SubCategoryViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Subcategory> _subCategory = [];

  bool get loading => _loading;
  List<Subcategory> get subCategory => _subCategory;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setSubCategoryList(List<Subcategory> subCategory) {
    _subCategory = subCategory;
  }

  getSubCategories(var id) async {
    setLoading(true);
    var response = await SubCategoryApi.getSubCats(id);

    if (response is Success) {
      setSubCategoryList(response.response as List<Subcategory>);
    }
    if (response is Failure) {
      return response.errorResponse;
    }
    setLoading(false);
  }
}
