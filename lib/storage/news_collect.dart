import 'package:hive/hive.dart';

part 'news_collect.g.dart';

@HiveType(typeId: 1)
class NewsCollect {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? image;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? url;

  @HiveField(4)
  DateTime? addDate;
}
