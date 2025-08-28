import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
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
          bool isHaveProfileCard = privilege.profileCard.file.isNotEmpty;
          bool isVIPActive = !Get.find<AppController>().vipActive;
          return Container(
            width: 1.w(context),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: controller.appController.isVipActive()
                  ? privilege.profileCard.file.isEmpty
                      ? null
                      : DecorationImage(
                          image: CachedNetworkImageProvider(
                            privilege.profileCard.file,
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
                    20.verticalSpace(),
                    Text(
                      controller.userProfile.name,
                      style: Get.textTheme.labelMedium!.copyWith(
                        fontSize: AppSize.s20(context),
                        color: controller.appController.isVipActive()
                            ? privilege.colorfulName.value.isEmpty
                                ? null
                                : Colors.white.fromHex(
                                    privilege.colorfulName.value,
                                  )
                            : null,
                      ),
                    ),
                    Text(
                      'ID : ${controller.userProfile.referenceId}',
                      style: Get.textTheme.labelMedium!.copyWith(
                        fontSize: AppSize.s18(context),
                        color: isVIPActive
                            ? ColorManager.black.withOpacity(.5)
                            : isHaveProfileCard
                                ? ColorManager.white
                                : ColorManager.black.withOpacity(.5),
                      ),
                    ),
                    15.verticalSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isVIPActive
                                ? ColorManager.black.withOpacity(.05)
                                : isHaveProfileCard
                                    ? ColorManager.white.withOpacity(.5)
                                    : ColorManager.black.withOpacity(.05),
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
                            color: isVIPActive
                                ? ColorManager.black.withOpacity(.05)
                                : isHaveProfileCard
                                    ? ColorManager.white.withOpacity(.5)
                                    : ColorManager.black.withOpacity(.05),
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
                    26.verticalSpace(),
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
                                width: 27,
                                height: 27,
                                decoration: const BoxDecoration(
                                  color: ColorManager.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  controller.userProfile.isFollowing
                                      ? Icons.person_remove
                                      : Icons.add,
                                  color: ColorManager.white,
                                ),
                              ),
                              11.verticalSpace(),
                              Text(
                                controller.userProfile.isFollowing
                                    ? AppStrings.unFollow
                                    : AppStrings.follow,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s20(context),
                                  color: isVIPActive
                                      ? null
                                      : isHaveProfileCard
                                          ? ColorManager.white
                                          : null,
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
                                width: 27,
                                height: 27,
                                color: ColorManager.primary,
                              ),
                              11.verticalSpace(),
                              Text(
                                AppStrings.gift,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s20(context),
                                  color: isVIPActive
                                      ? null
                                      : isHaveProfileCard
                                          ? ColorManager.white
                                          : null,
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
                                      size: 35,
                                      color: ColorManager.primary,
                                    )
                                  : const Icon(
                                      Icons.mic,
                                      size: 35,
                                      color: ColorManager.primary,
                                    ),
                              5.verticalSpace(),
                              Text(
                                isMutedLocally
                                    ? AppStrings.unMute
                                    : AppStrings.mute,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s20(context),
                                  color: isVIPActive
                                      ? null
                                      : isHaveProfileCard
                                          ? ColorManager.white
                                          : null,
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
                                width: 27,
                                height: 27,
                                color: ColorManager.primary,
                              ),
                              11.verticalSpace(),
                              Text(
                                AppStrings.show,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s20(context),
                                  color: isVIPActive
                                      ? null
                                      : isHaveProfileCard
                                          ? ColorManager.white
                                          : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (controller.isAdmin() &&
                        controller.userProfile.role != 'owner') ...[
                      10.verticalSpace(),
                      const Divider(height: 0),
                      10.verticalSpace(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                              Get.dialog(const InviteMemperDialog());
                            },
                            child: const Icon(
                              Icons.person,
                              color: ColorManager.primary,
                              size: 25,
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
                              size: 25,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                              Get.dialog(const FireUserDialog());
                            },
                            child: const Icon(
                              Icons.exit_to_app,
                              color: ColorManager.primary,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                PositionedDirectional(
                  top: -250,
                  width: 1.w(context),
                  child: PrivilegeDataView(
                    url: controller
                        .userProfile.privileges.data.profileBorder.file,
                    width: 1.w(context),
                  ),
                ),
                PositionedDirectional(
                  top: controller.appController.isVipActive()
                      ? privilege.profileFrame.file.isNotEmpty
                          ? -120
                          : -70
                      : -80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppImage(
                        image: controller.userProfile.profileImg,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        isCircle: true,
                        errorWidget: controller.userErrorImageWidget(),
                      ),
                      PrivilegeDataView(
                        url: controller
                            .userProfile.privileges.data.profileFrame.file,
                        width: 140,
                        height: 140,
                      ),
                      PrivilegeDataView(
                        url: controller
                            .userProfile.privileges.data.luxuryVehicles.file,
                        width: 140,
                        height: 140,
                      ),
                    ],
                  ),
                ),
                PositionedDirectional(
                  top: 0,
                  start: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: controller.userProfile.role == "owner"
                          ? const Color(0x99FF4646)
                          : controller.userProfile.role == "admin"
                              ? ColorManager.green
                              : const Color(0x997B34FF),
                    ),
                    child: Text(
                      controller.getCurrentRole(controller.userProfile.role),
                      style: Get.textTheme.bodySmall!.copyWith(
                        fontSize: AppSize.s10(context),
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 0,
                  end: 0,
                  child: PrivilegeDataView(
                    url: controller
                        .userProfile.privileges.data.badgePremium.file,
                    width: 60,
                    height: 60,
                  ),
                ),
                PositionedDirectional(
                  top: 20,
                  start: -10,
                  child: PrivilegeDataView(
                    url: controller
                        .userProfile.privileges.data.exclusiveNameCard.file,
                    width: 100,
                    height: 40,
                  ),
                ),
                PositionedDirectional(
                  top: 50,
                  end: 0,
                  child: Column(
                    children: controller.userProfile.badges
                        .map((e) => PrivilegeDataView(
                              url: e,
                              width: 60,
                              height: 60,
                            ))
                        .toList(),
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
