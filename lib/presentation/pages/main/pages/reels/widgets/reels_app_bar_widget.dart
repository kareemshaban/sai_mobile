import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/getx/reels_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/rooms_app_bar_filter_item.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class ReelsAppBarWidget extends GetView<ReelsController> {
  final void Function()? onTapAdd;
  const ReelsAppBarWidget({this.onTapAdd, super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Obx(
            () => Row(
              children: [
                InkWell(
                  onTap: onTapAdd,
                  child: const Icon(
                    Icons.add,
                    color: ColorManager.white,
                    size: 30,
                  ),
                ),
                const Spacer(),
                RoomsAppBarFilterItem(
                  title: AppStrings.following,
                  isActive: controller.reelsFilter == 1,
                  color: controller.reelsFilter == 1
                      ? ColorManager.white
                      : ColorManager.white.withOpacity(.6),
                  onTap: () => controller.onChangeReelsFilter(1),
                ),
                20.horizontalSpace(),
                RoomsAppBarFilterItem(
                  title: AppStrings.forYou,
                  isActive: controller.reelsFilter == 0,
                  color: controller.reelsFilter == 0
                      ? ColorManager.white
                      : ColorManager.white.withOpacity(.6),
                  onTap: () => controller.onChangeReelsFilter(0),
                ),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    controller.videoPlayerController?.pause();
                    await Get.toNamed(AppRoutes.searchPostRoute);
                    controller.videoPlayerController?.play();
                  },
                  child: const Icon(
                    Icons.search,
                    color: ColorManager.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
