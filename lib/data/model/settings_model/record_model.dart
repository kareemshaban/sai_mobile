import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
part 'record_model.g.dart';

@JsonSerializable()
class RecordPaginationModel {
  List<RecordModel>? data;
  PaginationModel? pagination;

  RecordPaginationModel({
    this.data,
    this.pagination,
  });

  factory RecordPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$RecordPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecordPaginationModelToJson(this);
}

@JsonSerializable()
class RecordModel {
  int? id;
  @JsonKey(name: "to_id")
  int? toId;
  String? user;
  @JsonKey(name: "gold_value")
  num? goldValue;
  String? date;

  RecordModel({
    this.id,
    this.toId,
    this.user,
    this.goldValue,
    this.date,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) =>
      _$RecordModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecordModelToJson(this);
}
