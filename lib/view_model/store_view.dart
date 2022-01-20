import 'package:educatednearby/models/store.dart';
import 'package:educatednearby/services/stores.dart';
import 'package:flutter/cupertino.dart';

import '../repo.dart';

class StoreViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Store> _store = [];

  bool get loading => _loading;
  List<Store> get store => _store;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setStoreList(List<Store> store) {
    _store = store;
  }

  getStore(int storeId) async {
    setLoading(true);
    var response = await StoresApi.getStores(storeId);

    if (response is Success) {
      setStoreList(response.response as List<Store>);
    }
    if (response is Failure) {
      return response.errorResponse;
    }
    setLoading(false);
  }
}
