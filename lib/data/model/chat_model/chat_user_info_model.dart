import 'package:json_annotation/json_annotation.dart';
part 'chat_user_info_model.g.dart';

@JsonSerializable()
class ChatUserInfoModel {
  int? id;
  String? name;
  String? logo;
  @JsonKey(name: "reference_id")
  num? referenceId;

  ChatUserInfoModel({
    this.id,
    this.name,
    this.logo,
    this.referenceId,
  });

  factory ChatUserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ChatUserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUserInfoModelToJson(this);
}
