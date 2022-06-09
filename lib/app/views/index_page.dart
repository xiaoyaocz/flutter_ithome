import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/common/log.dart';
import 'package:flutter_ithome/app/controller/index_controller.dart';
import 'package:flutter_ithome/app/route/route_path.dart';
import 'package:flutter_ithome/app/views/news/news_detail_page.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class IndexPage extends GetView<IndexController> {
  IndexPage({Key? key}) : super(key: key);
  final GlobalKey<NavigatorState>? contentKey = Get.nestedKey(1);
  @override
  Widget build(BuildContext context) {
    final content = _buildContent();
    final indexStack = _buildIndexStack();
    return MediaQuery.of(context).size.width > 768
        ? _buildWide(context, indexStack, content)
        : _buildNarrow(context, indexStack, content);
  }

  Widget _buildNarrow(BuildContext context, Widget indexStack, Widget content) {
    return Stack(
      children: [
        Obx(
          () => Scaffold(
            body: indexStack,
            bottomNavigationBar: BottomNavigationBar(
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
        IgnorePointer(
          ignoring: !controller.showContent.value,
          child: content,
        ),
      ],
    );
  }

  Widget _buildWide(BuildContext context, Widget indexStack, Widget content) {
    return Scaffold(
      body: Row(
        children: [
          Obx(
            () => Visibility(
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
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.grey.withOpacity(.1),
                  ),
                ),
              ),
              child: indexStack,
            ),
          ),
          Expanded(
            flex: 6,
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildIndexStack() {
    return Obx(
      () => IndexedStack(
        index: controller.index.value,
        children: controller.pages,
      ),
    );
  }

  Widget _buildContent() {
    return WillPopScope(
      onWillPop: () async {
        if (contentKey!.currentState!.canPop()) {
          contentKey!.currentState!.pop();
          return false;
        }
        return true;
      },
      child: Navigator(
        key: contentKey,
        initialRoute: '/',
        onUnknownRoute: (settings) => GetPageRoute(
          page: () => const EmptyPage(),
        ),
        observers: [
          MyObserver(),
        ],
        onGenerateRoute: (settings) {
          Log.i(settings.arguments.toString());
          if (settings.name == '/') {
            return GetPageRoute(
              settings: settings,
              page: () => const EmptyPage(),
            );
          }
          if (settings.name == RoutePath.kNewsDetail) {
            return GetPageRoute(
              settings: settings,
              page: () => NewsDetailPage(
                settings.arguments as int,
              ),
            );
          }
          return GetPageRoute(page: () => Container());
        },
      ),
    );
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width <= 768
        ? Container()
        : Scaffold(
            body: Center(
              child: Image.asset(
                'assets/logo/about_logo.png',
                height: 24,
              ),
            ),
          );
  }
}

class MyObserver extends NavigatorObserver {
// 添加导航监听后，跳转的时候需要使用Navigator.push路由
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      var routeName = route.settings.name ?? "";
      Get.find<IndexController>().showContent.value = routeName != '/';
    }

    // var previousName = '';
    // if (previousRoute == null) {
    //   previousName = 'null';
    // } else {
    //   previousName = previousRoute.settings.name ?? "";
    // }
    // print('NavObserverDidPush-Current:' +
    //     (route.settings.name ?? "") +
    //     '  Previous:' +
    //     previousName);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    var routeName = previousRoute?.settings.name ?? "";

    Get.find<IndexController>().showContent.value = routeName != '/';

    // var previousName = '';
    // if (previousRoute == null) {
    //   previousName = 'null';
    // } else {
    //   previousName = previousRoute.settings.name ?? "";
    // }
    // print('NavObserverDidPop--Current:' +
    //     (route.settings.name ?? "") +
    //     '  Previous:' +
    //     previousName);
  }
}
