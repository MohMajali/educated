import 'package:educatednearby/models/chance.dart';
import 'package:educatednearby/services/chances.dart';
import 'package:flutter/material.dart';

import '../repo.dart';

class ChanceViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Chance> _chance = [];

  bool get loading => _loading;
  List<Chance> get chance => _chance;

  ChanceViewModel() {
    getChance();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setChanceList(List<Chance> chance) {
    _chance = chance;
  }

  getChance() async {
    setLoading(true);
    var response = await ChancsesApi.getChance();

    if (response is Success) {
      setChanceList(response.response as List<Chance>);
    }
    if (response is Failure) {
      return response.errorResponse;
    }
    setLoading(false);
  }
}
