import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class EmptyMusicList extends GetView<RoomController> {
  const EmptyMusicList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: controller.onTapHideMusicPlayer,
          child: const Icon(
            CupertinoIcons.chevron_down,
            size: 20,
            color: ColorManager.white,
          ),
        ),
        Text(
          AppStrings.emptyList,
          style: Get.textTheme.bodySmall!.copyWith(
            fontSize: AppSize.s15(context),
            color: Colors.white70,
          ),
        ),
        10.verticalSpace(),
        InkWell(
          onTap: controller.openMusicPlaylistView,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorManager.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              AppStrings.addMusic,
              style: Get.textTheme.bodySmall!.copyWith(
                fontSize: AppSize.s15(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
