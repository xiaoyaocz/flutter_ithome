import 'package:flutter/cupertino.dart';
import 'package:flutter_ithome/model/news_banner_model.dart';
import 'package:flutter_ithome/model/news_detail_model.dart';
import 'package:flutter_ithome/model/news_item_model.dart';
import 'package:flutter_ithome/request/api.dart';
import 'package:flutter_ithome/request/http_client.dart';

class NewsRequest {
  /// 置顶的新闻
  Future<List<NewsItemModel>> getTopNews() async {
    var url = "${Api.kApiBaseUrl}/json/newslist/news";
    var result = await HttpClient.instance.getJson(
      url,
      queryParameters: {"r": 0},
    );
    var ls = <NewsItemModel>[];
    for (var item in result?["toplist"] ?? []) {
      ls.add(NewsItemModel.fromJson(item));
    }
    return ls;
  }

  /// Banner
  Future<List<NewsBannerModel>> getBanner() async {
    var url = "${Api.kApiBaseUrl}/json/slide/index";
    var result = await HttpClient.instance.getJson(
      url,
      queryParameters: {},
    );
    var ls = <NewsBannerModel>[];
    for (var item in result) {
      ls.add(NewsBannerModel.fromJson(item));
    }
    return ls;
  }

  /// 新闻
  /// * [ot] 分页参数
  /// * [tag] 分类ID
  Future<List<NewsItemModel>> getNews({
    String tag = "news",
  }) async {
    // 处理分类ID
    if (tag.endsWith("m")) {
      tag = tag.substring(0, tag.length - 1);
    }

    var url = "${Api.kApiBaseUrl}/json/newslist/$tag";
    var result = await HttpClient.instance.getJson(
      url,
      queryParameters: {
        'r': DateTime.now().millisecondsSinceEpoch,
      },
    );
    var ls = <NewsItemModel>[];
    for (var item in result?["newslist"] ?? []) {
      ls.add(NewsItemModel.fromJson(item));
    }
    return ls;
  }

  /// 加载更多新闻
  /// * [ot] 分页参数
  /// * [tag] 分类ID
  Future<List<NewsItemModel>> getNewsMore({
    String ot = "",
    String tag = "",
    int page = 0,
  }) async {
    var url = "${Api.kWebApiBaseUrl}/api/news/newslistpageget";
    var result = await HttpClient.instance.getJson(
      url,
      queryParameters: {
        "Tag": tag,
        "ot": ot,
        "page": page,
        "hitCountAuthority": false,
      },
    );
    var ls = <NewsItemModel>[];
    for (var item in result?["Result"] ?? []) {
      ls.add(NewsItemModel.fromMJson(item));
    }
    return ls;
  }

  /// 新闻详情
  /// * [newsId] 新闻ID
  Future<NewsDetailModel> getNewsDetail({
    required int newsId,
  }) async {
    var url = "${Api.kApiBaseUrl}/json/newscontent/$newsId";
    var result = await HttpClient.instance.getJson(
      url,
    );
    return NewsDetailModel.fromJson(result);
  }
}
