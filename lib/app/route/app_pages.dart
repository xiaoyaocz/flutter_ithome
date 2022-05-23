import 'package:flutter_ithome/app/controller/index_controller.dart';
import 'package:flutter_ithome/app/controller/news_controller.dart';
import 'package:flutter_ithome/app/route/route_path.dart';
import 'package:flutter_ithome/app/views/news/news_detail_page.dart';
import 'package:get/get.dart';

import '../views/index_page.dart';

class AppPages {
  AppPages._();
  static const kIndex = RoutePath.kIndex;
  static final routes = [
    GetPage(
      name: RoutePath.kIndex,
      page: () => const IndexPage(),
      bindings: [
        BindingsBuilder.put(
          () => IndexController(),
        ),
        BindingsBuilder.put(
          () => NewsController(),
        ),
      ],
    ),
    GetPage(
      name: RoutePath.kNewsDetail,
      page: () => NewsDetailPage(
        int.parse(Get.parameters["newsId"] ?? "0"),
      ),
    ),
  ];
}
