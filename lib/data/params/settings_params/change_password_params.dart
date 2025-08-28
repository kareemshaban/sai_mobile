import 'package:json_annotation/json_annotation.dart';
part 'change_password_params.g.dart';

@JsonSerializable()
class ChangePasswordParams {
  @JsonKey(name: "old_password", includeIfNull: false)
  String? oldPassword;
  @JsonKey(includeIfNull: false)
  String? password;

  ChangePasswordParams({
    this.password,
    this.oldPassword,
  });

  factory ChangePasswordParams.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordParamsToJson(this);
}
