import 'package:flutter_ithome/app/common/event_bus.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  final index = 0.obs;

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
