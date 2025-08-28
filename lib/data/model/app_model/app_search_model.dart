import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/auth_model/user_model.dart';
import 'package:new_sai/data/model/reels_model/reels_model.dart';
part 'app_search_model.g.dart';

@JsonSerializable()
class AppSearchModel {
  List<ReelsModel>? videos;
  @JsonKey(name: "hash_tags")
  List<String>? hashTags;
  List<UserModel>? users;

  AppSearchModel({
    this.videos,
    this.hashTags,
    this.users,
  });

  factory AppSearchModel.fromJson(Map<String, dynamic> json) =>
      _$AppSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppSearchModelToJson(this);
}
