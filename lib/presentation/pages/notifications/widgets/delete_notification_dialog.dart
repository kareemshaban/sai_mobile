import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/notifications/getx/notifications_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class DeleteNotificationDialog extends GetView<NotificationsController> {
  const DeleteNotificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.white,
      surfaceTintColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.areYouSureYouWantToDeleteAllNotifications,
              style: Get.textTheme.labelLarge!.copyWith(
                fontSize: AppSize.s20(context),
              ),
            ),
            20.verticalSpace(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: AppStrings.cancel,
                    onTap: () => Get.back(),
                  ),
                ),
                10.horizontalSpace(),
                Expanded(
                  child: AppButton(
                    title: AppStrings.delete,
                    onTap: controller.deleteAllNotification,
                    backgroundColor: ColorManager.appRedColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
