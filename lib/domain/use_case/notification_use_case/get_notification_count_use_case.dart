import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/entity/notification_entity/un_read_notification_count_entity.dart';
import 'package:new_sai/domain/repository/notification_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class GetNotificationCountUseCase
    extends BaseUseCase<dynamic, UnReadNotificationCountEntity> {
  final NotificationRepository _notificationRepository;
  GetNotificationCountUseCase(this._notificationRepository);

  @override
  Future<Either<Failure, UnReadNotificationCountEntity>> execute(params) async {
    return await _notificationRepository.getNotificationCount();
  }
}
