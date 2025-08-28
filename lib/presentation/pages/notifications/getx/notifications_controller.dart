import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/notification_entity/notification_entity.dart';
import 'package:new_sai/domain/use_case/notification_use_case/delete_all_notifications_use_case.dart';
import 'package:new_sai/domain/use_case/notification_use_case/get_notification_use_case.dart';
import 'package:new_sai/domain/use_case/notification_use_case/mark_all_notifications_as_read_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class NotificationsController extends GetxController {
  final scrollController = ScrollController();
  int page = 1;
  final RefreshController refreshController = RefreshController();
  final GetNotificationUseCase _getNotificationUseCase =
      instance<GetNotificationUseCase>();
  final MarkAllNotificationsAsReadUseCase _markAllAsReadUseCase =
      instance<MarkAllNotificationsAsReadUseCase>();
  final DeleteAllNotificationsUseCase _deleteAllNotificationsUseCase =
      instance<DeleteAllNotificationsUseCase>();

  final RxBool _loadingNotification = false.obs;
  final RxBool _loadingNotificationPagination = false.obs;
  final RxList<NotificationEntity> _notifications = <NotificationEntity>[].obs;
  final Rx<PaginationEntity> _pagination = PaginationModel().toDomain().obs;

  bool get loadingNotification => _loadingNotification.value;
  bool get loadingNotificationPagination =>
      _loadingNotificationPagination.value;
  List<NotificationEntity> get notifications => _notifications;
  PaginationEntity get pagination => _pagination.value;

  set loadingNotification(value) => _loadingNotification.value = value;
  set loadingNotificationPagination(value) =>
      _loadingNotificationPagination.value = value;
  set notifications(value) => _notifications.value = value;
  set pagination(value) => _pagination.value = value;

  getNotification({bool isPaginate = false}) async {
    if (!isPaginate) {
      loadingNotification = true;
      notifications.clear();
      page = 1;
    }
    (await _getNotificationUseCase.execute(page)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
        refreshController.loadFailed();
      },
      (r) {
        notifications.addAll(r.data);
        pagination = r.pagination;
        page++;
        markAsRead();

        refreshController.refreshCompleted();
      },
    );
    loadingNotification = false;
    refreshController.loadComplete();
  }

  markAsRead() async {
    (await _markAllAsReadUseCase.execute('')).fold(
      (l) {},
      (r) {
        Get.find<ProfileController>().getNotifiactionCount();
      },
    );
  }

  deleteAllNotification() async {
    Get.back();
    showAppLoadingDialog();
    (await _deleteAllNotificationsUseCase.execute("")).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) {
        Get.back();
        getNotification();
      },
    );
  }

  @override
  void onInit() async {
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (pagination.nextPageUrl.isNotEmpty &&
            !loadingNotificationPagination) {
          await getNotification(isPaginate: true);
        }
      }
    });
    await getNotification();
    super.onInit();
  }
}
