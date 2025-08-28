import 'package:json_annotation/json_annotation.dart';
part 'market_model.g.dart';

@JsonSerializable()
class MarketModel {
  int? id;
  String? name;
  String? logo;

  MarketModel({
    this.id,
    this.name,
    this.logo,
  });

  factory MarketModel.fromJson(Map<String, dynamic> json) =>
      _$MarketModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarketModelToJson(this);
}
