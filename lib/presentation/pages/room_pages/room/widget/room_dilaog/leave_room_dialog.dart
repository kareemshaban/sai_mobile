import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:x_overlay/x_overlay.dart';

class LeaveRoomDialog extends GetView<RoomController> {
  const LeaveRoomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BounceInUp(
            curve: Curves.linear,
            duration: const Duration(milliseconds: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                XOverlayButton(
                  controller: AppRoutes.overlayController,
                  iconSize: const Size(150, 150),
                  dataQuery: () {
                    return XOverlayData();
                  },
                  icon: InkWell(
                    onTap: () {
                      Get.back();
                      AppRoutes.overlayController.overlay(
                        context,
                        data: XOverlayData(),
                        rootNavigator: true,
                      );
                    },
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: ColorManager.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.ios_share_outlined,
                        color: ColorManager.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                8.verticalSpace(),
                Text(
                  AppStrings.keep,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontSize: AppSize.s20(context),
                  ),
                )
              ],
            ),
          ),
          40.verticalSpace(),
          BounceInDown(
            curve: Curves.linear,
            duration: const Duration(milliseconds: 300),
            child: InkWell(
              onTap: controller.backToMainRoute,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: ColorManager.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.logout,
                      color: ColorManager.white,
                      size: 40,
                    ),
                  ),
                  8.verticalSpace(),
                  Text(
                    AppStrings.exit,
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: AppSize.s20(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
