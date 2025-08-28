import 'package:json_annotation/json_annotation.dart';
part 'coupon_model.g.dart';

@JsonSerializable()
class CouponModel {
  num? discount;
  @JsonKey(name: "discount_id")
  int? discountId;

  CouponModel({
    this.discount,
    this.discountId,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);

  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}
