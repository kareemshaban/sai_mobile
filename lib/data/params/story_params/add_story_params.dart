import 'package:json_annotation/json_annotation.dart';
part 'add_story_params.g.dart';

@JsonSerializable()
class AddStoryParams {
  final List<MediaParams> images;
  @JsonKey(name: "view_state")
  final String viewState;
  @JsonKey(name: "is_comment", toJson: commentToJson)
  final bool canComment;
  final String? location;
  final List<MediaParams> videos;
  final String description;
  @JsonKey(includeIfNull: false)
  final String? music;
  final String? link;
  final List<String>? hashTags;
  final List<int>? mentionsIds;

  AddStoryParams(
      {required this.images,
      required this.viewState,
      required this.canComment,
      required this.location,
      required this.videos,
      required this.description,
      this.hashTags,
      this.music,
      this.link,
      this.mentionsIds});

  Map<String, dynamic> toJson() => _$AddStoryParamsToJson(this);
  static int commentToJson(bool canCommnet) {
    return canCommnet ? 1 : 0;
  }

  AddStoryParams copyWith(
          {List<MediaParams>? images,
          String? viewState,
          bool? canComment,
          String? location,
          String? description,
          List<MediaParams>? videos,
          List<String>? hashTags,
          String? link,
          List<int>? mentionsIds}) =>
      AddStoryParams(
          videos: videos ?? this.videos,
          canComment: canComment ?? this.canComment,
          images: images ?? this.images,
          location: location ?? this.location,
          viewState: viewState ?? this.viewState,
          description: description ?? this.description,
          music: music,
          link: link ?? this.link,
          hashTags: hashTags ?? this.hashTags,
          mentionsIds: mentionsIds ?? this.mentionsIds);

  factory AddStoryParams.fromJson(Map<String, dynamic> json) =>
      _$AddStoryParamsFromJson(json);
}

@JsonSerializable()
class MediaParams {
  String file;
  String type;
  @JsonKey(includeIfNull: false)
  String? thump;

  MediaParams({
    required this.type,
    required this.file,
    this.thump,
  });

  factory MediaParams.fromJson(Map<String, dynamic> json) =>
      _$MediaParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MediaParamsToJson(this);
}
