import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/settings_model/unique_id_model.dart';
part 'setting_market_model.g.dart';

@JsonSerializable()
class SettingMarketModel {
  @JsonKey(name: "gold_value")
  num? goldValue;
  List<UniqueIdModel>? room;
  List<UniqueIdModel>? user;

  SettingMarketModel({
    this.goldValue,
    this.room,
    this.user,
  });

  factory SettingMarketModel.fromJson(Map<String, dynamic> json) =>
      _$SettingMarketModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingMarketModelToJson(this);
}
