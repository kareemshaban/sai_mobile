import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/domain/repository/notification_repository.dart';
import 'package:new_sai/domain/use_case/base_use_case.dart';

class DeleteAllNotificationsUseCase extends BaseUseCase<dynamic, dynamic> {
  final NotificationRepository _notificationRepository;
  DeleteAllNotificationsUseCase(this._notificationRepository);

  @override
  Future<Either<Failure, dynamic>> execute(params) async {
    return await _notificationRepository.deleteAllNotifications();
  }
}
