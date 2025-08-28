import 'package:json_annotation/json_annotation.dart';
part 'change_privacy_params.g.dart';

@JsonSerializable()
class ChangePrivacyParams {
  @JsonKey(includeIfNull: false)
  String? type;
  @JsonKey(includeIfNull: false)
  String? value;

  ChangePrivacyParams({
    this.value,
    this.type,
  });

  factory ChangePrivacyParams.fromJson(Map<String, dynamic> json) =>
      _$ChangePrivacyParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePrivacyParamsToJson(this);
}
