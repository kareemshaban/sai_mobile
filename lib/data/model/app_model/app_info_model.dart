import 'package:json_annotation/json_annotation.dart';
part 'app_info_model.g.dart';

@JsonSerializable()
class AppInfoModel {
  @JsonKey(name: "android_version")
  String? androidVersion;
  @JsonKey(name: "ios_version")
  String? iosVersion;
  @JsonKey(name: "android_url")
  String? androidUrl;
  @JsonKey(name: "ios_url")
  String? iosUrl;
  @JsonKey(name: "activate_redeem_golds")
  int? activateRedeemGolds;
  String? vip;

  AppInfoModel({
    this.activateRedeemGolds,
    this.androidUrl,
    this.androidVersion,
    this.iosUrl,
    this.iosVersion,
    this.vip,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AppInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppInfoModelToJson(this);
}
