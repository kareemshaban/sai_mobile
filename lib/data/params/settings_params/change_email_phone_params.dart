import 'package:json_annotation/json_annotation.dart';
part 'change_email_phone_params.g.dart';

@JsonSerializable()
class ChangeEmailPhoneParams {
  @JsonKey(includeIfNull: false)
  String? email;
  @JsonKey(includeIfNull: false)
  String? phone;
  @JsonKey(includeIfNull: false)
  String? code;

  ChangeEmailPhoneParams({
    this.code,
    this.email,
    this.phone,
  });

  factory ChangeEmailPhoneParams.fromJson(Map<String, dynamic> json) =>
      _$ChangeEmailPhoneParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeEmailPhoneParamsToJson(this);
}
