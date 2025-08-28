import 'package:json_annotation/json_annotation.dart';
part 'gift_model.g.dart';

@JsonSerializable()
class GiftModel {
  int? id;
  GiftCategoryModel? category;
  @JsonKey(name: "gift_img")
  String? giftImg;
  @JsonKey(name: "gift_file")
  String? giftFile;
  @JsonKey(name: "gold_value")
  num? goldValue;

  GiftModel({
    this.id,
    this.category,
    this.giftImg,
    this.giftFile,
    this.goldValue,
  });

  factory GiftModel.fromJson(Map<String, dynamic> json) =>
      _$GiftModelFromJson(json);

  Map<String, dynamic> toJson() => _$GiftModelToJson(this);
}

@JsonSerializable()
class GiftCategoryModel {
  int? id;
  String? name;

  GiftCategoryModel({
    this.id,
    this.name,
  });

  factory GiftCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$GiftCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GiftCategoryModelToJson(this);
}
