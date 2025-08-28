import 'package:json_annotation/json_annotation.dart';
part 'pagination_model.g.dart';

@JsonSerializable()
class PaginationModel {
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "prev_page_url")
  String? prevPageUrl;
  @JsonKey(name: "next_page_url")
  String? nextPageUrl;
  @JsonKey(name: "last_page")
  int? lastPage;
  @JsonKey(name: "per_page")
  int? perPage;
  int? total;
  String? path;

  PaginationModel({
    this.path,
    this.total,
    this.currentPage,
    this.lastPage,
    this.nextPageUrl,
    this.perPage,
    this.prevPageUrl,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}
