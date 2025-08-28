import 'package:json_annotation/json_annotation.dart';
part 'send_message_params.g.dart';

@JsonSerializable()
class SendRoomMessageParams {
  @JsonKey(includeIfNull: false)
  String? message;
  @JsonKey(includeIfNull: false)
  String? image;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? roomID;

  SendRoomMessageParams({
    this.image,
    this.message,
    this.roomID,
  });

  factory SendRoomMessageParams.fromJson(Map<String, dynamic> json) =>
      _$SendRoomMessageParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SendRoomMessageParamsToJson(this);
}
