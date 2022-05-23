import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  /// 显示确定弹窗
  static Future<bool> showConfirmDialog(
      {required String title, required String content}) async {
    return (await Get.dialog<bool>(
          AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: const Text("取消"),
              ),
              TextButton(
                onPressed: () {
                  Get.back(result: true);
                },
                child: const Text("确定"),
              ),
            ],
          ),
        )) ??
        false;
  }
}
