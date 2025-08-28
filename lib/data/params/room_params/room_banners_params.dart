import 'package:json_annotation/json_annotation.dart';
part 'room_banners_params.g.dart';

@JsonSerializable()
class RoomBannersParams {
  @JsonKey(includeIfNull: false, name: "date_type")
  String? dateType;
  @JsonKey(includeIfNull: false)
  num? type;

  RoomBannersParams({
    this.type,
    this.dateType,
  });

  factory RoomBannersParams.fromJson(Map<String, dynamic> json) =>
      _$RoomBannersParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RoomBannersParamsToJson(this);
}
