import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/controller/index_controller.dart';
import 'package:flutter_ithome/app/views/news_page.dart';
import 'package:flutter_ithome/app/views/quan_page.dart';
import 'package:flutter_ithome/app/views/user_page.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Row(
          children: [
            Visibility(
              visible: MediaQuery.of(context).size.width > 768,
              child: Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Material(
                  elevation: 2,
                  child: NavigationRail(
                    backgroundColor: Theme.of(context).cardColor,
                    labelType: NavigationRailLabelType.all,
                    onDestinationSelected: controller.setIndex,
                    selectedIndex: controller.index.value,
                    selectedLabelTextStyle: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).primaryColor,
                    ),
                    unselectedLabelTextStyle: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Remix.home_4_line),
                        label: Text("资讯"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Remix.chat_smile_2_line),
                        label: Text("圈子"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Remix.user_smile_line),
                        label: Text("我的"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: controller.index.value,
                children: const [
                  NewsPage(),
                  QuanPage(),
                  UserPage(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Visibility(
          visible: MediaQuery.of(context).size.width <= 768,
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).cardColor,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            currentIndex: controller.index.value,
            onTap: controller.setIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Remix.home_4_line),
                label: "资讯",
              ),
              BottomNavigationBarItem(
                icon: Icon(Remix.chat_smile_2_line),
                label: "圈子",
              ),
              BottomNavigationBarItem(
                icon: Icon(Remix.user_smile_line),
                label: "我的",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
