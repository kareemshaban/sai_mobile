import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/user_profile/getx/user_profile_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class UserProfileBio extends GetView<UserProfileController> {
  const UserProfileBio({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        controller.user.profileDescription,
        textAlign: TextAlign.center,
        style: Get.textTheme.titleSmall!.copyWith(
          height: 2,
          fontSize: AppSize.s15(context),
        ),
      ),
    );
  }
}
