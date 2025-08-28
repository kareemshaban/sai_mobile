import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class FireUserDialog extends GetView<RoomController> {
  const FireUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: ColorManager.white,
      surfaceTintColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${AppStrings.didYouWantToFireThisUser} ${controller.userProfile.name} ${context.locale == arabicLocale ? "؟" : "?"}",
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s20(context),
              ),
            ),
            20.verticalSpace(),
            Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Obx(
                    () => Checkbox(
                      value: controller.kickOutPermanently,
                      onChanged: controller.onChangeKickoutValue,
                    ),
                  ),
                ),
                8.horizontalSpace(),
                Text(
                  AppStrings.permanentlyRemove,
                  style: Get.textTheme.labelMedium!.copyWith(
                    fontSize: AppSize.s16(context),
                  ),
                ),
              ],
            ),
            20.verticalSpace(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: AppStrings.back,
                    onTap: () => Get.back(),
                  ),
                ),
                8.horizontalSpace(),
                Expanded(
                  child: AppButton(
                    title: AppStrings.kickOut,
                    backgroundColor: ColorManager.red,
                    onTap: controller.kickoutUser,
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
