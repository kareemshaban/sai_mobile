import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class ClearMessageDialog extends GetView<RoomController> {
  const ClearMessageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: ColorManager.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.deleteMessagesWithinTheRoom,
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s20(context),
              ),
            ),
            20.verticalSpace(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    height: 40,
                    title: AppStrings.back,
                    textSize: AppSize.s16(context),
                    onTap: () => Get.back(),
                  ),
                ),
                10.horizontalSpace(),
                Expanded(
                  child: AppButton(
                    height: 40,
                    title: AppStrings.delete,
                    backgroundColor: ColorManager.red,
                    textSize: AppSize.s16(context),
                    onTap: controller.clearMessagesLocaly,
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
