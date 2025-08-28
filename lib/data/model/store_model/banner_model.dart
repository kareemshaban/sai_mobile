import 'package:json_annotation/json_annotation.dart';
part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  String? image;
  String? type;
  @JsonKey(name: "type_val")
  String? typeVal;

  BannerModel({
    this.image,
    this.type,
    this.typeVal,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
