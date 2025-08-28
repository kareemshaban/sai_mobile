import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class UserCoverAndInfoWidget extends GetView<ProfileController> {
  const UserCoverAndInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: 1.w(context),
        height: 295 + 12,
        child: Stack(
          children: [
            Opacity(
              opacity: .5,
              child: Container(
                width: 1.w(context),
                height: 280,
                decoration: BoxDecoration(
                  gradient: ColorManager.coverImageColor,
                ),
                child: AppImage(
                  image: controller.appController.user.profileCover,
                  fit: BoxFit.cover,
                  errorWidget: const SizedBox.shrink(),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      const AppIcon(
                                        icon: IconsAssets.jeweled,
                                        width: 22,
                                        height: 22,
                                      ),
                                      11.horizontalSpace(),
                                      Text(
                                        AppStrings.store,
                                        style:
                                            Get.textTheme.titleMedium!.copyWith(
                                          fontSize: AppSize.s22(context),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: ColorManager.iconGreyColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () => Get.toNamed(
                                      AppRoutes.settingsMarketRoute),
                                ),
                                if (controller.appController
                                    .isGoldReddemeActive()) ...[
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        const AppIcon(
                                          icon: IconsAssets.wallet,
                                          width: 22,
                                          height: 22,
                                        ),
                                        11.horizontalSpace(),
                                        Text(
                                          AppStrings.wallet,
                                          style: Get.textTheme.titleMedium!
                                              .copyWith(
                                            fontSize: AppSize.s22(context),
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: ColorManager.iconGreyColor,
                                        ),
                                      ],
                                    ),
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.walletRoute),
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        const AppIcon(
                                          icon: IconsAssets.withdraw,
                                          width: 22,
                                          height: 22,
                                        ),
                                        11.horizontalSpace(),
                                        Text(
                                          AppStrings.withdraw,
                                          style: Get.textTheme.titleMedium!
                                              .copyWith(
                                            fontSize: AppSize.s22(context),
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: ColorManager.iconGreyColor,
                                        ),
                                      ],
                                    ),
                                    onTap: () => Get.toNamed(
                                        AppRoutes.cashWithdrawalRoute),
                                  ),
                                ],
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      const AppIcon(
                                        icon: IconsAssets.setting,
                                        width: 22,
                                        height: 22,
                                      ),
                                      11.horizontalSpace(),
                                      Text(
                                        AppStrings.settingsAndPrivacy,
                                        style:
                                            Get.textTheme.titleMedium!.copyWith(
                                          fontSize: AppSize.s22(context),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: ColorManager.iconGreyColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () => Get.toNamed(
                                      AppRoutes.settingsAndPrivacyRoute),
                                ),
                              ];
                            },
                            position: PopupMenuPosition.under,
                            child: const AppIcon(
                              icon: IconsAssets.menu,
                              color: ColorManager.white,
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: InkWell(
                              onTap: () =>
                                  Get.toNamed(AppRoutes.notificationsRoute),
                              child: Badge.count(
                                count: controller.notificationCount,
                                backgroundColor: ColorManager.red,
                                isLabelVisible:
                                    controller.notificationCount != 0,
                                largeSize: 20,
                                textColor: ColorManager.white,
                                alignment: AlignmentDirectional.topEnd,
                                textStyle: Get.textTheme.bodySmall!.copyWith(
                                  fontSize: AppSize.s14(context),
                                ),
                                child: const Icon(
                                  Icons.notifications,
                                  color: ColorManager.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
               
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
Obx(() => Container(
  width: 100,
  height: 100,
  decoration: const BoxDecoration(
    shape: BoxShape.circle,
  ),
  child: GestureDetector(
    onTap: () {
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(200),
      child: 
            AppImage(
            withCache: false,
            image:  controller.appController.user.profileImg,
            width: 100,
            height: 100,
            isCircle: true,
          fit: BoxFit.cover,
      ),
    ),
  ),
)),

                        PrivilegeDataView(
                          url: controller.appController.user.privileges.data
                              .profileFrame.file,
                          width: 120,
                          height: 120,
                        ),
                      ],
                    ),
                    1.verticalSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppIcon(
                          icon: IconsAssets.verified,
                        ),
                        5.verticalSpace(),
                        Text(
                          controller.appController.user.name,
                          style: Get.textTheme.titleLarge!.copyWith(
                            fontSize: AppSize.s24(context),
                            color: controller.appController.isVipActive()
                                ? controller.appController.user.privileges.data
                                        .colorfulName.value.isNotEmpty
                                    ? Colors.white.fromHex(controller
                                        .appController
                                        .user
                                        .privileges
                                        .data
                                        .colorfulName
                                        .value)
                                    : null
                                : null,
                          ),
                        ),
                      ],
                    ),
                    5.verticalSpace(),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                                text: controller.appController.user.referenceId
                                    .toString()))
                            .then((_) {
                          showSnackBarWidget(
                            message: AppStrings.copied,
                            color: ColorManager.green,
                          );
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ID : ${controller.appController.user.referenceId}",
                            style: Get.textTheme.headlineMedium!.copyWith(
                              fontSize: AppSize.s20(context),
                              color: ColorManager.textGrey3,
                            ),
                          ),
                          5.horizontalSpace(),
                          const Icon(
                            Icons.copy,
                            color: ColorManager.textGrey3,
                            size: 20,
                          ),
                          if (controller
                              .appController.user.badges.isNotEmpty) ...[
                            2.horizontalSpace(),
                            PrivilegeDataView(
                              url: controller.appController.user.badges.first,
                              isBadges: true,
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ],
                      ),
                    ),
                    5.verticalSpace(),
                    Text(
                      controller.appController.user.country.name,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s14(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              end: 10,
              child: PrivilegeDataView(
                url: controller
                    .appController.user.privileges.data.badgePremium.file,
                width: 50,
                height: 50,
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              start: 10,
              child: PrivilegeDataView(
                url: controller
                    .appController.user.privileges.data.exclusiveNameCard.file,
                width: 100,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
