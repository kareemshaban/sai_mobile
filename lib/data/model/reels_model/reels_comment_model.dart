import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/chat_model/chat_user_info_model.dart';
part 'reels_comment_model.g.dart';

@JsonSerializable()
class ReelsCommentPaginationModel {
  List<ReelsCommentModel>? data;
  PaginationModel? pagination;

  ReelsCommentPaginationModel({
    this.data,
    this.pagination,
  });

  factory ReelsCommentPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$ReelsCommentPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelsCommentPaginationModelToJson(this);
}

@JsonSerializable()
class ReelsCommentModel {
  int? id;
  String? comment;
  ChatUserInfoModel? user;
  @JsonKey(name: "created_at")
  String? createdAt;

  ReelsCommentModel({
    this.id,
    this.comment,
    this.user,
    this.createdAt,
  });

  factory ReelsCommentModel.fromJson(Map<String, dynamic> json) =>
      _$ReelsCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReelsCommentModelToJson(this);
}
