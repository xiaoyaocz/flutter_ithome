import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/common/log.dart';
import 'package:flutter_ithome/app/controller/base_controller.dart';
import 'package:flutter_ithome/widget/empty.dart';
import 'package:flutter_ithome/widget/error.dart';
import 'package:flutter_ithome/widget/loadding.dart';
import 'package:get/get.dart';

typedef ControllerWidgetBuilder<T> = Widget Function(T controller);

class ControllerWidget<T> extends StatelessWidget {
  /// 自定义组件 Builder
  final ControllerWidgetBuilder<T> builder;

  /// 控制器，该控制器必须继承自BaseController
  final BaseController controller;

  /// 请求刷新事件
  final Function(T e)? onRefresh;

  final String? tag;

  const ControllerWidget(this.controller,
      {required this.builder, this.onRefresh, this.tag, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: controller,
      tag: tag,
      global: false,
      initState: (e) {
        (e.controller as BaseController).onShow();
      },
      builder: (e) {
        e = e as BaseController;
        // 页面错误
        if (e.pageError.value) {
          return AppErrorWidget(
            e.errorMsg.value,
            onRefresh: () => onRefresh?.call(e as T),
          );
        }
        // 页面内容为空
        if (!e.pageError.value && e.pageEmpty.value) {
          return EmptyWidget(
            onRefresh: () => onRefresh?.call(e as T),
          );
        }
        return Stack(
          children: [
            builder(controller as T),
            //页面加载中
            Visibility(
              visible: e.pageLoadding.value,
              child: const LoaddingWidget(),
            ),
          ],
        );
      },
    );
  }
}
