import 'package:json_annotation/json_annotation.dart';
part 'tag_model.g.dart';

@JsonSerializable()
class TagModel {
  int? id;
  String? name;

  TagModel({
    this.id,
    this.name,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}
