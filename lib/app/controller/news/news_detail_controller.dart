import 'package:flutter_ithome/app/common/log.dart';
import 'package:flutter_ithome/app/common/utils.dart';
import 'package:flutter_ithome/app/controller/base_controller.dart';
import 'package:flutter_ithome/request/news_request.dart';
import 'package:get/get.dart';

class NewsDetailControler extends BaseController {
  final int newsId;
  NewsDetailControler(
    this.newsId,
  );
  var title = "".obs;
  var content = "".obs;
  var postTime = "0000-00-00 00-00".obs;
  var source = "IT之家".obs;
  var author = "--".obs;
  var head = "".obs;
  final NewsRequest request = NewsRequest();
  @override
  void onInit() {
    loadDetail();
    super.onInit();
  }

  void loadDetail() async {
    pageLoadding.value = true;
    try {
      var model = await request.getNewsDetail(newsId: newsId);
      title.value = model.title;
      content.value = model.detail;
      postTime.value =
          Utils.dateFormatWithYear.format(model.postdate ?? DateTime(1900));
      source.value = model.newssource;
      author.value = model.newsauthor;
      head.value = model.z ?? "";
      Log.d(content.value);
    } catch (e) {
      pageError.value = true;
    } finally {
      pageLoadding.value = false;
    }
  }
}
