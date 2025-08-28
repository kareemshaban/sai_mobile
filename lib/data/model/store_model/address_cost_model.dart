import 'package:json_annotation/json_annotation.dart';
part 'address_cost_model.g.dart';

@JsonSerializable()
class AddressCostModel {
  num? cost;

  AddressCostModel({this.cost});

  factory AddressCostModel.fromJson(Map<String, dynamic> json) =>
      _$AddressCostModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressCostModelToJson(this);
}
