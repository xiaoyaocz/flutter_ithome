import 'package:flutter_ithome/app/common/event_bus.dart';
import 'package:flutter_ithome/app/views/news_page.dart';
import 'package:flutter_ithome/app/views/quan_page.dart';
import 'package:flutter_ithome/app/views/user_page.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  final index = 0.obs;
  final showContent = false.obs;
  final pages = [
    const NewsPage(),
    const QuanPage(),
    UserPage(),
  ];
  @override
  void onClose() {}

  void setIndex(i) {
    if (index.value == i) {
      EventBus.instance.emit(EventBus.kEventRefreshNews, 0);
      return;
    }
    index.value = i;
  }
}
