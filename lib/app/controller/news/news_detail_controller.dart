import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/common/app_navigator.dart';
import 'package:flutter_ithome/app/common/app_style.dart';
import 'package:flutter_ithome/app/common/log.dart';
import 'package:flutter_ithome/app/common/utils.dart';
import 'package:flutter_ithome/app/controller/base_controller.dart';
import 'package:flutter_ithome/app/service/app_settings_service.dart';
import 'package:flutter_ithome/app/service/app_storage_service.dart';
import 'package:flutter_ithome/request/news_request.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:share_plus/share_plus.dart';

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
  var url = "";
  var fontSize = 16.0.obs;
  var commentCount = 0.obs;
  var image = "";
  var collected = false.obs;

  final NewsRequest request = NewsRequest();
  @override
  void onInit() {
    fontSize.value = AppSettingsService.instance
        .getValue(AppSettingsService.kReadFontSize, 16.0);
    loadDetail();
    super.onInit();
  }

  void loadDetail() async {
    pageLoadding.value = true;
    update();
    try {
      var model = await request.getNewsDetail(newsId: newsId);
      title.value = model.title;
      content.value = model.detail;
      postTime.value =
          Utils.dateFormatWithYear.format(model.postdate ?? DateTime(1900));
      source.value = model.newssource;
      author.value = model.newsauthor;
      head.value = model.z ?? "";
      url = model.url;
      image = model.image;
      collected.value = AppStorageService.instance.existNewsCollect(newsId);
      getCommentCount();
    } catch (e) {
      pageError.value = true;
    } finally {
      pageLoadding.value = false;
      update();
    }
  }

  void getCommentCount() async {
    try {
      commentCount.value = await request.getNewsCommentCount(newsId: newsId);
    } finally {}
    //https://cmt.ithome.com/api/comment/getcount?sn=C74D01E9556F2E9B
    //https://cmt.ithome.com/api/comment/hot?sn=161EDD81D49C1BD8
    //https://cmt.ithome.com/api/comment/hot?sn=B4AEFA0A003D5835
    //https://cmt.ithome.com/api/comment/hot?sn=B4AEFA0A003D5835
  }

  void toOriginal() {
    launchUrlString('https://www.ithome.com$url',
        mode: LaunchMode.externalApplication);
  }

  void setting() {
    AppNavigator.showBottomSheet(
      Container(
        height: 200,
        color: Theme.of(Get.context!).cardColor,
        padding: AppStyle.edgeInsetsA12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Expanded(
                  child: Text(
                    "阅读设置",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  onPressed: AppNavigator.closePage,
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            AppStyle.vGap12,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    "字体大小",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (fontSize.value <= 8) {
                      return;
                    }
                    fontSize.value -= 2;
                    AppSettingsService.instance.setValue(
                        AppSettingsService.kReadFontSize, fontSize.value);
                    update();
                  },
                  icon: const Icon(Icons.remove),
                ),
                Obx(
                  () => Padding(
                    padding: AppStyle.edgeInsetsA8,
                    child: Text(
                      fontSize.value.toStringAsFixed(0),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (fontSize.value >= 48) {
                      return;
                    }
                    fontSize.value += 2;
                    AppSettingsService.instance.setValue(
                        AppSettingsService.kReadFontSize, fontSize.value);
                    update();
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void share() {
    if (url.isEmpty) return;
    Share.share('https://www.ithome.com$url');
  }

  void collect() {
    if (AppStorageService.instance.existNewsCollect(newsId)) {
      AppStorageService.instance.deleteNewsCollect(newsId);
      collected.value = false;
    } else {
      AppStorageService.instance.insertNewsCollect(
        newsId,
        url: url,
        title: title.value,
        image: image,
      );
      collected.value = true;
    }
    update();
  }
}
