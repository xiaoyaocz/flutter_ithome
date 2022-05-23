import 'ff_convert.dart';

class NewsItemModel {
  final String title;
  final int newsid;
  final DateTime orderdate;
  final DateTime postdate;
  final String image;
  final List<String>? images;
  final bool isAd;
  final bool isVideo;
  final int cid;
  final int commentcount;
  NewsItemModel({
    required this.newsid,
    required this.cid,
    required this.title,
    required this.orderdate,
    required this.postdate,
    required this.image,
    this.images,
    this.isAd = false,
    this.isVideo = false,
    this.commentcount = 0,
  });

  /// 处理https://api.ithome.com/json/newslist/news
  factory NewsItemModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<String>? imagelist =
        jsonRes['imagelist'] is List ? <String>[] : null;
    if (imagelist != null) {
      for (final dynamic item in jsonRes['imagelist']!) {
        if (item != null) {
          tryCatch(() {
            imagelist.add(asT<String>(item)!);
          });
        }
      }
    }

    return NewsItemModel(
      newsid: asT<int>(jsonRes['newsid'])!,
      cid: asT<int>(jsonRes['cid']) ?? 0,
      image: asT<String>(jsonRes['image'])!,
      title: asT<String>(jsonRes['title'])!,
      commentcount: asT<int>(jsonRes['commentcount']) ?? 0,
      orderdate: DateTime.parse(jsonRes['orderdate']),
      postdate: DateTime.parse(jsonRes['postdate']),
      images: imagelist,
      isAd: jsonRes.containsKey("aid"),
      isVideo: jsonRes.containsKey("v"),
    );
  }

  /// 处理https://m.ithome.com/api/news/newslistpageget
  factory NewsItemModel.fromMJson(Map<String, dynamic> jsonRes) {
    final List<String>? imagelist =
        jsonRes['imagelist'] is List ? <String>[] : null;
    if (imagelist != null) {
      for (final dynamic item in jsonRes['imagelist']!) {
        if (item != null) {
          tryCatch(() {
            imagelist.add(asT<String>(item)!);
          });
        }
      }
    }

    return NewsItemModel(
      newsid: asT<int>(jsonRes['newsid'])!,
      cid: asT<int>(jsonRes['cid']) ?? 0,
      image: asT<String>(jsonRes['image'])!,
      title: asT<String>(jsonRes['title'])!,
      commentcount: asT<int>(jsonRes['commentcount']) ?? 0,
      orderdate: DateTime.parse(jsonRes['orderdate']),
      postdate: DateTime.parse(jsonRes['postdate']),
      images: imagelist,
      isAd: asT<String>(jsonRes['NewsTips'])!.contains("广告"),
      isVideo: asT<String>(jsonRes['NewsTips'])!.contains("视频"),
    );
  }
}
