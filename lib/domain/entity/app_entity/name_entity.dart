import 'package:json_annotation/json_annotation.dart';
part 'name_entity.g.dart';

@JsonSerializable()
class NameEntity {
  String ar;
  String en;

  NameEntity({
    required this.en,
    required this.ar,
  });

  factory NameEntity.fromJson(Map<String, dynamic> json) =>
      _$NameEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NameEntityToJson(this);
}
