import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/notification_entity/notification_entity.dart';
import 'package:new_sai/domain/repository/notification_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetNotificationUseCase
    extends BaseUseCase<int, NotificationPaginationEntity> {
  final NotificationRepository _notificationRepository;
  GetNotificationUseCase(this._notificationRepository);

  @override
  Future<Either<Failure, NotificationPaginationEntity>> execute(
      int params) async {
    return await _notificationRepository.getNotification(params);
  }
}
