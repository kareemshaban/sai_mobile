import 'package:json_annotation/json_annotation.dart';
part 'country_entity.g.dart';

@JsonSerializable()
class CountryEntity {
  int id;
  String name;
  String flag;
  int isFamous;

  CountryEntity({
    required this.id,
    required this.name,
    required this.flag,
    required this.isFamous,
  });

  static final fakeData = CountryEntity(
    id: 0,
    name: "name",
    flag: "flag",
    isFamous: 0,
  );

  factory CountryEntity.fromJson(Map<String, dynamic> json) =>
      _$CountryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CountryEntityToJson(this);
}
