import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ithome/app/my_app.dart';
import 'package:flutter_ithome/app/service/app_settings_service.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //初始化服务
  await initServices();
  //设置状态栏为透明
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(const MyApp());
}

Future initServices() async {
  await Get.put(AppSettingsService()).init();
}
