import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/zego_handler/zego_sdk_manager.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class InviteMemperDialog extends GetView<RoomController> {
  const InviteMemperDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
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
              controller.userProfile.role=='guest'?
              "${AppStrings.DoYouWantToSendAnInvitationToJoinTheRoom}":
              controller.userProfile.role == 'member'
  ? AppStrings.becomeadmin
  : controller.userProfile.role == 'admin'
    ? AppStrings.becomeaguest
    : '',
              textAlign: TextAlign.center,
              style: Get.textTheme.labelLarge!.copyWith(
                fontSize: AppSize.s18(context),
              ),
            ),
            20.verticalSpace(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: AppStrings.back,
                    backgroundColor: ColorManager.white,
                    onTap: () => Get.back(),
                    textStyle: Get.textTheme.labelMedium!.copyWith(
                      fontSize: AppSize.s20(context),
                    ),
                  ),
                ),
                10.horizontalSpace(),
                Expanded(
                  child: AppButton(
                    title: AppStrings.update,
                    onTap: ()async{
                      print(controller.userProfile.role.toString());
                      controller.sendTestMessageToUser();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
