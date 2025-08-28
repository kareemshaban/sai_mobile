import 'package:json_annotation/json_annotation.dart';
part 'un_read_notification_count_model.g.dart';

@JsonSerializable()
class UnReadNotificationCountModel {
  @JsonKey(name: "unread_count")
  int? unreadCount;

  UnReadNotificationCountModel({this.unreadCount});

  factory UnReadNotificationCountModel.fromJson(Map<String, dynamic> json) =>
      _$UnReadNotificationCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnReadNotificationCountModelToJson(this);
}
