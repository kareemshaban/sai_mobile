import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/notification_entity/notification_entity.dart';
import 'package:new_sai/domain/entity/notification_entity/un_read_notification_count_entity.dart';

abstract class NotificationRepository {
  Future<Either<Failure, NotificationPaginationEntity>> getNotification(
      int params);

  Future<Either<Failure, dynamic>> markAllAsRead();

  Future<Either<Failure, UnReadNotificationCountEntity>> getNotificationCount();

  Future<Either<Failure, dynamic>> deleteAllNotifications();
}
