import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/getx/vip_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

import 'vip_exclusive_privilege_list.dart';

class VipSubscriptionDetailsWidget extends GetView<VipController> {
  const VipSubscriptionDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          10.verticalSpace(),
          AppImage(
            image: controller.premium.data[controller.currentIndex].badge,
            width: 260,
            height: 260,
            radius: 10,
          ),
          10.verticalSpace(),
          Container(
            width: 1.w(context),
            color: ColorManager.primary,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.exclusivePrivileges,
                  style: Get.textTheme.bodyLarge!.copyWith(
                    fontSize: AppSize.s16(context),
                  ),
                ),
                Text(
                  "16/${controller.premium.data[controller.currentIndex].count}",
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSize.s14(context),
                  ),
                ),
              ],
            ),
          ),
          18.verticalSpace(),
          const VipExclusivePrivilegeList(),
        ],
      ),
    );
  }
}
