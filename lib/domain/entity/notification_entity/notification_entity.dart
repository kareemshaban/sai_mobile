import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';

class NotificationPaginationEntity {
  List<NotificationEntity> data;
  PaginationEntity pagination;

  NotificationPaginationEntity({
    required this.pagination,
    required this.data,
  });
}

class NotificationEntity {
  String id;
  NotificationContentEntity content;
  String createdAt;
  String readAt;

  NotificationEntity({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.readAt,
  });

  static final fakeData = NotificationEntity(
      id: "0",
      content: NotificationContentEntity(
        title:
            ArEnNameEntity(ar: "adaslkmdalsmdlar", en: "dlkasmdlksamdmasden"),
        message:
            ArEnNameEntity(ar: "ada;s,dl;as,dl;asr", en: "akdmskladmlasen"),
        image: "image",
        type: "type",
        id: NotificationIDEntity(
          chatId: 0,
          logo: "logo",
          userName: "userName",
          reciverId: 0,
        ),
      ),
      createdAt: "createdAt",
      readAt: "readAt");
}

class NotificationContentEntity {
  ArEnNameEntity title;
  ArEnNameEntity message;
  String image;
  String type;
  dynamic id;

  NotificationContentEntity({
    required this.title,
    required this.message,
    required this.image,
    required this.type,
    required this.id,
  });
}

class ArEnNameEntity {
  String en;
  String ar;

  String get name =>
      instance<AppPreferences>().getAppLanguage() == arabic ? ar : en;

  ArEnNameEntity({
    required this.ar,
    required this.en,
  });
}

class NotificationIDEntity {
  String userName;
  String logo;
  int reciverId;
  int chatId;

  NotificationIDEntity({
    required this.chatId,
    required this.logo,
    required this.userName,
    required this.reciverId,
  });
}
