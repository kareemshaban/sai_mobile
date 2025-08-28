class RoomUpdateSettingsModel {
  String roomImage;
  String roomName;
  String roomNotification;
  num roomMemperFee;
  num roomMicsCount;

  RoomUpdateSettingsModel({
    required this.roomName,
    required this.roomNotification,
    required this.roomImage,
    required this.roomMemperFee,
    required this.roomMicsCount,
  });

  factory RoomUpdateSettingsModel.fromJson(Map<String, dynamic> json) {
    return RoomUpdateSettingsModel(
      roomName: json["roomName"] ?? '',
      roomNotification: json["roomNotification"] ?? '',
      roomImage: json["roomImage"] ?? '',
      roomMemperFee: json["roomMemperFee"] ?? 0,
      roomMicsCount: json["roomMicsCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomName': roomName,
      'roomImage': roomImage,
      'roomMemperFee': roomMemperFee,
      'roomNotification': roomNotification,
      'roomMicsCount': roomMicsCount,
    };
  }
}
