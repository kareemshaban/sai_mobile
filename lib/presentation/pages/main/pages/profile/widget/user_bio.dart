import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class UserBio extends GetView<ProfileController> {
  const UserBio({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Text(
          controller.appController.user.profileDescription,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: Get.textTheme.titleSmall!.copyWith(
            height: 1.4,
            fontSize: AppSize.s15(context),
          ),
        ),
      ),
    );
  }
}
