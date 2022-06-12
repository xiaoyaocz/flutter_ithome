import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppSettingsService extends GetxService {
  static AppSettingsService get instance => Get.find<AppSettingsService>();

  /// 新闻-自定义的栏目
  static const String kNewsCategores = "NewsCategores";
  static const String kDarkMode = "DarkMode";
  static const String kThemeColor = "ThemeColor";
  static const String kReadFontSize = "ReadFontSize";

  late Box settingsBox;
  Future init() async {
    settingsBox = await Hive.openBox("Settings");
  }

  T getValue<T>(dynamic key, T defaultValue) {
    return settingsBox.get(key, defaultValue: defaultValue) as T;
  }

  Future setValue<T>(dynamic key, T value) async {
    return await settingsBox.put(key, value);
  }
}
