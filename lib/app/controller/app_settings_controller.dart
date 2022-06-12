import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/service/app_settings_service.dart';
import 'package:get/get.dart';

class AppSettingsController extends GetxController {
  var darkMode = false.obs;
  @override
  void onInit() {
    // 繁体名称转简体
    darkMode.value = AppSettingsService.instance
        .getValue(AppSettingsService.kDarkMode, false);
    super.onInit();
  }

  void changeDarkMode(bool e) {
    darkMode.value = e;
    AppSettingsService.instance.setValue(AppSettingsService.kDarkMode, e);
    Get.changeThemeMode(e ? ThemeMode.dark : ThemeMode.light);
  }
}
