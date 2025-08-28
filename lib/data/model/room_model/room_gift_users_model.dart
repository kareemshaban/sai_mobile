import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
part 'room_gift_users_model.g.dart';

@JsonSerializable()
class RoomGiftUsersModelPagination {
  List<RoomGiftUsersModel>? data;
  PaginationModel? pagination;

  RoomGiftUsersModelPagination({
    this.data,
    this.pagination,
  });

  factory RoomGiftUsersModelPagination.fromJson(Map<String, dynamic> json) =>
      _$RoomGiftUsersModelPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$RoomGiftUsersModelPaginationToJson(this);
}

@JsonSerializable()
class RoomGiftUsersModel {
  @JsonKey(name: "from_id")
  int? fromId;
  @JsonKey(name: "user_name")
  String? userName;
  @JsonKey(name: "user_image")
  String? userImage;
  @JsonKey(name: "total_price")
  String? totalPrice;
  @JsonKey(name: "gifts_count")
  num? giftsCount;
  List<String>? badges;
  @JsonKey(name: "reference_id")
  num? referenceId;

  RoomGiftUsersModel({
    this.userName,
    this.fromId,
    this.giftsCount,
    this.totalPrice,
    this.userImage,
    this.badges,
    this.referenceId,
  });

  factory RoomGiftUsersModel.fromJson(Map<String, dynamic> json) =>
      _$RoomGiftUsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomGiftUsersModelToJson(this);
}
