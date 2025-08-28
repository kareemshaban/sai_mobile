import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationPaginationModel {
  List<NotificationModel>? data;
  PaginationModel? pagination;

  NotificationPaginationModel({
    this.pagination,
    this.data,
  });

  factory NotificationPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPaginationModelToJson(this);
}

@JsonSerializable()
class NotificationModel {
  String? id;
  NotificationContentModel? content;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "read_at")
  String? readAt;

  NotificationModel({
    this.id,
    this.content,
    this.createdAt,
    this.readAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class NotificationContentModel {
  ArEnNameModel? title;
  ArEnNameModel? message;
  String? image;
  String? type;
  dynamic id;

  NotificationContentModel({
    this.title,
    this.message,
    this.image,
    this.type,
    this.id,
  });

  factory NotificationContentModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationContentModelToJson(this);
}

@JsonSerializable()
class ArEnNameModel {
  String? en;
  String? ar;

  ArEnNameModel({
    this.ar,
    this.en,
  });

  factory ArEnNameModel.fromJson(Map<String, dynamic> json) =>
      _$ArEnNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArEnNameModelToJson(this);
}

@JsonSerializable()
class NotificationIDModel {
  @JsonKey(name: "user_name")
  String? userName;
  String? logo;
  @JsonKey(name: "reciver_id")
  int? reciverId;
  @JsonKey(name: "chat_id")
  int? chatId;

  NotificationIDModel({
    this.chatId,
    this.logo,
    this.userName,
    this.reciverId,
  });

  factory NotificationIDModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationIDModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationIDModelToJson(this);
}
