import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class MusicSoundSlider extends GetView<RoomController> {
  const MusicSoundSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.sound,
          style: Get.textTheme.bodyMedium!.copyWith(
            fontSize: AppSize.s16(context),
          ),
        ),
        20.verticalSpace(),
        Obx(
          () => SizedBox(
            width: 0.6.w(context),
            height: 10,
            child: Slider(
              value: controller.soundValue,
              max: 100,
              min: 0,
              onChanged: controller.onChangeSoundValue,
            ),
          ),
        ),
        20.verticalSpace(),
        InkWell(
          onTap: () {
            controller.showMusicSound = false;
          },
          child: Text(
            AppStrings.cancel,
            style: Get.textTheme.bodySmall!.copyWith(
              fontSize: AppSize.s16(context),
            ),
          ),
        ),
      ],
    );
  }
}
