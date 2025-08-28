import 'package:json_annotation/json_annotation.dart';
part 'room_report_params.g.dart';

@JsonSerializable()
class RoomReportParams {
  @JsonKey(name: "reportable_id", includeIfNull: false)
  String? roomID;
  @JsonKey(includeIfNull: false)
  String? content;
  @JsonKey(includeIfNull: false)
  String? type;

  RoomReportParams({
    this.roomID,
    this.content,
    this.type,
  });

  factory RoomReportParams.fromJson(Map<String, dynamic> json) =>
      _$RoomReportParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RoomReportParamsToJson(this);
}
