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
}
