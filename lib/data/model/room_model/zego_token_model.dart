import 'package:json_annotation/json_annotation.dart';
part 'zego_token_model.g.dart';

@JsonSerializable()
class ZegoTokenModel {
  @JsonKey(name: "zego-token")
  String? zegoToken;

  ZegoTokenModel({this.zegoToken});

  factory ZegoTokenModel.fromJson(Map<String, dynamic> json) =>
      _$ZegoTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$ZegoTokenModelToJson(this);
}
