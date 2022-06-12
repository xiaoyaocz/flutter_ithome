import 'dart:convert';

import 'package:dart_des/dart_des.dart';
import 'package:flutter_ithome/app/common/app_navigator.dart';
import 'package:flutter_ithome/app/route/route_path.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static DateFormat dateFormat = DateFormat("MM-dd HH:mm");
  static DateFormat dateFormatWithYear = DateFormat("yyyy-MM-dd HH:mm");

  /// 处理时间
  static String handleTime(DateTime? dt) {
    if (dt == null) {
      return "";
    }

    var dtNow = DateTime.now();
    if (dt.year == dtNow.year &&
        dt.month == dtNow.month &&
        dt.day == dtNow.day) {
      return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    }
    if (dt.year == dtNow.year &&
        dt.month == dtNow.month &&
        dt.day == dtNow.day - 1) {
      return "昨日 ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    }

    if (dt.year == dtNow.year) {
      return dateFormat.format(dt);
    }

    return dateFormatWithYear.format(dt);
  }

  /// 处理链接
  static void handleUrl(String url) async {
    if (url.isEmpty) return;
    var uri = Uri.parse(url);
    if (uri.host == 'www.ithome.com' && uri.path.contains('/0/')) {
      var newsId = int.tryParse(
            uri.path
                .replaceAll('/0/', '')
                .replaceAll('/', '')
                .replaceAll('.htm', ''),
          ) ??
          0;
      AppNavigator.toContentPage(RoutePath.kNewsDetail, arg: newsId);

      return;
    }

    launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  // ignore: constant_identifier_names
  static const String ENCRYPTION_KEY = '(#i@x*l%';
  static String getCommentSn(String newsId) {
    DES desECB = DES(key: ENCRYPTION_KEY.codeUnits, mode: DESMode.ECB);

    var length = newsId.length;
    var times = 8 - length;
    if (length >= 8) {
      length %= 8;
      if (length == 0) {
        times = 0;
      }
    }
    var sb = StringBuffer(newsId);
    for (var i = 0; i < times; i++) {
      sb.write(String.fromCharCode(0));
    }
    var encrypted = desECB.encrypt(sb.toString().codeUnits);

    var sb2 = StringBuffer();
    for (var element in encrypted) {
      var hexString = element.toRadixString(16);
      if (hexString.length == 1) {
        sb2.write("0");
      }
      sb2.write(hexString);
    }

    return sb2.toString().substring(0, 16).toUpperCase();
  }
}
