import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/user_profile/getx/user_profile_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class UserProfileNumbersWidget extends GetView<UserProfileController> {
  const UserProfileNumbersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              controller.user.visitorsCount,
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s18(context),
              ),
            ),
            Text(
              AppStrings.visitor,
              style: Get.textTheme.headlineMedium!.copyWith(
                fontSize: AppSize.s12(context),
                color: ColorManager.textGrey4,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              controller.user.followings.toString(),
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s18(context),
              ),
            ),
            Text(
              AppStrings.follow,
              style: Get.textTheme.headlineMedium!.copyWith(
                fontSize: AppSize.s12(context),
                color: ColorManager.textGrey4,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Obx(
              () => Text(
                controller.user.followers.toString(),
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s18(context),
                ),
              ),
            ),
            Text(
              AppStrings.followers,
              style: Get.textTheme.headlineMedium!.copyWith(
                fontSize: AppSize.s12(context),
                color: ColorManager.textGrey4,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              controller.user.postsCount.toString(),
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s18(context),
              ),
            ),
            Text(
              AppStrings.posts,
              style: Get.textTheme.headlineMedium!.copyWith(
                fontSize: AppSize.s12(context),
                color: ColorManager.textGrey4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
