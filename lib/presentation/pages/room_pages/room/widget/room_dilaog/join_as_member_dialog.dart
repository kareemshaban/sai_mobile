import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class JoinAsMemberDialog extends GetView<RoomController> {
  const JoinAsMemberDialog({super.key});

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
              AppStrings.didYouWantToBecomeMemberInThisRoom,
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s20(context),
              ),
            ),
            20.verticalSpace(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: AppStrings.back,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    onTap: () => Get.back(),
                  ),
                ),
                8.horizontalSpace(),
                Expanded(
                  child: AppButton(
                    title: AppStrings.accept,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    backgroundColor: ColorManager.green,
                    onTap: controller.joinAsMember,
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
