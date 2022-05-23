import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/common/app_style.dart';
import 'package:remixicon/remixicon.dart';

class EmptyWidget extends StatelessWidget {
  final bool showRefresh;
  final String? text;
  final Function()? onRefresh;

  const EmptyWidget({
    Key? key,
    this.text,
    this.showRefresh = true,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/status/empty.png',
            width: 200,
          ),
          AppStyle.vGap12,
          Text(
            text ?? "这里什么都没有",
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          AppStyle.vGap12,
          Visibility(
            visible: showRefresh && onRefresh != null,
            child: TextButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text("刷新"),
            ),
          ),
        ],
      ),
    );
  }
}
