import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/dynamic_link_handler.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/share_bottom_sheet.dart';

class UserButtons extends StatelessWidget {
  const UserButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          title: AppStrings.editProfile,
          radius: 10,
          textStyle: Get.textTheme.titleSmall!.copyWith(
            fontSize: AppSize.s11(context),
          ),
          onTap: () => Get.toNamed(AppRoutes.editProfileRoute),
          backgroundColor: ColorManager.lightGreyColor,
        ),
        12.horizontalSpace(),
        AppButton(
          title: AppStrings.shareProfile,
          radius: 10,
          textStyle: Get.textTheme.titleSmall!.copyWith(
            fontSize: AppSize.s11(context),
          ),
          backgroundColor: ColorManager.lightGreyColor,
          onTap: () {
            final link =
                "Checkout this profile in SAI app ${DynamicLinkHandler.createProfileLink(id: Get.find<AppController>().user.id)}";
            Get.bottomSheet(ShareBottomSheet(shareLink: link));
          },
        ),
      ],
    );
  }
}
