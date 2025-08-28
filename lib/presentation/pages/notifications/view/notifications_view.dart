import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/notifications/getx/notifications_controller.dart';
import 'package:new_sai/presentation/pages/notifications/widgets/delete_notification_dialog.dart';
import 'package:new_sai/presentation/pages/notifications/widgets/notifications_list.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(AppStrings.notifications),
        actions: [
          InkWell(
            onTap: () => Get.dialog(const DeleteNotificationDialog()),
            child: const AppIcon(
              icon: IconsAssets.delete,
              width: 20,
              height: 20,
            ),
          ),
          16.horizontalSpace(),
        ],
      ),
      body: const NotificationsList(),
    );
  }
}
