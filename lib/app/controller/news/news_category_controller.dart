import 'dart:async';
import 'package:flutter_ithome/app/controller/base_controller.dart';
import 'package:flutter_ithome/model/news_banner_model.dart';
import 'package:flutter_ithome/model/news_item_model.dart';
import 'package:flutter_ithome/request/news_request.dart';
import 'package:get/get.dart';

class NewsCategoryController extends BasePageController<NewsItemModel> {
  final String categoryId;
  NewsCategoryController(this.categoryId);

  final NewsRequest request = NewsRequest();

  RxList<NewsItemModel> topNews = <NewsItemModel>[].obs;

  RxList<NewsBannerModel> banner = <NewsBannerModel>[].obs;

  StreamSubscription<dynamic>? streamSubscription;

  @override
  void onInit() {
    refreshData();
    super.onInit();
  }

  @override
  Future<List<NewsItemModel>> getData(int page, int pageSize) async {
    var ot = "";
    if (page != 1) {
      ot = list.last.orderdate.millisecondsSinceEpoch.toString();
      return await request.getNewsMore(ot: ot, tag: categoryId);
    } else {
      return await request.getNews(tag: categoryId);
    }
  }
}
