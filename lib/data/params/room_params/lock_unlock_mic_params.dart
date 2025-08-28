import 'package:json_annotation/json_annotation.dart';
part 'lock_unlock_mic_params.g.dart';

@JsonSerializable()
class LockUnlockMicParams {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? roomID;
  @JsonKey(name: 'mic_id')
  int micID;

  LockUnlockMicParams({
    required this.micID,
    this.roomID,
  });

  factory LockUnlockMicParams.fromJson(Map<String, dynamic> json) =>
      _$LockUnlockMicParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LockUnlockMicParamsToJson(this);
}
