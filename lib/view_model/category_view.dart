import 'package:educatednearby/models/category.dart';
import 'package:educatednearby/services/categories.dart';
import 'package:flutter/cupertino.dart';

import '../repo.dart';

class CategoryViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Category> _category = [];

  bool get loading => _loading;
  List<Category> get category => _category;

  CategoryViewModel() {
    getCategories();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCategoryList(List<Category> category) {
    _category = category;
  }

  getCategories() async {
    setLoading(true);
    var response = await CategoryApi.getCategory();

    if (response is Success) {
      setCategoryList(response.response as List<Category>);
    }
    if (response is Failure) {
      return response.errorResponse;
    }
    setLoading(false);
  }
}
