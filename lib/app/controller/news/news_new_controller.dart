import 'dart:async';

import 'package:flutter_ithome/app/common/event_bus.dart';
import 'package:flutter_ithome/app/controller/base_controller.dart';
import 'package:flutter_ithome/model/news_banner_model.dart';
import 'package:flutter_ithome/model/news_item_model.dart';
import 'package:flutter_ithome/request/news_request.dart';
import 'package:get/get.dart';

class NewsNewController extends BasePageController<NewsItemModel> {
  final NewsRequest request = NewsRequest();

  RxList<NewsItemModel> topNews = <NewsItemModel>[].obs;

  RxList<NewsBannerModel> banner = <NewsBannerModel>[].obs;

  StreamSubscription<dynamic>? streamSubscription;

  StreamSubscription<dynamic>? refreshNewsItemStreamSubscription;

  @override
  void onInit() {
    streamSubscription =
        EventBus.instance.listen(EventBus.kEventRefreshNews, (e) {
      refreshData();
    });
    refreshNewsItemStreamSubscription =
        EventBus.instance.listen(EventBus.kEventRefreshNewsItem, (e) {
      update();
    });
    refreshData();
    super.onInit();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    refreshNewsItemStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Future refreshData() {
    loadBannerAndTopNews();

    return super.refreshData();
  }

  void loadBannerAndTopNews() async {
    banner.value = await request.getBanner();
    topNews.value = await request.getTopNews();
    update();
  }

  @override
  Future<List<NewsItemModel>> getData(int page, int pageSize) async {
    var ot = "";
    if (page != 1) {
      ot = list.last.orderdate.millisecondsSinceEpoch.toString();
      return await request.getNewsMore(
        ot: ot,
      );
    } else {
      return await request.getNews();
    }
  }

  //https://api.ithome.com/json/slide/index
  //https://api.ithome.com/json/newslist/news
  //https://api.ithome.com/json/listpage/news/F128C9CBE944FE0BB09282B01FAC69E3
}
