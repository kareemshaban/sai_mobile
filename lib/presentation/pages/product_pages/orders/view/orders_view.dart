import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/orders/getx/orders_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/orders/widget/order_widget.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loading/order_loading_item.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.orders),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            AppFormFiled(
              prefixIcon: const Icon(
                Icons.search,
                color: ColorManager.iconGreyColor2,
              ),
              hint: AppStrings.search,
            ),
            16.verticalSpace(),
            Expanded(
              child: Obx(
                () => RefreshIndicator(
                  onRefresh: () => controller.getOrders(),
                  child: CustomScrollView(
                    slivers: [
                      if (controller.loading)
                        SliverList.separated(
                          itemBuilder: (context, index) =>
                              const OrderLoadingItem(),
                          separatorBuilder: (context, index) =>
                              10.verticalSpace(),
                          itemCount: 3,
                        )
                      else ...[
                        if (controller.currentOrders.isEmpty &&
                            controller.previosOrders.isEmpty)
                          const SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: EmptyDataWidget(),
                            ),
                          ),
                        if (controller.currentOrders.isNotEmpty) ...[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.inProgress,
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    fontSize: AppSize.s20(context),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      " (${controller.currentOrders.length} ${AppStrings.order})",
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                    fontSize: AppSize.s20(context),
                                  ),
                                ),
                              ],
                            ),
                          ).toSliver(),
                          11.verticalSpace().toSliver(),
                          SliverList.separated(
                            itemBuilder: (context, index) => OrderWidget(
                                order: controller.currentOrders[index]),
                            separatorBuilder: (context, index) =>
                                10.verticalSpace(),
                            itemCount: controller.currentOrders.length,
                          ),
                          17.verticalSpace().toSliver(),
                        ],
                        if (controller.previosOrders.isNotEmpty) ...[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.finished,
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    fontSize: AppSize.s20(context),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      " (${controller.previosOrders.length} ${AppStrings.order})",
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                    fontSize: AppSize.s20(context),
                                  ),
                                ),
                              ],
                            ),
                          ).toSliver(),
                          SliverList.separated(
                            itemBuilder: (context, index) => OrderWidget(
                                order: controller.previosOrders[index]),
                            separatorBuilder: (context, index) =>
                                10.verticalSpace(),
                            itemCount: controller.previosOrders.length,
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
