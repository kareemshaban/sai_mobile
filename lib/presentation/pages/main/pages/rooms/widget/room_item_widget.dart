import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/room_entity/room_entity.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/theme_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:x_overlay/x_overlay.dart';

import 'check_lock_dialog.dart';

class RoomItemWidget extends StatelessWidget {
  final bool isTop;
  final bool withFlag;
  final RoomEntity room;
  final String topNumber;
  final bool isForRank;
  const RoomItemWidget({
    super.key,
    this.isTop = false,
    this.withFlag = false,
    required this.room,
    this.topNumber = '',
    this.isForRank = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (room.lockCode.isNotEmpty) {
          Get.dialog(CheckLockDialog(
            room: room,
            lockCode: room.lockCode,
          ));
          return;
        }
        if (Get.isRegistered<RoomController>()) {
          final roomController = Get.find<RoomController>();
          if (AppRoutes.overlayController.pageStateNotifier.value ==
              XOverlayPageState.overlaying) {
            AppRoutes.overlayController.hide();
            await roomController.closeAndDisposeRoom();
          }
          roomController.initController(
            room.id.toString(),
            data: {
              "roomName": room.roomName,
              "referenceId": room.roomReferenceId,
              "backgroundTheme": room.backgroundTheme,
              "roomImage": room.roomImage,
            },
          );
        }
        Get.toNamed(AppRoutes.roomRoute, arguments: {
          "id": room.id.toString(),
          "data": {
            "roomName": room.roomName,
            "referenceId": room.roomReferenceId,
            "backgroundTheme": room.backgroundTheme,
            "roomImage": room.roomImage,
          },
        });
      },
      child: Container(
        width: 1.w(context),
        padding: isForRank
            ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
            : const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow:
              getBoxShadow(color: ColorManager.lightGreyColor.withOpacity(.25)),
          color: ColorManager.white,
        ),
        child: isForRank
            ? IntrinsicHeight(
                child: Row(
                  children: [
                
                    Text(
                      "$topNumber-",
                      style: Get.textTheme.labelLarge!.copyWith(
                        fontSize: AppSize.s16(context),
                      ),
                    ),
                    5.horizontalSpace(),
                   
                    AppImage(
                      image: room.roomImage,
                      width: 87,
                      height: 72,
                      radius: 10,
                      fit: BoxFit.cover,
                    ),
                    15.horizontalSpace(),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            room.roomName,
                            style: Get.textTheme.titleLarge!.copyWith(
                              fontSize: AppSize.s17(context),
                            ),
                          ),
                          2.verticalSpace(),
                          Text(
                            "ID: ${room.roomReferenceId}",
                            style: Get.textTheme.headlineMedium!.copyWith(
                              fontSize: AppSize.s12(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        const SizedBox.shrink(),
                        const SizedBox.shrink(),
                        Row(
                          children: [
                            Text(
                              num.parse(room.falg).formatCurrencyWithoutSymbol,
                              style: Get.textTheme.labelLarge,
                            ),
                            4.horizontalSpace(),
                            const AppIcon(
                              icon: IconsAssets.coins2,
                              width: 14,
                              height: 14,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Lottie.asset(
                              LottieAssets.pulse,
                              width: 20,
                              height: 20,
                            ),
                            1.horizontalSpace(),
                            Text(
                              room.membersCount.toStringAsFixed(0),
                              style: Get.textTheme.titleSmall!.copyWith(
                                fontSize: AppSize.s14(context),
                              ),
                            ),
                            if (room.lockCode.isNotEmpty)
                              const Icon(
                                Icons.lock_outline,
                                color: ColorManager.iconGreyColor,
                                size: 20,
                              )
                            else
                              9.horizontalSpace(),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            : IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppImage(
                      image: room.roomImage,
                      width: 87,
                      height: 72,
                      radius: 10,
                      fit: BoxFit.cover,
                    ),
                    10.horizontalSpace(),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          if (withFlag) ...[
                            AppImage(
                              image: room.falg,
                              width: 20,
                              height: 20,
                            ),
                            4.horizontalSpace(),
                          ],
                          Flexible(
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  room.roomName,
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    fontSize: AppSize.s18(context),
                                  ),
                                ),
                                2.verticalSpace(),
                                Text(
                                  room.generalNotificationContent,
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                    fontSize: AppSize.s14(context),
                                  ),
                                ),
                                10.verticalSpace(),
                                if (room.tag.id != 0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          ColorManager.primary.withOpacity(.2),
                                    ),
                                    child: Text(
                                      room.tag.name,
                                      style:
                                          Get.textTheme.displaySmall!.copyWith(
                                        fontSize: AppSize.s10(context),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (isTop)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorManager.primary,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                
                                const AppIcon(
                                  icon: IconsAssets.star,
                                  color: ColorManager.yellowColor,
                                  width: 15,
                                  height: 15,
                                ),
                                4.horizontalSpace(),
                                Text(
                                  "Top $topNumber",
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    fontSize: AppSize.s10(context),
                                    fontWeight: FontWeightManger.semiBold,
                                  ),
                                )
                              ],
                            ),
                          )
                        else
                          const SizedBox(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              LottieAssets.pulse,
                              width: 20,
                              height: 20,
                            ),
                            1.horizontalSpace(),
                            Text(
                              room.membersCount.toString(),
                              style: Get.textTheme.titleSmall!.copyWith(
                                fontSize: AppSize.s14(context),
                              ),
                            ),
                            if (room.lockCode.isNotEmpty)
                              const Icon(
                                Icons.lock_outline,
                                color: ColorManager.iconGreyColor,
                                size: 20,
                              )
                            else
                              9.horizontalSpace(),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
