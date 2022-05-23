import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/common/event_bus.dart';
import 'package:flutter_ithome/app/service/app_settings_service.dart';
import 'package:flutter_ithome/model/category_item.dart';
import 'package:get/get.dart';

class NewsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<TabController?> tabController = Rx<TabController?>(null);
  final settingsService = Get.find<AppSettingsService>();

  /// 全部栏目
  List<CategoryItem> allCategores = [
    CategoryItem(name: "最新", id: "news"),
    CategoryItem(name: "排行榜", id: "rank"),
    CategoryItem(name: "热评", id: "comment"),
    CategoryItem(name: "精读", id: "jingdum"),
    CategoryItem(name: "原创", id: "originalm"),
    CategoryItem(name: "评测", id: "labsm"),
    CategoryItem(name: "直播", id: "livem"),
    CategoryItem(name: "IT号", id: "itaccountm"),
    CategoryItem(name: "阳台", id: "balconym"),
    CategoryItem(name: "专题", id: "specialm"),
    CategoryItem(name: "投票", id: "votenewm"),
    CategoryItem(name: "鸿蒙", id: "harmonyos"),
    CategoryItem(name: "5G", id: "5gm"),
    CategoryItem(name: "京东精选", id: "jdm"),
    CategoryItem(name: "电脑", id: "pcm"),
    CategoryItem(name: "手机", id: "phonem"),
    CategoryItem(name: "数码", id: "digim"),
    CategoryItem(name: "学院", id: "geekm"),
    CategoryItem(name: "VR", id: "vrm"),
    CategoryItem(name: "智能汽车", id: "autom"),
    CategoryItem(name: "安卓", id: "androidm"),
    CategoryItem(name: "苹果", id: "iosm"),
    CategoryItem(name: "网络焦点", id: "internetm"),
    CategoryItem(name: "行业前沿", id: "itm"),
    CategoryItem(name: "游戏电竞", id: "gamem"),
    CategoryItem(name: "Windows", id: "windowsm"),
    CategoryItem(name: "Linux", id: "linuxsm"),
    CategoryItem(name: "科普", id: "discoverym"),
  ];

  var categores = <CategoryItem>[].obs;

  StreamSubscription<dynamic>? streamSubscription;

  @override
  void onInit() async {
    streamSubscription =
        EventBus.instance.listen(EventBus.kEventRefreshNews, (e) {
      tabController.value
          ?.animateTo(categores.indexWhere((x) => x.id == "news"));
    });
    Future.delayed(const Duration(milliseconds: 200), initCategores);

    super.onInit();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  void initCategores() {
    var ls = settingsService.getValue(
      AppSettingsService.kNewsCategores,
      getDefaultCategores(),
    );

    categores.value =
        ls.map((e) => allCategores.firstWhere((x) => x.id == e)).toList();
    tabController.value = TabController(length: categores.length, vsync: this);
  }

  /// 读取默认的栏目
  List<String> getDefaultCategores() {
    var ls = allCategores.take(10).toList();
    if (Platform.isWindows) {
      ls.insert(
        3,
        CategoryItem(name: "Windows", id: "windowsm"),
      );
    } else if (Platform.isMacOS || Platform.isIOS) {
      ls.insert(
        3,
        CategoryItem(name: "苹果", id: "iosm"),
      );
    } else if (Platform.isAndroid || Platform.isFuchsia) {
      ls.insert(
        3,
        CategoryItem(name: "安卓", id: "androidm"),
      );
    } else if (Platform.isLinux) {
      ls.insert(
        3,
        CategoryItem(name: "Linux", id: "linuxsm"),
      );
    }
    return ls.map((e) => e.id).toList();
  }
}
