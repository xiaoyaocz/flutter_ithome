import 'package:flutter_ithome/app/common/log.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class BaseController extends GetxController {
  /// 加载中，更新页面
  var pageLoadding = false.obs;

  /// 加载中,不会更新页面
  var loadding = false;

  /// 空白页面
  var pageEmpty = false.obs;

  /// 页面错误
  var pageError = false.obs;

  /// 错误信息
  var errorMsg = "".obs;

  /// 显示错误
  /// * [msg] 错误信息
  /// * [showPageError] 显示页面错误
  /// * 只在第一页加载错误时showPageError=true，后续页加载错误时使用Toast弹出通知
  void showError(String msg, {bool showPageError = false}) {
    Log.e(msg, StackTrace.current);
    if (showPageError) {
      pageError.value = true;
      errorMsg.value = msg;
    } else {
      showToast(msg);
    }
  }

  /// 当页面显示
  void onShow() {
    Log.i("显示${toString()}");
  }

  String exceptionToString(Object exception) {
    return exception.toString().replaceAll("Exception:", "");
  }
}

class BasePageController<T> extends BaseController {
  int currentPage = 1;
  int count = 0;
  int maxPage = 0;
  int pageSize = 24;
  var canLoadMore = false.obs;
  var list = <T>[].obs;

  Future refreshData() async {
    currentPage = 1;
    list.value = [];
    await loadData();
  }

  Future loadData() async {
    try {
      if (loadding) return;
      loadding = true;
      pageLoadding.value = currentPage == 1;
      update();
      var result = await getData(currentPage, pageSize);
      //是否可以加载更多
      if (result.isNotEmpty) {
        currentPage++;
        canLoadMore.value = true;
        pageEmpty.value = false;
      } else {
        canLoadMore.value = false;
        if (currentPage == 1) {
          pageEmpty.value = true;
        }
      }
      // 赋值数据
      if (currentPage == 1) {
        list.value = result;
      } else {
        list.addAll(result);
      }
    } catch (e) {
      showError(exceptionToString(e), showPageError: currentPage == 1);
    } finally {
      loadding = false;
      pageLoadding.value = false;
      update();
    }
  }

  Future<List<T>> getData(int page, int pageSize) async {
    return [];
  }
}
