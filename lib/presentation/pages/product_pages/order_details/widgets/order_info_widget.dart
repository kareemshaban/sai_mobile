import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/getx/order_details_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class OrderInfoWidget extends GetView<OrderDetailsController> {
  const OrderInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${AppStrings.timeAndDateOfOrder}: ",
                style: Get.textTheme.titleMedium!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
              TextSpan(
                text: controller.order.orderDatetime,
                style: Get.textTheme.titleMedium!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
            ],
          ),
        ),
        8.verticalSpace(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${AppStrings.orderStatus}: ",
                style: Get.textTheme.titleMedium!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
              TextSpan(
                text: controller.order.statueTranslate,
                style: Get.textTheme.titleMedium!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
            ],
          ),
        ),
        25.verticalSpace(),
      ],
    );
  }
}
