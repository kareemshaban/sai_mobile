// class TagEntity {
//   int id;
//   String name;
//
//   TagEntity({
//     required this.id,
//     required this.name,
//   });
// }
// class TagEntity {
//   int id;
//   String name;
//
//   TagEntity({
//     required this.id,
//     required this.name,
//   });
// }
import 'package:json_annotation/json_annotation.dart';

part 'tag_entity.g.dart';
@JsonSerializable()
class TagEntity {
  int id;
  String name;

  TagEntity({
    required this.id,
    required this.name,
  });

  factory TagEntity.fromJson(Map<String, dynamic> json) =>
      _$TagEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TagEntityToJson(this);
}

