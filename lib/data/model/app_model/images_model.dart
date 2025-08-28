import 'package:json_annotation/json_annotation.dart';
part 'images_model.g.dart';

@JsonSerializable()
class ImagesModel {
  int? id;
  @JsonKey(name: "image_path")
  String? imagePath;

  ImagesModel({
    this.id,
    this.imagePath,
  });

  factory ImagesModel.fromJson(Map<String, dynamic> json) =>
      _$ImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesModelToJson(this);
}
