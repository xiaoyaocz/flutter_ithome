import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_ithome/app/common/app_style.dart';
import 'package:flutter_ithome/app/common/utils.dart';
import 'package:flutter_ithome/app/controller/news/news_new_controller.dart';
import 'package:flutter_ithome/widget/adjustable_scroll_controller.dart';
import 'package:flutter_ithome/widget/empty.dart';
import 'package:flutter_ithome/widget/error.dart';
import 'package:flutter_ithome/widget/keep_alive_wrapper.dart';
import 'package:flutter_ithome/widget/loadding.dart';
import 'package:flutter_ithome/widget/net_image.dart';
import 'package:flutter_ithome/widget/news_item.dart';
import 'package:get/get.dart';

class NewsNewView extends StatelessWidget {
  const NewsNewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: GetBuilder<NewsNewController>(
        init: NewsNewController(),
        builder: ((c) {
          // 页面错误
          if (c.pageError.value) {
            return AppErrorWidget(
              c.errorMsg.value,
              onRefresh: () => c.refreshData(),
            );
          }
          // 页面内容为空
          if (!c.pageError.value && c.pageEmpty.value) {
            return EmptyWidget(
              onRefresh: () => c.refreshData(),
            );
          }
          return Stack(
            children: [
              EasyRefresh(
                onLoad: c.loadData,
                onRefresh: c.refreshData,
                header: BallPulseHeader(),
                footer: BallPulseFooter(),
                child: ListView.builder(
                  padding: AppStyle.edgeInsetsV8,
                  itemCount: c.list.length + 1,
                  controller: AdjustableScrollController(),
                  itemBuilder: (_, i) {
                    if (i == 0) {
                      return _buildHeader(context, c);
                    }
                    var item = c.list[i - 1];
                    return NewsItemWidget(item);
                  },
                ),
              ),
              //页面加载中
              Visibility(
                visible: c.pageLoadding.value,
                child: const LoaddingWidget(),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, NewsNewController controller) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: AppStyle.edgeInsetsB8,
      padding: controller.topNews.isEmpty
          ? AppStyle.edgeInsetsV12
          : AppStyle.edgeInsetsT12,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 120 / 48,
                viewportFraction: 1.0,
                //height: (MediaQuery.of(context).size.width - 32) * (48 / 120),
              ),
              items: controller.banner.map((item) {
                return GestureDetector(
                  onTap: () {
                    Utils.handleUrl(item.link);
                  },
                  child: NetImage(
                    item.image,
                    elevation: 0,
                  ),
                );
              }).toList(),
            ),
          ),
          ...controller.topNews.map(
            (x) => NewsItemWidget(
              x,
              isTop: true,
            ),
          ),
        ],
      ),
    );
  }
}
