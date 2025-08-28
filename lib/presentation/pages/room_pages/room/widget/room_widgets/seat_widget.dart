import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/leave_mic_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/take_mic_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/unlock_mic_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room/zego_handler/live_audio_room_manager.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class SeatWidget extends StatefulWidget {
  final int index;
  final bool isLoading;
  const SeatWidget({super.key, required this.index, this.isLoading = false});

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(
      builder: (controller) {
        return ValueListenableBuilder<ZegoSDKUser?>(
          valueListenable: widget.isLoading
              ? ValueNotifier(null)
              : ZegoLiveAudioRoomManager().seatList[widget.index].currentUser,
          builder: (context, value, child) {
            return Obx(
              () {
                RxBool isSpeaking = false.obs;
                if (value == null) {
                  controller.lockedSeatList.firstWhereOrNull((element) {
                    if (element.seatIndex == widget.index) {
                      element.userID = '';
                      return true;
                    }
                    return false;
                  });
                }
                if (value != null) {
                  final streamID =
                      "${controller.roomId}_${value.userID}_speaker";
                  if (controller.soundLevel.containsKey(streamID)) {
                    isSpeaking.value = (controller.soundLevel[streamID]! > 1);
                  } else {
                    isSpeaking.value = false;
                  }
                  controller.lockedSeatList.firstWhereOrNull((element) {
                    if (element.seatIndex == widget.index) {
                      element.userID = value.userID;
                      return true;
                    }
                    return false;
                  });
                }
                bool isLocked = controller.lockedSeatList
                        .firstWhereOrNull(
                            (element) => element.seatIndex == widget.index)
                        ?.seatValue ??
                    false;
                bool isCurrentUser =
                    controller.user.id.toString() == value?.userID;
                bool isEmptySeat = value == null;
                bool isUserSpeaking =
                    (controller.user.id.toString() == value?.userID &&
                            controller.isSpeaking) ||
                        isSpeaking.value;
                bool isMuted = controller.mutedListLocally
                        .any((element) => element == value?.userID) ||
                    controller.mutedList
                        .any((element) => element == value?.userID);
                bool isMutedToAll = controller.mutedList
                    .any((element) => element == controller.user.id.toString());
                final privi = controller.apiUsers
                    .firstWhereOrNull(
                        (element) => element.id.toString() == value?.userID)
                    ?.privileges;
                return InkWell(
                  onTap: widget.isLoading
                      ? null
                      : () {
                          if (isMutedToAll) {
                            showSnackBarWidget(
                                message: AppStrings.youAreBannedFromChatting);
                            return;
                          }
                          if (isLocked) {
                            if (controller.isAdmin()) {
                              Get.bottomSheet(
                                  UnlockMicBottomSheet(widget.index));
                            }
                          } else {
                            if (isCurrentUser) {
                              Get.bottomSheet(
                                  LeaveMicBottomSheet(index: widget.index));
                            } else {
                              if (isEmptySeat) {
                                Get.bottomSheet(
                                    TakeMicBottomSheet(index: widget.index));
                              } else {
                                controller.openProfileBottomSheet(value.userID);
                              }
                            }
                          }
                        },
                  child: SizedBox(
                    width: 1.w(context) / 8,
                    // height: privi != null && privi.categoryId != 0 ? 82 : 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.white.withOpacity(.3),
                              ),
                              child: isLocked
                                  ? const Icon(
                                      Icons.lock,
                                      color: ColorManager.white,
                                      size: 34,
                                    )
                                  : value != null
                                      ? Stack(
                                          alignment: Alignment.center,
                                          clipBehavior: Clip.none,
                                          children: [
                                            RippleAnimation(
                                              color: ColorManager.rippleColor,
                                              delay: Duration.zero,
                                              repeat: true,
                                              maxRadius:
                                                  isUserSpeaking ? 22 : 0,
                                              minRadius:
                                                  isUserSpeaking ? 22 : 0,
                                              ripplesCount: 10,
                                              duration: const Duration(
                                                  milliseconds: 6 * 300),
                                              child: AppImage(
                                                image: controller
                                                    .getUserImage(value.userID),
                                                isCircle: true,
                                                fit: BoxFit.cover,
                                                errorWidget: controller
                                                    .userErrorImageWidget(),
                                              ),
                                            ),
                                            if (isMuted)
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: ColorManager.black
                                                      .withOpacity(.3),
                                                ),
                                                child: const Icon(
                                                  Icons.mic_off_outlined,
                                                  color: ColorManager.white,
                                                ),
                                              ),
                                          ],
                                        )
                                      : const Icon(
                                          Icons.mic_none_outlined,
                                          color: ColorManager.white,
                                          size: 34,
                                        ),
                            ),
                            if (privi != null && privi.categoryId != 0)
                              PrivilegeDataView(
                                url: privi.data.profileFrame.file,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                          ],
                        ),
                        3.5.verticalSpace(),
                        Text(
                          isLocked
                              ? AppStrings.locked
                              : value != null
                                  ? value.userName
                                  : (widget.index + 1).toString(),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodySmall!.copyWith(
                            fontSize: AppSize.s12(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
