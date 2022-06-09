import 'package:flutter/material.dart';
import 'package:flutter_ithome/app/common/app_style.dart';
import 'package:flutter_ithome/app/common/utils.dart';
import 'package:flutter_ithome/app/route/route_path.dart';
import 'package:flutter_ithome/model/news_item_model.dart';
import 'package:flutter_ithome/widget/net_image.dart';
import 'package:get/get.dart';

class NewsItemWidget extends StatelessWidget {
  final NewsItemModel item;

  /// 是否置顶
  final bool isTop;
  const NewsItemWidget(this.item, {this.isTop = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget = Container();
    if (item.images?.isEmpty ?? true) {
      widget = _buildLeftImage(context);
    } else {
      widget = _buildThreeImage(context);
    }

    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () => Get.toNamed(
          RoutePath.kNewsDetail,
          arguments: item.newsid,
          id: 1,
        ),
        child: widget,
      ),
    );
  }

  Widget _buildLeftImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NetImage(
            item.image,
            height: 80,
            width: 106,
            elevation: 0,
            borderRadius: 8,
          ),
          AppStyle.hGap16,
          Expanded(
            child: SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildTitle(),
                  ),
                  _buildBottom(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreeImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: AppStyle.edgeInsetsH4,
            child: _buildTitle(),
          ),
          AppStyle.vGap8,
          item.images!.length >= 3
              ? Row(
                  children: item.images!
                      .take(3)
                      .map(
                        (e) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: NetImage(
                              e,
                              height: 80,
                              elevation: 0,
                              borderRadius: 4,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: NetImage(
                    item.images!.first,
                    height: (MediaQuery.of(context).size.width - 24) * 0.5,
                    elevation: 0,
                    borderRadius: 8,
                  ),
                ),
          AppStyle.vGap12,
          Padding(
            padding: AppStyle.edgeInsetsH4,
            child: _buildBottom(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      item.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppStyle.titleTetxStyle,
    );
  }

  /// 时间+评论数
  Widget _buildBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: !isTop,
                child: Padding(
                  padding: AppStyle.edgeInsetsR8,
                  child: Text(
                    Utils.handleTime(item.postdate),
                    style: AppStyle.introTetxStyle,
                  ),
                ),
              ),
              _buildTag(
                "置顶",
                visible: isTop,
                color: Colors.red,
              ),
              _buildTag(
                "广告",
                visible: item.isAd,
              ),
              _buildTag(
                "视频",
                visible: item.isVideo,
                color: Colors.orange,
              ),
            ],
          ),
        ),
        Text(
          "${item.commentcount}评",
          style: AppStyle.introTetxStyle,
        ),
      ],
    );
  }

  Widget _buildTag(String tag,
      {bool visible = false, Color color = Colors.grey}) {
    return Visibility(
      visible: visible,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color),
        ),
        margin: AppStyle.edgeInsetsR8,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          tag,
          style: TextStyle(fontSize: 10, color: color, height: 1),
        ),
      ),
    );
  }
}
