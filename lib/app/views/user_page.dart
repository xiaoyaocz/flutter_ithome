import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/common/app_style.dart';
import 'package:flutter_ithome/app/controller/app_settings_controller.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);
  final AppSettingsController controller = Get.find<AppSettingsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: AppStyle.edgeInsetsV12,
        children: [
          _buildUser(context),
          AppStyle.vGap12,
          _buildSettings(context),
          AppStyle.vGap12,
          _buildAbout(context)
        ],
      ),
    );
  }

  Widget _buildUser(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Remix.star_line),
            title: const Text("我的收藏"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(.1),
          ),
          ListTile(
            leading: const Icon(Remix.history_line),
            title: const Text("浏览历史"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Obx(
            () => SwitchListTile(
              secondary: const Icon(Remix.moon_line),
              title: const Text("夜间模式"),
              value: controller.darkMode.value,
              onChanged: controller.changeDarkMode,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Remix.information_line),
            title: const Text("关于"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: const Text("IT之家 Flutter"),
                  content: const Text("@xiaoyaocz 开发\n\n个人学习编程使用，不用于任何商业用途"),
                  actions: [
                    TextButton.icon(
                      onPressed: () {
                        launchUrlString("https://xiaoyaocz.com");
                        Get.back();
                      },
                      icon: const Icon(Remix.global_line),
                      label: const Text("个人主页"),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        launchUrlString(
                            "https://github.com/xiaoyaocz/flutter_ithome");
                        Get.back();
                      },
                      icon: const Icon(Remix.github_line),
                      label: const Text("GitHub"),
                    ),
                    TextButton(
                      onPressed: Get.back,
                      child: const Text("确定"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
