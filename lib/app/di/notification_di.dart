import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/data_source/notification_data_source/notification_remote_data_source.dart';
import 'package:new_sai/data/repository/notification_repository_impl.dart';
import 'package:new_sai/domain/repository/notification_repository.dart';
import 'package:new_sai/domain/use_case/notification_use_case/delete_all_notifications_use_case.dart';
import 'package:new_sai/domain/use_case/notification_use_case/get_notification_count_use_case.dart';
import 'package:new_sai/domain/use_case/notification_use_case/get_notification_use_case.dart';
import 'package:new_sai/domain/use_case/notification_use_case/mark_all_notifications_as_read_use_case.dart';

initNotificationModule() {
  instance.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(instance(), instance()));

  instance.registerLazySingleton<GetNotificationUseCase>(
      () => GetNotificationUseCase(instance()));

  instance.registerLazySingleton<MarkAllNotificationsAsReadUseCase>(
      () => MarkAllNotificationsAsReadUseCase(instance()));

  instance.registerLazySingleton<GetNotificationCountUseCase>(
      () => GetNotificationCountUseCase(instance()));

  instance.registerLazySingleton<DeleteAllNotificationsUseCase>(
      () => DeleteAllNotificationsUseCase(instance()));
}
