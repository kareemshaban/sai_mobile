class RoomSendGiftModel {
  String giftFile;
  String giftImage;
  GiftUser sender;
  GiftUser? recevier;
  int? giftCount;
  int? giftType;

  RoomSendGiftModel({
    required this.giftFile,
    required this.giftImage,
    required this.sender,
    this.giftType,
    this.giftCount,
    this.recevier,
  });

  factory RoomSendGiftModel.fromJson(Map<String, dynamic> json) {
    return RoomSendGiftModel(
      giftFile: json["giftFile"] ?? '',
      giftImage: json["giftImage"] ?? '',
      sender: GiftUser.fromJson(json["sender"] ?? '{}'),
      giftCount: json["giftCount"] ?? 0,
      giftType: json["giftType"] ?? 0,
      recevier: GiftUser.fromJson(json["sender"] ?? '{}'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'giftFile': giftFile,
      'giftImage': giftImage,
      'sender': sender,
      'giftCount': giftCount,
      'giftType': giftType,
      'recevier': recevier,
    };
  }
}

class GiftUser {
  String name;
  int id;

  GiftUser({
    required this.name,
    required this.id,
  });

  factory GiftUser.fromJson(Map<String, dynamic> json) {
    return GiftUser(
      name: json["name"] ?? '',
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
