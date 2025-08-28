import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/enums.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/model/cart_local_model.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/widgets/confirm_order_product_widget.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/getx/order_details_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/widgets/delivery_info_widget.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/widgets/order_details_bill_widget.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/widgets/order_info_widget.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: controller.loadingOrder
              ? const SizedBox()
              : Text("#${controller.order.id}"),
        ),
        body: controller.loadingOrder
            ? const Center(child: AppLoader())
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OrderInfoWidget(),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          ConfirmOrderProductWidget(
                        model: CartLocalModel(
                          id: controller.order.products[index].id,
                          quantity:
                              controller.order.products[index].quantity.toInt(),
                          image: controller.order.products[index].image,
                          maxQuantity: 0,
                          minQuantity: 0,
                          price: controller.order.products[index].price,
                          title: controller.order.products[index].name,
                          quantityOptionId: 0,
                          optionalOption: [],
                        ),
                      ),
                      itemCount: controller.order.products.length,
                    ),
                    const DeliveryInfoWidget(),
                    const OrderDetailsBillWidget(),
                    if (controller.order.statue.toOrderState() ==
                        OrderState.newOrder)
                      Center(
                        child: InkWell(
                          onTap: controller.cancelOrder,
                          child: Text(
                            AppStrings.cancel,
                            style: Get.textTheme.titleLarge!.copyWith(
                              color: ColorManager.appRedColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
