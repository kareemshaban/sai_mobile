import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/widget/user_numbers_bottom_sheet.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class UserNumbersWidget extends GetView<ProfileController> {
  const UserNumbersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            controller.getUserVisitor();
            Get.bottomSheet(
              UserNumbersBottomSheet(
                title: AppStrings.visitor,
                isVisitor: true,
                number: controller.appController.user.visitorsCount,
                scrollController: controller.userVisitorsController,
              ),
              isScrollControlled: true,
            );
          },
          child: Column(
            children: [
              Text(
                controller.appController.user.visitorsCount,
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
        ),
        InkWell(
          onTap: () {
            controller.getUserFriend();
            Get.bottomSheet(
              UserNumbersBottomSheet(
                title: AppStrings.follow2,
                number: controller.appController.user.followings.toString(),
                scrollController: controller.userFrindsController,
              ),
              isScrollControlled: true,
            );
          },
          child: Column(
            children: [
              Text(
                controller.appController.user.followings.toString(),
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s18(context),
                ),
              ),
              Text(
                AppStrings.follow2,
                style: Get.textTheme.headlineMedium!.copyWith(
                  fontSize: AppSize.s12(context),
                  color: ColorManager.textGrey4,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            controller.getUserFollwers();
            Get.bottomSheet(
              UserNumbersBottomSheet(
                title: AppStrings.followers,
                number: controller.appController.user.followers.toString(),
                scrollController: controller.userFollowController,
              ),
              isScrollControlled: true,
            );
          },
          child: Column(
            children: [
              Text(
                controller.appController.user.followers.toString(),
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s18(context),
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
        ),
        Column(
          children: [
            Text(
              controller.appController.user.postsCount.toString(),
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
