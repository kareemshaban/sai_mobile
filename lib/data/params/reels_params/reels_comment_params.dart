import 'package:json_annotation/json_annotation.dart';
part 'reels_comment_params.g.dart';

@JsonSerializable()
class ReelsCommentParams {
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? id;
  @JsonKey(includeIfNull: false)
  String? comment;

  ReelsCommentParams({
    this.comment,
    this.id,
  });

  factory ReelsCommentParams.fromJson(Map<String, dynamic> json) =>
      _$ReelsCommentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ReelsCommentParamsToJson(this);
}
