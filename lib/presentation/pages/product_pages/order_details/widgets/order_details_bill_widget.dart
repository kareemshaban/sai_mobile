import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/widgets/bill_widget.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/getx/order_details_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class OrderDetailsBillWidget extends GetView<OrderDetailsController> {
  const OrderDetailsBillWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.bill,
          style: Get.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.s17(context),
          ),
        ),
        20.verticalSpace(),
        BillWidget(
          total: controller.order.partCost.formatCurrency(context),
          discount: controller.order.discountPercent.toString(),
          finalTotal: controller.order.totalCost.formatCurrency(context),
          deliveryValue: controller.order.deliveryCost != 0
              ? controller.order.deliveryCost.formatCurrency(context)
              : null,
        ),
      ],
    );
  }
}
