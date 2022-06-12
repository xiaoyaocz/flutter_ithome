import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ithome/app/common/app_style.dart';
import 'package:flutter_ithome/app/controller/news_controller.dart';
import 'package:flutter_ithome/app/views/news/news_category_view.dart';
import 'package:flutter_ithome/app/views/news/news_new_view.dart';
import 'package:flutter_ithome/app/views/news/news_rank_view.dart';
import 'package:flutter_ithome/model/category_item.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class NewsPage extends GetView<NewsController> {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.tabController.value == null
          ? const Scaffold()
          : Scaffold(
              appBar: NewsAppBar(
                tabController: controller.tabController.value!,
                categores: controller.categores,
              ),
              body: TabBarView(
                controller: controller.tabController.value!,
                children: controller.categores
                    .map(
                      (e) => buildTabItem(e),
                    )
                    .toList(),
              ),
            ),
    );
  }

  Widget buildTabItem(CategoryItem categoryItem) {
    if (categoryItem.id == "news") {
      return const NewsNewView();
    }
    if (categoryItem.id == "rank") {
      return const NewsRankView();
    }
    if (categoryItem.id == "comment") {
      return Center(
        child: Text(categoryItem.name),
      );
    }
    return NewsCategoryView(categoryItem.id);
  }
}

class NewsAppBar extends StatelessWidget with PreferredSizeWidget {
  final TabController tabController;
  final List<CategoryItem> categores;
  const NewsAppBar(
      {required this.tabController, required this.categores, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Get.isDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Container(
        padding: EdgeInsets.only(top: AppStyle.statusBarHeight),
        color: Theme.of(context).cardColor,
        height: AppStyle.statusBarHeight + 96,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: AppStyle.edgeInsetsA12.copyWith(bottom: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Get.isDarkMode
                        ? 'assets/logo/about_logo_night2.png'
                        : 'assets/logo/about_logo.png',
                    height: 24,
                  ),
                  AppStyle.hGap16,
                  Expanded(
                    child: Container(
                      padding: AppStyle.edgeInsetsH12,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "请输入想搜索的内容",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppStyle.vGap4,
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: TabBar(
                      controller: tabController,
                      labelColor: Get.isDarkMode ? Colors.white : Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Theme.of(context).colorScheme.secondary,
                      isScrollable: true,
                      labelStyle: const TextStyle(height: 1.0),
                      tabs: categores
                          .map(
                            (e) => Tab(
                              text: e.name,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Remix.menu_3_line,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppStyle.statusBarHeight + 96);
}
