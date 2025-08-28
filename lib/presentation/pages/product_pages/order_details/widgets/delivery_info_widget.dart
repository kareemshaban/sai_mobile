import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/getx/order_details_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class DeliveryInfoWidget extends GetView<OrderDetailsController> {
  const DeliveryInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        25.verticalSpace(),
        const Divider(
          height: 0,
          color: ColorManager.lightGreyColor,
        ),
        25.verticalSpace(),
        Text(
          AppStrings.deliveryInfo,
          style: Get.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.s17(context),
          ),
        ),
        20.verticalSpace(),
        Row(
          children: [
            const AppIcon(
              icon: IconsAssets.deliveryIcon,
              width: 24,
              height: 24,
            ),
            16.horizontalSpace(),
            Text(
              controller.order.deliveryTypeTranslate,
              style: Get.textTheme.titleMedium!.copyWith(
                fontSize: AppSize.s16(context),
              ),
            ),
          ],
        ),
        20.verticalSpace(),
        Row(
          children: [
            const AppIcon(
              icon: IconsAssets.deliveryIcon,
              width: 24,
              height: 24,
            ),
            16.horizontalSpace(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.order.address.country.name}, ${controller.order.address.fullName}",
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s16(context),
                  ),
                ),
                Text(
                  controller.order.address.street,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s14(context),
                    color: ColorManager.dividerColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        25.verticalSpace(),
        const Divider(
          height: 0,
          color: ColorManager.lightGreyColor,
        ),
        25.verticalSpace(),
      ],
    );
  }
}
