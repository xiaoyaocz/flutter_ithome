// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_collect.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsCollectAdapter extends TypeAdapter<NewsCollect> {
  @override
  final int typeId = 1;

  @override
  NewsCollect read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsCollect()
      ..id = fields[0] as int?
      ..image = fields[1] as String?
      ..title = fields[2] as String?
      ..url = fields[3] as String?
      ..addDate = fields[4] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, NewsCollect obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.addDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsCollectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
