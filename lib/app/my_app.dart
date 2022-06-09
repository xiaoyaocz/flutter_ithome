import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/route/app_pages.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        title: 'IT之家',
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: "微软雅黑",
        ),
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
