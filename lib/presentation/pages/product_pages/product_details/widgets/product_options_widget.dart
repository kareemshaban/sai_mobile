import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/widgets/product_option_dropdown.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'product_option_checkbox.dart';

class ProductOptionsWidget extends GetView<ProductDetailsController> {
  const ProductOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
        tag: Get.arguments.toString(),
        builder: (controller) {
          return Obx(
            () => Column(
              children: [
                if (controller.loadingGetProduct) ...[
                  ...List.generate(
                    2,
                    (index) {
                      return const Skeletonizer(
                        enabled: true,
                        effect: ShimmerEffect(),
                        child: ProductOptionDropdown(
                          name: "name",
                          values: [],
                        ),
                      );
                    },
                  ),
                  15.verticalSpace(),
                ] else ...[
                  if (controller.product.options.isNotEmpty) ...[
                    ...List.generate(
                      controller.product.options.length,
                      (index) {
                        if (controller.product.options[index].type ==
                            "select") {
                          return ProductOptionDropdown(
                            name: controller.product.options[index].name,
                            values: controller.product.options[index].values,
                            value: controller.optionIDValues[
                                controller.product.options[index].id],
                            onChange: (value) {
                              controller.onChangeOptionValue(index, value);
                            },
                          );
                        }
                        return ProductOptionCheckbox(
                          name: controller.product.options[index].name,
                          price: controller.product.options[index].price,
                          value: controller.optionIDValues[
                                  controller.product.options[index].id] ??
                              false,
                          onChange: (value) {
                            controller.onChangeOptionValue(index, value);
                          },
                        );
                      },
                    ),
                    15.verticalSpace(),
                  ],
                ],
              ],
            ),
          );
        });
  }
}
