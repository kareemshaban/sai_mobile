import 'package:json_annotation/json_annotation.dart';
part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {
  int? id;
  String? name;
  String? flag;
  @JsonKey(name: "is_famous")
  int? isFamous;

  CountryModel({
    this.id,
    this.name,
    this.flag,
    this.isFamous,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
