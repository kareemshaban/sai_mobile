import 'package:json_annotation/json_annotation.dart';
part 'fire_user_params.g.dart';

@JsonSerializable()
class FireUserParams {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? roomID;
  @JsonKey(name: "user_id", includeIfNull: false)
  String? userID;
  @JsonKey(includeIfNull: false)
  String? type;

  FireUserParams({
    this.roomID,
    this.userID,
    this.type,
  });

  factory FireUserParams.fromJson(Map<String, dynamic> json) =>
      _$FireUserParamsFromJson(json);

  Map<String, dynamic> toJson() => _$FireUserParamsToJson(this);
}
