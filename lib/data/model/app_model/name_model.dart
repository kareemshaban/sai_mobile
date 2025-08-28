import 'package:json_annotation/json_annotation.dart';
part 'name_model.g.dart';

@JsonSerializable()
class NameModel {
  String? ar;
  String? en;

  NameModel({
    this.en,
    this.ar,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) =>
      _$NameModelFromJson(json);

  Map<String, dynamic> toJson() => _$NameModelToJson(this);
}
