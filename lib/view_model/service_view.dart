import 'package:educatednearby/models/service.dart';
import 'package:educatednearby/services/services.dart';
import 'package:flutter/cupertino.dart';

import '../repo.dart';

class ServiceViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Services> _services = [];

  bool get loading => _loading;
  List<Services> get services => _services;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setServicesList(List<Services> service) {
    _services = service;
  }

  getService() async {
    setLoading(true);
    var response = await ServicesApi.getService();

    if (response is Success) {
      setServicesList(response.response as List<Services>);
    }
    if (response is Failure) {
      return response.errorResponse;
    }
    setLoading(false);
  }
}
