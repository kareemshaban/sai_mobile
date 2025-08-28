import 'package:json_annotation/json_annotation.dart';
part 'unique_id_model.g.dart';

@JsonSerializable()
class UniqueIdModel {
  int? id;
  String? name;
  @JsonKey(name: "category_icon")
  String? categoryIcon;
  @JsonKey(name: "category_description")
  String? categoryDescription;
  List<UniqueSubCategoryModel>? subcategories;

  UniqueIdModel({
    this.id,
    this.name,
    this.categoryIcon,
    this.categoryDescription,
    this.subcategories,
  });

  factory UniqueIdModel.fromJson(Map<String, dynamic> json) =>
      _$UniqueIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$UniqueIdModelToJson(this);
}

@JsonSerializable()
class UniqueSubCategoryModel {
  int? id;
  String? name;
  List<PatternsModel>? patterns;

  UniqueSubCategoryModel({
    this.id,
    this.name,
    this.patterns,
  });

  factory UniqueSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$UniqueSubCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UniqueSubCategoryModelToJson(this);
}

@JsonSerializable()
class PatternsModel {
  int? id;
  String? name;

  PatternsModel({
    this.id,
    this.name,
  });

  factory PatternsModel.fromJson(Map<String, dynamic> json) =>
      _$PatternsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatternsModelToJson(this);
}
