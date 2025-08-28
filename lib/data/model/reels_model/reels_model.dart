import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/auth_model/user_model.dart';
import 'package:new_sai/data/model/chat_model/chat_user_info_model.dart';
part 'reels_model.g.dart';

@JsonSerializable()
class ReelsPaginationModel {
  List<ReelsModel>? data;
  PaginationModel? pagination;

  ReelsPaginationModel({
    this.data,
    this.pagination,
  });

  factory ReelsPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$ReelsPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelsPaginationModelToJson(this);
}

@JsonSerializable()
class ReelsModel {
  int? id;
  ChatUserInfoModel? user;
  String? video;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "is_comment")
  int? isComment;
  @JsonKey(name: "count_comments")
  int? countComments;
  @JsonKey(name: "count_views")
  int? countViews;
  @JsonKey(name: "count_likes")
  int? countLikes;
  @JsonKey(name: "count_saves")
  int? countSaves;
  @JsonKey(name: "count_share")
  int? countShare;
  String? description;
  String? location;
  List<UserModel>? mentions;
  @JsonKey(name: "is_view")
  int? isView;
  @JsonKey(name: "is_like")
  int? isLike;
  @JsonKey(name: "is_save")
  int? isSave;
  @JsonKey(name: "is_friend")
  int? isFriend;
  @JsonKey(name: "is_follow")
  int? isFollow;
  @JsonKey(name: "is_following")
  int? isFollowing;
  List<String>? tag;
  String? thumb;
  List<ReelsMediaModel>? media;
  String? music;

  ReelsModel({
    this.id,
    this.user,
    this.createdAt,
    this.description,
    this.video,
    this.countComments,
    this.countShare,
    this.countViews,
    this.isComment,
    this.location,
    this.isLike,
    this.countLikes,
    this.countSaves,
    this.isSave,
    this.isView,
    this.mentions,
    this.isFriend,
    this.tag,
    this.thumb,
    this.media,
    this.music,
    this.isFollow,
    this.isFollowing,
  });

  factory ReelsModel.fromJson(Map<String, dynamic> json) =>
      _$ReelsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelsModelToJson(this);
}

@JsonSerializable()
class ReelsMediaModel {
  int? id;
  String? url;
  String? type;
  String? thump;

  ReelsMediaModel({
    this.id,
    this.url,
    this.type,
    this.thump,
  });

  factory ReelsMediaModel.fromJson(Map<String, dynamic> json) =>
      _$ReelsMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelsMediaModelToJson(this);
}
