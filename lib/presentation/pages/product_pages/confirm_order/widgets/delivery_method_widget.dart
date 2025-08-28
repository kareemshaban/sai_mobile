import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/store/widgets/store_location_widget.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/getx/confirm_order_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class DeliveryMethodWidget extends GetView<ConfirmOrderController> {
  const DeliveryMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.deliveryMethod,
            style: Get.textTheme.titleMedium!.copyWith(
              fontSize: AppSize.s15(context),
            ),
          ),
          18.verticalSpace(),
          InkWell(
            onTap: () => controller.onChangeDeliveryValue("from_market"),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                  height: 15,
                  child: Radio(
                    value: "from_market",
                    groupValue: controller.deliveryValue,
                    onChanged: controller.onChangeDeliveryValue,
                  ),
                ),
                16.horizontalSpace(),
                Text(
                  AppStrings.pickUpFromStore,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s14(context),
                  ),
                ),
              ],
            ),
          ),
          15.verticalSpace(),
          InkWell(
            onTap: () => controller.onChangeDeliveryValue("to_address"),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                  height: 15,
                  child: Radio(
                    value: "to_address",
                    groupValue: controller.deliveryValue,
                    onChanged: controller.onChangeDeliveryValue,
                  ),
                ),
                16.horizontalSpace(),
                Text(
                  AppStrings.paidDelivery,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s14(context),
                  ),
                ),
              ],
            ),
          ),
          if (controller.deliveryValue == "to_address") ...[
            15.verticalSpace(),
            const StoreLocationWidget(),
          ],
          20.verticalSpace(),
        ],
      ),
    );
  }
}
