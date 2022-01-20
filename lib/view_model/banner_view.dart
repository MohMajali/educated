import 'package:educatednearby/models/banner.dart';
import 'package:educatednearby/services/banners.dart';
import 'package:flutter/cupertino.dart';

import '../repo.dart';

class BannerViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Banners> _banner = [];

  bool get loading => _loading;
  List<Banners> get banner => _banner;

  BannerViewModel() {
    getBanners();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setBannerList(List<Banners> banner) {
    _banner = banner;
  }

  getBanners() async {
    setLoading(true);
    var response = await BannerApi.getBanners();

    if (response is Success) {
      setBannerList(response.response as List<Banners>);
    }
    if (response is Failure) {
      return response.errorResponse;
    }
    setLoading(false);
  }
}
