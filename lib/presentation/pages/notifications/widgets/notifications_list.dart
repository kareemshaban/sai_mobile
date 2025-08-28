import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/notification_entity/notification_entity.dart';
import 'package:new_sai/presentation/pages/notifications/getx/notifications_controller.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';
import 'package:new_sai/presentation/widgets/pull_to_refresh_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'notification_item.dart';

class NotificationsList extends GetView<NotificationsController> {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingNotification
          ? ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (context, index) => Skeletonizer(
                enabled: true,
                effect: const ShimmerEffect(),
                child: NotificationItem(
                  model: NotificationEntity.fakeData,
                ),
              ),
              separatorBuilder: (context, index) => 15.verticalSpace(),
              itemCount: 4,
            )
          : PullToRefreshWidget(
              controller: controller.refreshController,
              scrollController: controller.scrollController,
              onRefresh: () => controller.getNotification(),
              child: controller.notifications.isEmpty
                  ? const EmptyDataWidget()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemBuilder: (context, index) => NotificationItem(
                        model: controller.notifications[index],
                      ),
                      separatorBuilder: (context, index) => 15.verticalSpace(),
                      itemCount: controller.notifications.length,
                    ),
            ),
    );
  }
}
