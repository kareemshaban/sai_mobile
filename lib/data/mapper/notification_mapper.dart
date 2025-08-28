import 'package:new_sai/app/constants.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/notification_model/notification_model.dart';
import 'package:new_sai/data/model/notification_model/un_read_notification_count_model.dart';
import 'package:new_sai/domain/entity/notification_entity/notification_entity.dart';
import 'package:new_sai/domain/entity/notification_entity/un_read_notification_count_entity.dart';

extension NotificationPaginationMapper on NotificationPaginationModel? {
  NotificationPaginationEntity toDomain() {
    return NotificationPaginationEntity(
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension NotificationMapper on NotificationModel? {
  NotificationEntity toDomain() {
    return NotificationEntity(
      id: this?.id ?? Constants.empty,
      content:
          this?.content?.toDomain() ?? NotificationContentModel().toDomain(),
      createdAt: this?.createdAt ?? Constants.empty,
      readAt: this?.readAt ?? Constants.empty,
    );
  }
}

extension NotificationContentMapper on NotificationContentModel? {
  NotificationContentEntity toDomain() {
    return NotificationContentEntity(
      title: this?.title?.toDomain() ?? ArEnNameModel().toDomain(),
      message: this?.message?.toDomain() ?? ArEnNameModel().toDomain(),
      image: this?.image ?? Constants.empty,
      type: this?.type ?? Constants.empty,
      id: this?.id,
    );
  }
}

extension ArEnNamemapper on ArEnNameModel? {
  ArEnNameEntity toDomain() {
    return ArEnNameEntity(
      ar: this?.ar ?? Constants.empty,
      en: this?.en ?? Constants.empty,
    );
  }
}

extension NotificationIdMapper on NotificationIDModel? {
  NotificationIDEntity toDomain() {
    return NotificationIDEntity(
      chatId: this?.chatId ?? Constants.zero,
      logo: this?.logo ?? Constants.empty,
      userName: this?.userName ?? Constants.empty,
      reciverId: this?.reciverId ?? Constants.zero,
    );
  }
}

extension UnReadNotificationCountMapper on UnReadNotificationCountModel? {
  UnReadNotificationCountEntity toDomain() {
    return UnReadNotificationCountEntity(
      unreadCount: this?.unreadCount ?? Constants.zero,
    );
  }
}
