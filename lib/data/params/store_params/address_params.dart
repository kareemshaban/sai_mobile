import 'package:json_annotation/json_annotation.dart';
part 'address_params.g.dart';

@JsonSerializable()
class AddressParams {
  @JsonKey(includeIfNull: false, name: "full_name")
  String? fullName;
  @JsonKey(includeIfNull: false, name: "country_id")
  int? countryId;
  @JsonKey(includeIfNull: false)
  String? street;
  @JsonKey(includeIfNull: false, name: "street_mark")
  String? streetMark;
  @JsonKey(includeIfNull: false)
  String? phone;
  @JsonKey(includeIfNull: false, name: "optional_phone")
  String? optionalPhone;
  @JsonKey(includeIfNull: false, name: "is_default")
  int? isDefault;
  @JsonKey(includeIfNull: false)
  int? id;

  AddressParams({
    this.isDefault,
    this.phone,
    this.streetMark,
    this.fullName,
    this.optionalPhone,
    this.street,
    this.countryId,
    this.id,
  });

  factory AddressParams.fromJson(Map<String, dynamic> json) =>
      _$AddressParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddressParamsToJson(this);
}
