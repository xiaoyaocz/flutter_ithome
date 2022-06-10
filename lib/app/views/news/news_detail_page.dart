import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_ithome/app/common/app_navigator.dart';
import 'package:flutter_ithome/app/common/app_style.dart';
import 'package:flutter_ithome/app/common/log.dart';
import 'package:flutter_ithome/app/common/utils.dart';
import 'package:flutter_ithome/app/controller/news/news_detail_controller.dart';
import 'package:flutter_ithome/app/route/route_path.dart';
import 'package:flutter_ithome/widget/adjustable_scroll_controller.dart';
import 'package:flutter_ithome/widget/bilibili_video_card.dart';
import 'package:flutter_ithome/widget/empty.dart';
import 'package:flutter_ithome/widget/error.dart';
import 'package:flutter_ithome/widget/loadding.dart';
import 'package:flutter_ithome/widget/net_image.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  final int newsId;
  const NewsDetailPage(this.newsId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<NewsDetailControler>(
        init: NewsDetailControler(newsId),
        tag: newsId.toString(),
        builder: (controller) {
          // 页面错误
          if (controller.pageError.value) {
            return AppErrorWidget(
              controller.errorMsg.value,
              onRefresh: () => controller.loadDetail(),
            );
          }
          // 页面内容为空
          if (!controller.pageError.value && controller.pageEmpty.value) {
            return EmptyWidget(
              onRefresh: () => controller.loadDetail(),
            );
          }
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: Get.isDarkMode
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            child: Column(
              children: [
                Container(
                  height: AppStyle.statusBarHeight,
                  color: Theme.of(context).cardColor,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      ListView(
                        padding: AppStyle.edgeInsetsA12,
                        controller: AdjustableScrollController(),
                        children: [
                          Padding(
                            padding: AppStyle.edgeInsetsA8,
                            child: Text(
                              controller.title.value,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: AppStyle.edgeInsetsA8,
                            child: Text(
                              "${controller.postTime}    ${controller.source}(${controller.author})",
                              style: AppStyle.introTetxStyle,
                            ),
                          ),
                          const Divider(),
                          _buildContent(context, controller),
                          Padding(
                            padding: AppStyle.edgeInsetsH8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "责编：${controller.head}",
                                  style: AppStyle.introTetxStyle,
                                ),
                                TextButton(
                                  onPressed: controller.toOriginal,
                                  child: const Text(
                                    "查看原文",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      //页面加载中
                      Visibility(
                        visible: controller.pageLoadding.value,
                        child: const LoaddingWidget(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildContent(BuildContext context, NewsDetailControler controller) {
    return Html(
      data: controller.content.value,
      style: {
        "blockquote": Style(
          backgroundColor: Colors.grey.shade100,
          margin: EdgeInsets.zero,
          padding: AppStyle.edgeInsetsA8,
          border: const Border(
            left: BorderSide(
              color: Colors.grey,
              width: 4,
            ),
          ),
        ),
        "p": Style(
          fontSize: const FontSize(16),
          lineHeight: const LineHeight(1.6),
          textAlign: TextAlign.justify,
        ),
        "a": Style(
          color: Theme.of(context).primaryColor,
        ),
        ".tougao-user": Style(
          display: Display.BLOCK,
          backgroundColor: Colors.grey.shade100,
          fontSize: const FontSize(12),
          color: Colors.grey.shade800,
          padding: AppStyle.edgeInsetsA8,
          textAlign: TextAlign.center,
        ),
        ".accentTextColor": Style(
          fontWeight: FontWeight.bold,
          // backgroundColor:
          //     Theme.of(context).primaryColor.withOpacity(.2),
        ),
        "ul": Style(
          listStyleType: ListStyleType.fromWidget(
            Container(
              margin: const EdgeInsets.only(top: 10, right: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      },
      customImageRenders: {
        networkSourceMatcher(): (context, attributes, element) {
          // var w =
          //     (MediaQuery.of(context.buildContext).size.width - 32);
          var width = double.tryParse(attributes['w']?.toString() ?? "") ?? 0.0;
          var height =
              double.tryParse(attributes['h']?.toString() ?? "") ?? 0.0;
          return LayoutBuilder(builder: (context, boxConstraints) {
            return NetImage(
              attributes['src']?.toString() ?? "",
              borderRadius: 4,
              width:
                  (width <= 0 || height <= 0) ? null : boxConstraints.maxWidth,
              height: (width <= 0 || height <= 0)
                  ? null
                  : (boxConstraints.maxWidth * (height / width)),
            );
          });
        },
      },
      customRender: {
        "iframe": (context, parsedChild) {
          try {
            var url = context.tree.attributes['src'].toString();
            if (url.contains("player.bilibili.com")) {}
            return BiliBiliVideoCard(url);
          } catch (e) {
            debugPrint(e.toString());
          }
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: AppStyle.edgeInsetsA24,
            child: Center(
              child: Text(
                "iframe",
                style: AppStyle.introTetxStyle,
              ),
            ),
          );
        },
      },
      onImageTap: (url, context, attributes, element) {
        Log.i(url ?? "");
      },
      onLinkTap: (url, context, attributes, element) {
        Log.i(url ?? '');

        Utils.handleUrl(url ?? '');
      },
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            const Expanded(
              child: IconButton(
                onPressed: AppNavigator.closePage,
                icon: Icon(Remix.arrow_left_line),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Remix.star_line),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Remix.chat_smile_2_line),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Remix.share_box_line),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Remix.arrow_up_line),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
