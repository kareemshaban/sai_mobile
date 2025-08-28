import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/store_model/order_model.dart';
part 'order_pagination_model.g.dart';

@JsonSerializable()
class OrderPaginationModel {
  List<OrderModel>? data;
  PaginationModel? pagination;

  OrderPaginationModel({
    this.pagination,
    this.data,
  });

  factory OrderPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$OrderPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPaginationModelToJson(this);
}
