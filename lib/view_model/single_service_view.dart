import 'package:educatednearby/models/service.dart';
import 'package:educatednearby/models/store.dart';
import 'package:educatednearby/services/services.dart';
import 'package:educatednearby/services/stores.dart';
import 'package:flutter/cupertino.dart';

import '../repo.dart';

class SingleServiceModel extends ChangeNotifier {
  bool _loading = false;
  List<Store> _services = [];

  bool get loading => _loading;
  List<Store> get services => _services;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setServicesList(List<Store> service) {
    _services = service;
  }

  getService(var id) async {
    setLoading(true);
    var response = await StoresApi.getService(id);

    if (response is Success) {
      setServicesList(response.response as List<Store>);
    }
    if (response is Failure) {
      return response.errorResponse;
    }
    setLoading(false);
  }
}
