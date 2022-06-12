import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ithome/app/common/log.dart';
import 'package:flutter_ithome/app/common/utils.dart';
import 'package:flutter_ithome/app/my_app.dart';
import 'package:flutter_ithome/app/service/app_settings_service.dart';
import 'package:flutter_ithome/app/service/app_storage_service.dart';
import 'package:flutter_ithome/storage/news_collect.dart';
import 'package:flutter_ithome/storage/news_history.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.registerAdapter(NewsHistoryAdapter());
  Hive.registerAdapter(NewsCollectAdapter());
  await Hive.initFlutter();
  //初始化服务
  await initServices();
  //设置状态栏为透明
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(MyApp());
}

Future initServices() async {
  await Get.put(AppSettingsService()).init();
  await Get.put(AppStorageService()).init();
}
