import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseMapModel<T> {
  bool? success;
  String? message;
  final T? data;

  BaseMapModel({this.success = false, this.data, this.message});

  factory BaseMapModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseMapModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJson) =>
      _$BaseMapModelToJson(this, toJson);
}

@JsonSerializable(genericArgumentFactories: true)
class BaseListModel<T> {
  bool? success;
  String? message;
  List<T>? data;

  BaseListModel({this.success = false, this.data, this.message});

  factory BaseListModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseListModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJson) =>
      _$BaseListModelToJson(this, toJson);
}
