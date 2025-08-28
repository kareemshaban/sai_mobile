import 'package:json_annotation/json_annotation.dart';
part 'add_reels_params.g.dart';

@JsonSerializable()
class AddReelsParams {
  @JsonKey(name: "view_state", includeIfNull: false)
  String? viewState;
  @JsonKey(name: "is_comment", includeIfNull: false)
  int? isComment;
  @JsonKey(includeIfNull: false)
  String? location;
  @JsonKey(includeIfNull: false)
  String? description;
  @JsonKey(includeIfNull: false)
  String? video;
  @JsonKey(includeIfNull: false)
  String? link;
  @JsonKey(includeIfNull: false)
  List<String>? hashTags;
  @JsonKey(includeIfNull: false)
  List<int>? mentionsId;
  @JsonKey(includeIfNull: false)
  String? thumb;

  AddReelsParams({
    this.video,
    this.location,
    this.isComment,
    this.description,
    this.viewState,
    this.link,
    this.hashTags,
    this.mentionsId,
    this.thumb,
  });

  factory AddReelsParams.fromJson(Map<String, dynamic> json) =>
      _$AddReelsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddReelsParamsToJson(this);
}
