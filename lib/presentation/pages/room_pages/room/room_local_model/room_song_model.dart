import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'room_song_model.g.dart';

@HiveType(typeId: 0)
class RoomSongModel {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? path;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  Uint8List? image;

  RoomSongModel({
    this.duration,
    this.image,
    this.name,
    this.path,
  });
}
