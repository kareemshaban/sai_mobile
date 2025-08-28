import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/country_model.dart';
part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  int? id;
  @JsonKey(name: "full_name")
  String? fullName;
  CountryModel? country;
  String? street;
  @JsonKey(name: "street_mark")
  String? streetMark;
  String? phone;
  @JsonKey(name: "optional_phone")
  String? optionalPhone;
  @JsonKey(name: "is_default")
  int? isDefault;

  AddressModel({
    this.id,
    this.country,
    this.street,
    this.fullName,
    this.phone,
    this.isDefault,
    this.optionalPhone,
    this.streetMark,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
