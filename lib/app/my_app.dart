import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/controller/app_settings_controller.dart';
import 'package:flutter_ithome/app/route/app_pages.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AppSettingsController controller = Get.put(AppSettingsController());
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        title: 'IT之家',
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: Platform.isWindows ? "微软雅黑" : null,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red,
            accentColor: Colors.red,
            brightness: Brightness.dark,
          ),
          toggleableActiveColor: Colors.red,
          brightness: Brightness.dark,
          fontFamily: Platform.isWindows ? "微软雅黑" : null,
        ),
        themeMode: controller.darkMode.value ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? widget) {
          return OKToast(child: widget!);
        },
        initialRoute: AppPages.kIndex,
        getPages: AppPages.routes,
      ),
    );
  }
}
