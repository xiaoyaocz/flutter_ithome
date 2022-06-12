import 'package:flutter_ithome/storage/news_collect.dart';
import 'package:flutter_ithome/storage/news_history.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppStorageService extends GetxService {
  static AppStorageService get instance => Get.find<AppStorageService>();

  late Box<NewsHistory> newsHistoryBox;
  late Box<NewsCollect> newsCollectBox;

  Future init() async {
    newsHistoryBox = await Hive.openBox("NewsHistory");
    newsCollectBox = await Hive.openBox("NewsCollect");
  }

  bool existNewsHistory(int newsId) {
    return newsHistoryBox.containsKey(newsId);
  }

  bool existNewsCollect(int newsId) {
    return newsCollectBox.containsKey(newsId);
  }

  void insertNewsHistory(int newsId,
      {required String url, required String title, required String image}) {
    if (existNewsHistory(newsId)) {
      //已存在记录,更新日期
      var value = newsHistoryBox.get(newsId);
      value!.addDate = DateTime.now();
      newsHistoryBox.put(newsId, value);
    } else {
      var value = NewsHistory();
      value.id = newsId;
      value.url = url;
      value.title = title;
      value.image = image;
      value.addDate = DateTime.now();
      newsHistoryBox.put(newsId, value);
    }
  }

  void insertNewsCollect(int newsId,
      {required String url, required String title, required String image}) {
    if (existNewsCollect(newsId)) {
      //已存在记录,更新日期
      var value = newsCollectBox.get(newsId);
      value!.addDate = DateTime.now();
      newsCollectBox.put(newsId, value);
    } else {
      var value = NewsCollect();
      value.id = newsId;
      value.url = url;
      value.title = title;
      value.image = image;
      value.addDate = DateTime.now();
      newsCollectBox.put(newsId, value);
    }
  }

  void deleteNewsHistory(int newsId) {
    newsHistoryBox.delete(newsId);
  }

  void deleteNewsCollect(int newsId) {
    newsCollectBox.delete(newsId);
  }
}
