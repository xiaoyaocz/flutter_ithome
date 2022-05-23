import 'dart:convert';

import 'ff_convert.dart';

class NewsBannerModel {
  NewsBannerModel({
    required this.title,
    required this.starttime,
    required this.endtime,
    required this.link,
    required this.opentype,
    required this.device,
    required this.isad,
    required this.image,
  });

  factory NewsBannerModel.fromJson(Map<String, dynamic> json) =>
      NewsBannerModel(
        title: asT<String>(json['title'])!,
        starttime: asT<String>(json['starttime'])!,
        endtime: asT<String>(json['endtime'])!,
        link: asT<String>(json['link'])!,
        opentype: asT<int>(json['opentype'])!,
        device: asT<String>(json['device'])!,
        isad: asT<bool>(json['isad'])!,
        image: asT<String>(json['image'])!,
      );

  String title;
  String starttime;
  String endtime;
  String link;
  int opentype;
  String device;
  bool isad;
  String image;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'starttime': starttime,
        'endtime': endtime,
        'link': link,
        'opentype': opentype,
        'device': device,
        'isad': isad,
        'image': image,
      };
}
