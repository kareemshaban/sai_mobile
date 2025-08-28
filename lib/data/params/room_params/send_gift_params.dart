import 'package:json_annotation/json_annotation.dart';
part 'send_gift_params.g.dart';

@JsonSerializable()
class SendGiftParams {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? roomID;
  @JsonKey(includeIfNull: false)
  int? user;
  @JsonKey(includeIfNull: false, name: "gift_id")
  int? giftId;
  @JsonKey(includeIfNull: false, name: "gift_count")
  int? giftCount;
  @JsonKey(includeIfNull: false)
  int? type;
  @JsonKey(includeIfNull: false, name: "users_in_room")
  List<String>? usersInRoom;
  @JsonKey(includeIfNull: false, name: "users_on_mic")
  List<String>? usersOnMic;

  SendGiftParams({
    this.user,
    this.type,
    this.roomID,
    this.giftCount,
    this.giftId,
    this.usersInRoom,
    this.usersOnMic,
  });

  factory SendGiftParams.fromJson(Map<String, dynamic> json) =>
      _$SendGiftParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SendGiftParamsToJson(this);
}
