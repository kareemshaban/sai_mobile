import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/room_model/room_model.dart';
part 'room_pagination_model.g.dart';

@JsonSerializable()
class RoomPaginationModel {
  List<RoomModel>? data;
  PaginationModel? pagination;

  RoomPaginationModel({
    this.data,
    this.pagination,
  });

  factory RoomPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$RoomPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomPaginationModelToJson(this);
}
