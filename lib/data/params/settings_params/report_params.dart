import 'package:json_annotation/json_annotation.dart';
part 'report_params.g.dart';

@JsonSerializable()
class ReportParams {
  @JsonKey(includeIfNull: false)
  String? type;
  @JsonKey(includeIfNull: false)
  String? message;

  ReportParams({
    this.message,
    this.type,
  });

  factory ReportParams.fromJson(Map<String, dynamic> json) =>
      _$ReportParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ReportParamsToJson(this);
}
