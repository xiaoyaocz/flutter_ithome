import 'package:hive/hive.dart';

part 'news_history.g.dart';

@HiveType(typeId: 2)
class NewsHistory {
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
