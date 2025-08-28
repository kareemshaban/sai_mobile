import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
part 'redeems_record_model.g.dart';

@JsonSerializable()
class RedeemsRecordPaginationModel {
  List<RedeemsRecordModel>? data;
  PaginationModel? pagination;

  RedeemsRecordPaginationModel({
    this.data,
    this.pagination,
  });

  factory RedeemsRecordPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$RedeemsRecordPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RedeemsRecordPaginationModelToJson(this);
}

@JsonSerializable()
class RedeemsRecordModel {
  int? id;
  String? date;
  @JsonKey(name: "redeem_total")
  num? redeemTotal;

  RedeemsRecordModel({
    this.id,
    this.date,
    this.redeemTotal,
  });

  factory RedeemsRecordModel.fromJson(Map<String, dynamic> json) =>
      _$RedeemsRecordModelFromJson(json);

  Map<String, dynamic> toJson() => _$RedeemsRecordModelToJson(this);
}
