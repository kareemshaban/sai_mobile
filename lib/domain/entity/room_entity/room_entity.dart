// import 'package:new_sai/domain/entity/room_entity/tag_entity.dart';
//
// class RoomEntity {
//   int id;  int roomId;
//   num roomReferenceId;
//   String roomImage;
//   String falg;
//   String roomName;
//   String generalNotificationContent;
//   TagEntity tag;
//   num membersCount;
//   num profileLevel;
//   String lockCode;
//   String backgroundTheme;
//
//   RoomEntity({
//     required this.id,
//     required this.roomId,
//     required this.roomReferenceId,
//     required this.roomImage,
//     required this.roomName,
//     required this.generalNotificationContent,
//     required this.tag,
//     required this.membersCount,
//     required this.profileLevel,
//     required this.falg,
//     required this.lockCode,
//     required this.backgroundTheme,
//   });
//
//   static final fakeData = RoomEntity(
//       id: 0,
//       roomId: 0,
//       roomReferenceId: 0,
//       roomImage: "roomImage",
//       roomName: "roomName",
//       generalNotificationContent: "generalNotificationContent",
//       tag: TagEntity(id: 0, name: "name"),
//       membersCount: 0,
//       profileLevel: 0,
//       falg: 'falg',
//       backgroundTheme: "",
//       lockCode: "");
//
// }
import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/domain/entity/room_entity/tag_entity.dart';
part 'room_entity.g.dart';
@JsonSerializable()
class RoomEntity {
  int id;
  int roomId;
  num roomReferenceId;
  String roomImage;
  String falg;
  String roomName;
  String generalNotificationContent;
  TagEntity tag;
  num membersCount;
  num profileLevel;
  String lockCode;
  String backgroundTheme;

  RoomEntity({
    required this.id,
    required this.roomId,
    required this.roomReferenceId,
    required this.roomImage,
    required this.roomName,
    required this.generalNotificationContent,
    required this.tag,
    required this.membersCount,
    required this.profileLevel,
    required this.falg,
    required this.lockCode,
    required this.backgroundTheme,
  });

  factory RoomEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RoomEntityToJson(this);


  static final fakeData = RoomEntity(
      id: 0,
      roomId: 0,
      roomReferenceId: 0,
      roomImage: "roomImage",
      roomName: "roomName",
      generalNotificationContent: "generalNotificationContent",
      tag: TagEntity(id: 0, name: "name"),
      membersCount: 0,
      profileLevel: 0,
      falg: 'falg',
      backgroundTheme: "",
      lockCode: "");


}
