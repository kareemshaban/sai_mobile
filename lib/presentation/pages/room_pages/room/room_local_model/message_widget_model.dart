import '../zego_handler/internal/internal_defines.dart';

class MessageWidgetModel {
  String? message;
  String? image;
  String? role;
  ZegoUser user;

  MessageWidgetModel({
    required this.user,
    this.message,
    this.image,
    this.role,
  });
}
