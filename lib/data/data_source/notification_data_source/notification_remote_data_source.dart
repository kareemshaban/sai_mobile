import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/model/notification_model/notification_model.dart';
import 'package:new_sai/data/model/notification_model/un_read_notification_count_model.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/end_point.dart';

abstract class NotificationRemoteDataSource {
  Future<BaseMapModel<NotificationPaginationModel>> getNotification(int params);
  Future<BaseListModel> markAllAsRead();
  Future<BaseMapModel<UnReadNotificationCountModel>> getNotificationCount();
  Future<BaseListModel> deleteAllNotifications();
}

class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource {
  final AppServiceClient _appServiceClient;
  NotificationRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseMapModel<NotificationPaginationModel>> getNotification(
      int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.getNotification,
      NotificationPaginationModel.fromJson,
      params: {
        "page": params,
      },
    );
  }

  @override
  Future<BaseListModel> markAllAsRead() async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.markAsRead,
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<UnReadNotificationCountModel>>
      getNotificationCount() async {
    return await _appServiceClient.performGetRequest(
      EndPoint.notificationCount,
      UnReadNotificationCountModel.fromJson,
    );
  }

  @override
  Future<BaseListModel> deleteAllNotifications() async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.deleteAllNotification,
      (value) => null,
    );
  }
}
