import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/my_theme_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/raise_hand_request_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/request_mic_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/set_room_lock_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_option_item.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class OptionsBottomSheets extends GetView<RoomController> {
  const OptionsBottomSheets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: .2.w(context),
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          30.verticalSpace(),
          GridView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            children: [
              RoomOptionItem(
                title: AppStrings.roomSongs,
                icon: Icons.music_note_rounded,
                onTap: () {
                  Get.back();
                  controller.onTapShowMusicPlayer();
                },
              ),
              if (controller.isOwner())
                RoomOptionItem(
                  title: AppStrings.settings,
                  icon: Icons.settings,
                  onTap: () {
                    Get.toNamed(AppRoutes.roomSettingsRoute,
                        arguments: controller.roomId);
                  },
                ),
              if (controller.isAdmin())
                RoomOptionItem(
                  title: AppStrings.clearRoomConversation,
                  icon: Icons.comments_disabled_outlined,
                  onTap: controller.clearAllRoomMessages,
                ),
              if (controller.isOwner())
                RoomOptionItem(
                  title: AppStrings.lockRoom,
                  icon: Icons.lock_outline,
                  onTap: () {
                    Get.back();
                    Get.dialog(const SetRoomLockDialog());
                  },
                ),
              if (!controller.isAdmin() &&
                  controller.lockedSeatList.every((element) {
                    if (element.seatValue) {
                      return true;
                    }
                    if (!element.seatValue && element.userID.isNotEmpty) {
                      return true;
                    }
                    return false;
                  }))
                RoomOptionItem(
                  title: AppStrings.requestMic,
                  icon: Icons.back_hand_outlined,
                  onTap: () {
                    Get.back();
                    Get.dialog(const RequestMicDialog());
                  },
                ),
              if (controller.isAdmin())
                RoomOptionItem(
                  title: AppStrings.raiseHandRequest,
                  icon: Icons.back_hand_outlined,
                  onTap: () {
                    Get.back();
                    Get.bottomSheet(const RaiseHandRequestBottomSheet());
                  },
                ),
              if (controller.isOwner())
                RoomOptionItem(
                  title: AppStrings.roomTheme,
                  icon: Icons.image,
                  onTap: () {
                    Get.back();
                    Get.bottomSheet( MyThemesBottomSheet(roomID: controller.roomId));
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
