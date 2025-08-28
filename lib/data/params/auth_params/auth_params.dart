import 'package:json_annotation/json_annotation.dart';
part 'auth_params.g.dart';

@JsonSerializable()
class AuthParams {
  @JsonKey(includeIfNull: false)
  String? phone;
  @JsonKey(includeIfNull: false)
  String? password;
  @JsonKey(includeIfNull: false)
  String? code;
  @JsonKey(name: "password_confirmation", includeIfNull: false)
  String? passwordConfirmation;
  @JsonKey(includeIfNull: false)
  String? name;
  @JsonKey(name: "birth_date", includeIfNull: false)
  String? birthDate;
  @JsonKey(name: "country_id", includeIfNull: false)
  int? countryId;
  @JsonKey(name: "profile_img", includeIfNull: false)
  String? profileImg;
  @JsonKey(includeIfNull: false)
  String? gender;
  @JsonKey(name: "profile_description", includeIfNull: false)
  String? profileDescription;
  @JsonKey(name: "profile_cover", includeIfNull: false)
  String? profileCover;
  @JsonKey(name: "fcm_token", includeIfNull: false)
  String? fcmToken;

  AuthParams({
    this.password,
    this.phone,
    this.code,
    this.passwordConfirmation,
    this.name,
    this.gender,
    this.profileImg,
    this.birthDate,
    this.countryId,
    this.profileDescription,
    this.profileCover,
    this.fcmToken,
  });

  factory AuthParams.fromJson(Map<String, dynamic> json) =>
      _$AuthParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AuthParamsToJson(this);
}
