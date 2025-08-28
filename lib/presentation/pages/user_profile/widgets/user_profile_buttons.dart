import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';
import 'package:new_sai/presentation/pages/user_profile/getx/user_profile_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class UserProfileButtons extends GetView<UserProfileController> {
  const UserProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppButton(
            height: 30,
            title: controller.user.isFollowing
                ? AppStrings.unFollow
                : controller.user.isFollow
                    ? AppStrings.followBack
                    : AppStrings.follow,
            radius: 10,
            textStyle: Get.textTheme.bodySmall!.copyWith(
              fontSize: AppSize.s16(context),
            ),
            onTap: controller.user.isFollowing
                ? controller.cancelFrindRequest
                : controller.sendFriendRequest,
          ),
          if (controller.user.comment == "all" ||
              (controller.user.comment == "private" &&
                  controller.user.isFriend))
            if ((controller.user.isFollowing || controller.user.isFriend) &&
                !controller.isFromChat) ...[
              12.horizontalSpace(),
              AppButton(
                height: 30,
                title: AppStrings.chat1,
                radius: 10,
                textStyle: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s16(context),
                ),
                backgroundColor: ColorManager.lightGreyColor,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.chatRoute,
                    arguments: {
                      "id": controller.user.chatId,
                      "recID": controller.user.id,
                      "user": ChatUserInfoEntity(
                        id: controller.user.id,
                        referenceId: 0,
                        name: controller.user.name,
                        logo: controller.user.profileImg,
                      ),
                    },
                  );
                },
              ),
            ],
        ],
      ),
    );
  }
}
