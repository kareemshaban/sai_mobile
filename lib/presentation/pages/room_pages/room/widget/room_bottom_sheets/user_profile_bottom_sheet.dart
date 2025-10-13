import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/cancel_membership_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/fire_user_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/invite_memper_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/mute_user_to_all_dialog.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class UserProfileBottomSheet extends GetView<RoomController> {
  const UserProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        if (controller.loadingGetProfile) {
          return const Center(child: AppLoader());
        } else {
          bool isMutedLocally = controller.mutedListLocally.any(
                  (element) => element == controller.userProfile.id.toString());
          bool isMuted = controller.mutedList.any(
                  (element) => element == controller.userProfile.id.toString());
          final privilege = controller.userProfile.privileges.data;
          final user = controller.apiUsers.firstWhereOrNull(
                (e) => e.id.toString().trim() == controller.appController.user.id.toString().trim(),
          );
          return Container(
            width: 1.w(context),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: controller.userProfile.isVip == 1
                  ? DecorationImage(
                image: CachedNetworkImageProvider(
                  privilege.roomBackcground.file,
                  scale: 2,
                ),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    50.verticalSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.userProfile.isVip == 1)
                          PrivilegeDataView(
                            url: controller
                                .userProfile.privileges.data.badgePremium.file,
                            width: 30,
                            height: 30,
                          ),
                        Text(
                          controller.userProfile.name,
                          style: Get.textTheme.labelMedium!.copyWith(
                            fontSize: AppSize.s20(context),
                            fontWeight: FontWeight.bold,
                            color: controller.userProfile.isVip == 1
                                ? privilege.colorfulName.value.toColor()
                                : null,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.userProfile.badges.isNotEmpty)...[
                          Row(
                            children: controller.userProfile.badges
                                .map((e) => PrivilegeDataView(
                              url: e,
                              width: 40,
                              height: 40,
                            )
                            ).toList(),
                          ),
                          5.horizontalSpace()
                        ],
                        Text(
                          'ID : ${controller.userProfile.referenceId}',
                          style: Get.textTheme.labelMedium!.copyWith(
                            fontSize: AppSize.s16(context),
                            fontWeight: FontWeight.bold,
                            color: controller.userProfile.isVip == 1
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: controller.userProfile.isVip == 1
                                ? ColorManager.black.withOpacity(.3)
                                : ColorManager.black.withOpacity(.03),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF3E03FF).withOpacity(.05),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${AppStrings.send2} ${controller.userProfile.supportSentVal}',
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s13(context),
                                  color: controller.userProfile.isVip == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              7.horizontalSpace(),
                              const AppIcon(
                                icon: IconsAssets.coins,
                                width: 18,
                                height: 18,
                              ),
                            ],
                          ),
                        ),
                        16.horizontalSpace(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: controller.userProfile.isVip == 1
                                ? ColorManager.black.withOpacity(.3)
                                : ColorManager.black.withOpacity(.03),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF3E03FF).withOpacity(.05),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${AppStrings.receive} ${controller.userProfile.supportReceivedVal}',
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s13(context),
                                  color: controller.userProfile.isVip == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              7.horizontalSpace(),
                              const AppIcon(
                                icon: IconsAssets.coins,
                                width: 18,
                                height: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: controller.userProfile.isFollowing
                              ? controller.cancelFrindRequest
                              : controller.sendFriendRequest,
                          child: Column(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: ColorManager.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  controller.userProfile.isFollowing
                                      ? Icons.person_remove
                                      : Icons.add,
                                  color: ColorManager.white,
                                  size: 17,
                                ),
                              ),
                              11.verticalSpace(),
                              Text(
                                controller.userProfile.isFollowing
                                    ? AppStrings.unFollow
                                    : AppStrings.follow,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s14(context),
                                  color: controller.userProfile.isVip == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: controller.sendGiftToUser,
                          child: Column(
                            children: [
                              const AppIcon(
                                icon: IconsAssets.gift2,
                                width: 20,
                                height: 20,
                                color: ColorManager.primary,
                              ),
                              11.verticalSpace(),
                              Text(
                                AppStrings.gift,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s15(context),
                                  color: controller.userProfile.isVip == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: controller.muteUnMuteUserLocaly,
                          child: Column(
                            children: [
                              isMutedLocally
                                  ? const Icon(
                                Icons.mic_off,
                                size: 28,
                                color: ColorManager.primary,
                              )
                                  : const Icon(
                                Icons.mic,
                                size: 28,
                                color: ColorManager.primary,
                              ),
                              5.verticalSpace(),
                              Text(
                                isMutedLocally
                                    ? AppStrings.unMute
                                    : AppStrings.mute,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s15(context),
                                  color: controller.userProfile.isVip == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: controller.goToUserProfile,
                          child: Column(
                            children: [
                              const AppIcon(
                                icon: IconsAssets.user,
                                width: 20,
                                height: 20,
                                color: ColorManager.primary,
                              ),
                              11.verticalSpace(),
                              Text(
                                AppStrings.show,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s15(context),
                                  color: controller.userProfile.isVip == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (controller.userProfile.role != 'owner') ...[
                      if(user?.role == 'owner' || user?.role == 'admin')...[
                        10.verticalSpace(),
                        const Divider(height: 0),
                        10.verticalSpace(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if(user?.role == 'owner')
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.dialog(CancelMembershipDialog(controller.userProfile.id.toString()));
                              },
                              child: const Icon(
                                Icons.person_remove,
                                color: ColorManager.primary,
                                size: 22,
                              ),
                            ),
                            if(user?.role == 'owner')
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.dialog(const InviteMemperDialog());
                              },
                              child: const Icon(
                                Icons.person,
                                color: ColorManager.primary,
                                size: 22,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.dialog(const MuteUserToAllDialog());
                              },
                              child: Icon(
                                isMuted
                                    ? Icons.mic_external_off_rounded
                                    : Icons.mic_external_on,
                                color: ColorManager.primary,
                                size: 22,
                              ),
                            ),
                            if(user?.role == 'owner')
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.dialog(const FireUserDialog());
                              },
                              child: const Icon(
                                Icons.exit_to_app,
                                color: ColorManager.primary,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  ],
                ),
                if (controller.userProfile.isVip == 1)
                  PositionedDirectional(
                    top: -128,
                    width: 1.w(context),
                    child: PrivilegeDataView(
                      url: privilege.profileBorder.file,
                      width: 1.w(context),
                    ),
                  ),
                if (controller.userProfile.isVip == 1)
                  PositionedDirectional(
                    top: 15,
                    end: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0 , vertical: 2.0),
                      decoration: BoxDecoration(
                          color: controller.userProfile.privileges.data.colorfulName.value.toColor(),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Row(
                        children: [
                          Text(controller.userProfile.privileges.categoryName , style: Get.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSize.s15(context),
                          )),
                          5.horizontalSpace(),
                          AppImage(image: controller.userProfile.privileges.categoryIcon , height: 20, width: 20,),
                        ],
                      ),
                    ),
                  ),
                PositionedDirectional(
                  top: controller.userProfile.isVip == 1 ? -80 : -60,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppImage(
                        image: controller.userProfile.profileImg,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        isCircle: true,
                        errorWidget: controller.userErrorImageWidget(),
                      ),
                      if (controller.userProfile.isVip == 1)
                        PrivilegeDataView(
                          url: controller
                              .userProfile.privileges.data.profileFrame.file,
                          width: 120,
                          height: 120,
                        ),
                      // if (controller.userProfile.isVip == 1)
                      //   PrivilegeDataView(
                      //     url: controller
                      //         .userProfile.privileges.data.luxuryVehicles.file,
                      //     width: 140,
                      //     height: 140,
                      //   ),
                    ],
                  ),
                ),
                PositionedDirectional(
                  top: 15,
                  start: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: controller.userProfile.role == "owner"
                          ? const Color(0x99E71616)
                          : controller.userProfile.role == "admin"
                          ? ColorManager.green
                          : const Color(0x997B34FF),
                    ),
                    child: Text(
                      controller.getCurrentRole(controller.userProfile.role),
                      style: Get.textTheme.bodySmall!.copyWith(
                        fontSize: AppSize.s14(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}