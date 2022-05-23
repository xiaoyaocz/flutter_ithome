import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/common/app_style.dart';
import 'package:flutter_ithome/app/controller/base_controller.dart';
import 'package:flutter_ithome/request/http_client.dart';
import 'package:flutter_ithome/widget/net_image.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';

class BiliBiliVideoCard extends StatelessWidget {
  final String url;
  const BiliBiliVideoCard(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BiliBiliVideoCardController>(
      init: BiliBiliVideoCardController(url),
      tag: url,
      builder: (controller) {
        return InkWell(
          onTap: () {
            if (!controller.pageLoadding.value && !controller.pageError.value) {
              launchUrl(Uri.parse(controller.jumpUrl),
                  mode: LaunchMode.externalApplication);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            height: MediaQuery.of(context).size.width * (9 / 16),
            child: Stack(
              children: [
                NetImage(
                  "${controller.pic.value}@400w.jpg",
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * (9 / 16),
                  fit: BoxFit.cover,
                ),
                Visibility(
                  visible: !controller.pageLoadding.value &&
                      !controller.pageError.value,
                  child: const Center(
                    child: Icon(
                      Remix.play_circle_fill,
                      color: Colors.white70,
                      size: 56,
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.pageLoadding.value,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Visibility(
                  visible: controller.pageError.value,
                  child: Center(
                    child: Text(
                      "视频加载失败",
                      style: AppStyle.introTetxStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BiliBiliVideoCardController extends BaseController {
  final String url;
  BiliBiliVideoCardController(this.url);
  var pic = "".obs;
  var author = "".obs;
  var title = "".obs;
  var jumpUrl = "";
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    pageLoadding.value = true;
    update();
    try {
      var uri = Uri.parse(url);
      var result = await HttpClient.instance.getJson(
        "https://api.bilibili.com/x/web-interface/view",
        queryParameters: uri.queryParameters,
      );
      pic.value = result["data"]["pic"];
      title.value = result["data"]["title"];
      title.value = result["data"]["owner"]["name"];
      jumpUrl = "https://b23.tv/${result["data"]["bvid"]}";
    } catch (e) {
      pageError.value = true;
    } finally {
      pageLoadding.value = false;
      update();
    }
  }
}
