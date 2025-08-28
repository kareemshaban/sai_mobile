import 'package:json_annotation/json_annotation.dart';
part 'get_settings_product_params.g.dart';

@JsonSerializable()
class GetSettingsProductParams {
  @JsonKey(includeToJson: false, includeFromJson: false)
  int? catID;
  @JsonKey(includeIfNull: false)
  int? pattern;
  @JsonKey(includeIfNull: false)
  int? type;
  @JsonKey(includeIfNull: false)
  int? subcategory;

  GetSettingsProductParams({
    this.type,
    this.catID,
    this.pattern,
    this.subcategory,
  });

  factory GetSettingsProductParams.fromJson(Map<String, dynamic> json) =>
      _$GetSettingsProductParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSettingsProductParamsToJson(this);
}
