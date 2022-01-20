import 'package:educatednearby/models/news.dart';
import 'package:educatednearby/services/news.dart';
import 'package:flutter/cupertino.dart';

import '../repo.dart';

class NewsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<News> _news = [];

  bool get loading => _loading;
  List<News> get news => _news;

  NewsViewModel() {
    getNews();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setNewsList(List<News> news) {
    _news = news;
  }

  getNews() async {
    setLoading(true);
    var response = await NewsApi.getNews();

    if (response is Success) {
      setNewsList(response.response as List<News>);
    }
    if (response is Failure) {
      return response.errorResponse;
    }
    setLoading(false);
  }
}
