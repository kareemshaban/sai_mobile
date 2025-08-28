import 'package:json_annotation/json_annotation.dart';
part 'send_message_params.g.dart';

@JsonSerializable()
class SendMessageParams {
  @JsonKey(name: "rec_id", includeIfNull: false)
  int? recID;
  @JsonKey(includeIfNull: false)
  String? message;
  @JsonKey(includeIfNull: false)
  String? type;
  @JsonKey(includeIfNull: false)
  String? file;

  SendMessageParams({
    this.recID,
    this.message,
    this.type,
    this.file,
  });

  factory SendMessageParams.fromJson(Map<String, dynamic> json) =>
      _$SendMessageParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageParamsToJson(this);
}
