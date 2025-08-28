import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/getx/vip_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class ExpiredSubscriptionWidget extends GetView<VipController> {
  const ExpiredSubscriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      color: ColorManager.primary,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image.network(
              controller.appController.user.profileImg,
              width: 35,
              height: 35,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const AppImage(
                  image: Constants.userErrorWidget,
                  fit: BoxFit.cover,
                  width: 35,
                  height: 25,
                );
              },
            ),
          ),
          15.horizontalSpace(),
          Text(
            AppStrings.yourSubscriptionHasExpired(controller.premium.data
                .firstWhere(
                    (element) => element.id == controller.premium.categoryId)
                .name),
            style: Get.textTheme.bodySmall!.copyWith(
              fontSize: AppSize.s14(context),
            ),
          ),
        ],
      ),
    );
  }
}
