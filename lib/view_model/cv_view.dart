import 'package:educatednearby/models/cvs.dart';
import 'package:educatednearby/services/cv.dart';
import 'package:flutter/cupertino.dart';

import '../repo.dart';

class CvViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Cvs> _cv = [];

  bool get loading => _loading;
  List<Cvs> get cv => _cv;

  // CVViewModel() {
  //   getBanners();
  // }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCVList(List<Cvs> cv) {
    _cv = cv;
  }

  getCVs(int id) async {
    setLoading(true);
    var response = await CVApi.getCV(id);

    if (response is Success) {
      setCVList(response.response as List<Cvs>);
    }
    if (response is Failure) {
      return response.errorResponse;
    }
    setLoading(false);
  }
}
