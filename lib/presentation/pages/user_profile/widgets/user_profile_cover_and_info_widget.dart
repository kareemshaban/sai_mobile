import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/user_profile/getx/user_profile_controller.dart';
import 'package:new_sai/presentation/pages/user_profile/widgets/user_profile_buttons.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class UserProfileCoverAndInfoWidget extends GetView<UserProfileController> {
  const UserProfileCoverAndInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: 1.w(context),
        // height: 285,
        child: Stack(
          children: [
            Opacity(
              opacity: .5,
              child: Container(
                width: 1.w(context),
                height: 320 + 12,
                decoration: BoxDecoration(
                  gradient: ColorManager.coverImageColor,
                ),
                child: AppImage(
                  image: controller.user.profileCover,
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
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: AppBackButton(
                            color: ColorManager.white,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.network(
                              controller.user.profileImg,
                              errorBuilder: (context, error, stackTrace) {
                                return const AppImage(
                                  image: Constants.userErrorWidget,
                                  width: 100,
                                  height: 100,
                                  isCircle: true,
                                );
                              },
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        PrivilegeDataView(
                          url:
                              controller.user.privileges.data.profileFrame.file,
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
                          controller.user.name,
                          style: Get.textTheme.titleLarge!.copyWith(
                            fontSize: AppSize.s24(context),
                            color: controller.appController.isVipActive()
                                ? controller.user.privileges.data.colorfulName
                                        .value.isNotEmpty
                                    ? Colors.white.fromHex(controller.user
                                        .privileges.data.colorfulName.value)
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
                                text: controller.user.referenceId.toString()))
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
                            "ID : ${controller.user.referenceId}",
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
                          if (controller.user.badges.isNotEmpty) ...[
                            2.horizontalSpace(),
                            PrivilegeDataView(
                              url: controller.user.badges.first,
                              isBadges: true,
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ],
                      ),
                    ),
                    10.verticalSpace(),
                    Text(
                      controller.user.country.name,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s14(context),
                      ),
                    ),
                    14.verticalSpace(),
                    const UserProfileButtons(),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              end: 10,
              child: PrivilegeDataView(
                url: controller.user.privileges.data.badgePremium.file,
                width: 50,
                height: 50,
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              start: 10,
              child: PrivilegeDataView(
                url: controller.user.privileges.data.exclusiveNameCard.file,
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
