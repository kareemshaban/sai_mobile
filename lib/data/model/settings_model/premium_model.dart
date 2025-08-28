import 'package:json_annotation/json_annotation.dart';
part 'premium_model.g.dart';

@JsonSerializable()
class PremiumModel {
  List<PrivilegesPremiumModel>? privileges;
  List<PremiumDataModel>? data;
  @JsonKey(name: "total_count")
  num? totalCount;
  String? type;
  @JsonKey(name: "is_expierd")
  num? isExpierd;
  num? duration;
  @JsonKey(name: "category_id")
  num? categoryId;

  PremiumModel({
    this.type,
    this.data,
    this.privileges,
    this.categoryId,
    this.duration,
    this.isExpierd,
    this.totalCount,
  });

  factory PremiumModel.fromJson(Map<String, dynamic> json) =>
      _$PremiumModelFromJson(json);

  Map<String, dynamic> toJson() => _$PremiumModelToJson(this);
}

@JsonSerializable()
class PrivilegesPremiumModel {
  int? id;
  String? name;
  String? description;
  String? icon;

  PrivilegesPremiumModel({
    this.id,
    this.name,
    this.description,
    this.icon,
  });

  factory PrivilegesPremiumModel.fromJson(Map<String, dynamic> json) =>
      _$PrivilegesPremiumModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrivilegesPremiumModelToJson(this);
}

@JsonSerializable()
class PremiumDataModel {
  int? id;
  String? name;
  String? badge;
  @JsonKey(name: "activation_price")
  num? activationPrice;
  @JsonKey(name: "renewal_price")
  num? renewalPrice;
  List<int>? privileges;
  int? count;

  PremiumDataModel({
    this.name,
    this.id,
    this.privileges,
    this.activationPrice,
    this.badge,
    this.count,
    this.renewalPrice,
  });

  factory PremiumDataModel.fromJson(Map<String, dynamic> json) =>
      _$PremiumDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PremiumDataModelToJson(this);
}
