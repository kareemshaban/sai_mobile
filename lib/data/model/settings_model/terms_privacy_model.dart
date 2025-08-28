import 'package:json_annotation/json_annotation.dart';
part 'terms_privacy_model.g.dart';

@JsonSerializable()
class TermsPrivacyModel {
  int? id;
  @JsonKey(name: "page_name")
  String? pageName;
  String? description;

  TermsPrivacyModel({
    this.id,
    this.description,
    this.pageName,
  });

  factory TermsPrivacyModel.fromJson(Map<String, dynamic> json) =>
      _$TermsPrivacyModelFromJson(json);

  Map<String, dynamic> toJson() => _$TermsPrivacyModelToJson(this);
}
