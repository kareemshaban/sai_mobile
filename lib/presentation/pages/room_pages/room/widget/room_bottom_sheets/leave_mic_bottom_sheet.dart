import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class LeaveMicBottomSheet extends GetView<RoomController> {
  final int index;
  const LeaveMicBottomSheet({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      color: ColorManager.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            title: AppStrings.leaveMic,
            width: 1.w(context),
            backgroundColor: ColorManager.white,
            textStyle: Get.textTheme.titleSmall!.copyWith(
              fontSize: AppSize.s20(context),
            ),
            elevation: 0,
            onTap: () => controller.leaveMic(index),
          ),
          10.verticalSpace(),
          AppButton(
            title: AppStrings.back,
            width: 1.w(context),
            backgroundColor: ColorManager.white,
            textStyle: Get.textTheme.titleSmall!.copyWith(
              fontSize: AppSize.s20(context),
            ),
            elevation: 0,
            onTap: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
