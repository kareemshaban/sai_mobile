import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/cancel_membership_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/join_as_member_dialog.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class RoomRoleWidget extends GetView<RoomController> {
  const RoomRoleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: controller.loadingJoinRoom
          ? null
          : controller.room.role == 'owner'
              ? null
              : () {
                  if (controller.room.role == 'member' ||
                      controller.room.role == 'admin') {
                    Get.dialog(const CancelMembershipDialog());
                  } else {
                    Get.dialog(const JoinAsMemberDialog());
                  }
                },
      child: Obx(
        () => Container(
          width: 45,
          height: 45,
          padding: EdgeInsets.all(controller.room.role == "owner" ? 5 : 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorManager.rippleColor.withOpacity(.2),
          ),
          child: controller.room.role == "owner"
              ? const AppIcon(
                  icon: IconsAssets.goldCrown,
                  color: ColorManager.yellowColor,
                )
              : controller.room.role == "admin" ||
                      controller.room.role == "member"
                  ? const AppIcon(
                      icon: IconsAssets.level,
                    )
                  : const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
        ),
      ),
    );
  }
}
