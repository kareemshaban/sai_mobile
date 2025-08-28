import 'package:json_annotation/json_annotation.dart';
part 'lock_room_params.g.dart';

@JsonSerializable()
class LockRoomParams {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? roomID;
  String code;

  LockRoomParams({
    this.roomID,
    required this.code,
  });

  factory LockRoomParams.fromJson(Map<String, dynamic> json) =>
      _$LockRoomParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LockRoomParamsToJson(this);
}
