import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_ithome/app/common/app_style.dart';
import 'package:flutter_ithome/app/controller/news/news_category_controller.dart';
import 'package:flutter_ithome/widget/adjustable_scroll_controller.dart';
import 'package:flutter_ithome/widget/empty.dart';
import 'package:flutter_ithome/widget/error.dart';
import 'package:flutter_ithome/widget/keep_alive_wrapper.dart';
import 'package:flutter_ithome/widget/loadding.dart';
import 'package:flutter_ithome/widget/news_item.dart';
import 'package:get/get.dart';

class NewsCategoryView extends StatelessWidget {
  final String categoryId;
  const NewsCategoryView(this.categoryId, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: GetX<NewsCategoryController>(
        init: NewsCategoryController(categoryId),
        tag: categoryId,
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
                  itemCount: c.list.length,
                  controller: AdjustableScrollController(),
                  itemBuilder: (_, i) {
                    var item = c.list[i];
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
}
