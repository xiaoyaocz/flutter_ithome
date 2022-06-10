import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppNavigator {
  /// 当前内容路由的名称
  static String currentContentRouteName = "/";
  static final GlobalKey<NavigatorState>? contentKey = Get.nestedKey(1);

  static void toPage(String name, {dynamic arg}) {
    Get.toNamed(name, arguments: arg);
  }

  static void toContentPage(String name, {dynamic arg}) {
    Get.toNamed(name, arguments: arg, id: 1);
  }

  static void closePage() {
    if (Navigator.canPop(Get.context!)) {
      Get.back();
    } else {
      Get.back(id: 1);
    }
  }
}
