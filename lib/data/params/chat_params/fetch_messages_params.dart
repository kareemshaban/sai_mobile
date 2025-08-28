import 'package:json_annotation/json_annotation.dart';
part 'fetch_messages_params.g.dart';

@JsonSerializable()
class FetchMessagesParams {
  @JsonKey(name: "chat_id", includeFromJson: false, includeToJson: false)
  int? chatID;
  @JsonKey(name: "rec_id", includeIfNull: false)
  int? recID;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? page;

  FetchMessagesParams({
    this.chatID,
    this.recID,
    this.page,
  });

  factory FetchMessagesParams.fromJson(Map<String, dynamic> json) =>
      _$FetchMessagesParamsFromJson(json);

  Map<String, dynamic> toJson() => _$FetchMessagesParamsToJson(this);
}
