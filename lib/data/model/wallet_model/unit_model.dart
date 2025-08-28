import 'package:json_annotation/json_annotation.dart';
part 'unit_model.g.dart';

@JsonSerializable()
class ChargingUnitModel {
  final num? id;
  @JsonKey(name: 'gold_value')
  final String? goldValue;
  @JsonKey(name: 'unit_value')
  final String? unitValue;
  ChargingUnitModel({this.id, this.goldValue, this.unitValue});
  factory ChargingUnitModel.fromJson(Map<String, dynamic> json) =>
      _$ChargingUnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChargingUnitModelToJson(this);
}

@JsonSerializable()
class UnitModel {
  @JsonKey(name: "data")
  final List<ChargingUnitModel>? charginUnits;
  @JsonKey(name: "user_gold")
  final num? userGold;
  final ChargingUnitBannerModel? banner;

  UnitModel({this.charginUnits, this.userGold, this.banner});
  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnitModelToJson(this);
}

@JsonSerializable()
class ChargingUnitBannerModel {
  final String? image;
  final String? url;

  ChargingUnitBannerModel({this.image, this.url});
  factory ChargingUnitBannerModel.fromJson(Map<String, dynamic> json) =>
      _$ChargingUnitBannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChargingUnitBannerModelToJson(this);
}
