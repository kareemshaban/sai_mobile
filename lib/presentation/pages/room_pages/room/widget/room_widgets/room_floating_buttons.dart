import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/gifts_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/options_bottom_sheets.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/clear_message_dialog.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class RoomFloatingButtons extends GetView<RoomController> {
  const RoomFloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.enableScroll || controller.loadingJoinRoom
          ? const SizedBox()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.messages.length > 5) ...[
                  InkWell(
                    onTap: controller.loadingJoinRoom
                        ? null
                        : () => Get.dialog(const ClearMessageDialog()),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.white,
                      ),
                      child: const Icon(
                        Icons.clear_all_rounded,
                        size: 25,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                  10.verticalSpace(),
                ],
                InkWell(
                  onTap: controller.loadingJoinRoom
                      ? null
                      : () => Get.bottomSheet(const OptionsBottomSheets()),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: ColorManager.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.menu_open_outlined,
                      size: 25,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                10.verticalSpace(),
                InkWell(
                  onTap: controller.loadingJoinRoom
                      ? null
                      : () => Get.bottomSheet(const GiftsBottomSheet()),
                  child: Column(
                    children: [
                      const AppIcon(
                        width: 30,
                        height: 30,
                        icon: IconsAssets.gift,
                      ),
                      2.verticalSpace(),
                      Text(
                        AppStrings.gift,
                        style: Get.textTheme.bodySmall!.copyWith(
                          fontSize: AppSize.s15(context),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
