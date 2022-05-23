import 'dart:convert';

import 'package:flutter_ithome/model/ff_convert.dart';

class NewsDetailModel {
  NewsDetailModel({
    required this.success,
    required this.newsid,
    required this.title,
    required this.url,
    required this.newssource,
    required this.newsauthor,
    required this.keyword,
    required this.image,
    this.newstags,
    this.newsflag,
    this.user,
    required this.detail,
    this.postdate,
    this.hitcount,
    this.btheme,
    this.forbidcomment,
    this.commentcount,
    this.z,
  });

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) {
    final List<NewsDetailTagModel>? newstags =
        json['newstags'] is List ? <NewsDetailTagModel>[] : null;
    if (newstags != null) {
      for (final dynamic item in json['newstags']!) {
        if (item != null) {
          newstags.add(
              NewsDetailTagModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return NewsDetailModel(
      success: asT<bool>(json['success'])!,
      newsid: asT<int>(json['newsid'])!,
      title: asT<String>(json['title'])!,
      url: asT<String>(json['url'])!,
      newssource: asT<String>(json['newssource'])!,
      newsauthor: asT<String>(json['newsauthor'])!,
      keyword: asT<String>(json['keyword'])!,
      image: asT<String>(json['image'])!,
      newstags: newstags,
      newsflag: asT<int?>(json['newsflag']),
      user: json['user'] == null
          ? null
          : NewsDetailUserModel.fromJson(
              asT<Map<String, dynamic>>(json['user'])!),
      detail: asT<String>(json['detail'])!,
      postdate: DateTime.tryParse(json['postdate'].toString()),
      hitcount: asT<int?>(json['hitcount']),
      btheme: asT<bool?>(json['btheme']),
      forbidcomment: asT<bool?>(json['forbidcomment']),
      commentcount: asT<int?>(json['commentcount']),
      z: asT<String?>(json['z']),
    );
  }

  bool success;
  int newsid;
  String title;
  String url;
  String newssource;
  String newsauthor;
  String keyword;
  String image;
  List<NewsDetailTagModel>? newstags;
  int? newsflag;
  NewsDetailUserModel? user;
  String detail;
  DateTime? postdate;
  int? hitcount;
  bool? btheme;
  bool? forbidcomment;
  int? commentcount;
  String? z;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'success': success,
        'newsid': newsid,
        'title': title,
        'url': url,
        'newssource': newssource,
        'newsauthor': newsauthor,
        'keyword': keyword,
        'image': image,
        'newstags': newstags,
        'newsflag': newsflag,
        'user': user,
        'detail': detail,
        'postdate': postdate,
        'hitcount': hitcount,
        'btheme': btheme,
        'forbidcomment': forbidcomment,
        'commentcount': commentcount,
        'z': z,
      };
}

class NewsDetailTagModel {
  NewsDetailTagModel({
    this.id,
    this.keyword,
    this.link,
  });

  factory NewsDetailTagModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailTagModel(
        id: asT<int?>(json['id']),
        keyword: asT<String?>(json['keyword']),
        link: asT<String?>(json['link']),
      );

  int? id;
  String? keyword;
  String? link;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'keyword': keyword,
        'link': link,
      };
}

class NewsDetailUserModel {
  NewsDetailUserModel({
    this.userid,
    this.usernick,
    this.m,
  });

  factory NewsDetailUserModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailUserModel(
        userid: asT<int?>(json['userid']),
        usernick: asT<String?>(json['usernick']),
        m: asT<int?>(json['m']),
      );

  int? userid;
  String? usernick;
  int? m;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userid': userid,
        'usernick': usernick,
        'm': m,
      };
}
