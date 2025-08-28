import 'package:json_annotation/json_annotation.dart';
part 'global_statistics_params.g.dart';

@JsonSerializable()
class GlobalStatisticsParams {
  @JsonKey(name: "date_type", includeIfNull: false)
  String? dateType;
  @JsonKey(includeIfNull: false)
  int? type;

  GlobalStatisticsParams({
    this.type,
    this.dateType,
  });

  factory GlobalStatisticsParams.fromJson(Map<String, dynamic> json) =>
      _$GlobalStatisticsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalStatisticsParamsToJson(this);
}
