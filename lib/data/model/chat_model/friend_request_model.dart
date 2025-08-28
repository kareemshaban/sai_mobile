import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
part 'friend_request_model.g.dart';

@JsonSerializable()
class FriendRequestPaginationModel {
  List<FriendRequestModel>? data;
  PaginationModel? pagination;

  FriendRequestPaginationModel({
    this.data,
    this.pagination,
  });

  factory FriendRequestPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendRequestPaginationModelToJson(this);
}

@JsonSerializable()
class FriendRequestModel {
  int? id;
  @JsonKey(name: "reference_id")
  num? referenceId;
  String? name;
  @JsonKey(name: "profile_img")
  String? profileImg;
  @JsonKey(name: "profile_level")
  num? profileLevel;
  String? description;
  @JsonKey(name: "friend_id")
  num? friendId;
  @JsonKey(name: "is_friend_accepted")
  num? isFriendAccepted;

  FriendRequestModel({
    this.id,
    this.name,
    this.description,
    this.friendId,
    this.isFriendAccepted,
    this.profileImg,
    this.profileLevel,
    this.referenceId,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendRequestModelToJson(this);
}
