import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/chat_model/chat_user_info_model.dart';
part 'story_model.g.dart';

@JsonSerializable()
class StoryPaginationModel {
  List<StoryModel>? data;
  PaginationModel? pagination;

  StoryPaginationModel({
    this.data,
    this.pagination,
  });

  factory StoryPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$StoryPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryPaginationModelToJson(this);
}

@JsonSerializable()
class StoryModel {
  int? id;
  ChatUserInfoModel? user;
  List<StoryMediaModel>? media;
  @JsonKey(name: "created_at")
  String? createdAt;
  String? link;
  String? location;
  @JsonKey(name: "is_comment")
  int? isComment;
  String? music;
  List<String>? tag;
  String? description;
  String? title;

  StoryModel({
    this.id,
    this.user,
    this.media,
    this.createdAt,
    this.isComment,
    this.music,
    this.location,
    this.link,
    this.tag,
    this.title,
    this.description,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryModelToJson(this);
}

@JsonSerializable()
class StoryMediaModel {
  int? id;
  String? url;
  String? type;
  @JsonKey(name: "count_comments")
  int? countComments;
  @JsonKey(name: "count_views")
  int? countViews;
  @JsonKey(name: "count_share")
  int? countShare;
  @JsonKey(name: "is_view")
  int? isView;
  @JsonKey(name: "is_like")
  int? isLike;
  @JsonKey(name: "is_save")
  int? isSave;
  @JsonKey(name: "is_friend")
  int? isFriend;
  String? thump;

  StoryMediaModel({
    this.id,
    this.type,
    this.url,
    this.countShare,
    this.countViews,
    this.countComments,
    this.isFriend,
    this.isSave,
    this.isLike,
    this.isView,
    this.thump,
  });

  factory StoryMediaModel.fromJson(Map<String, dynamic> json) =>
      _$StoryMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryMediaModelToJson(this);
}
