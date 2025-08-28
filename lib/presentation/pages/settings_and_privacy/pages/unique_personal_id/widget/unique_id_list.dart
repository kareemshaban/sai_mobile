import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/getx/unique_personal_id_controller.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

import 'unique_id_item.dart';

class UniqueIdList extends GetView<UniquePersonalIdController> {
  const UniqueIdList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingProducts
          ? const Center(child: AppLoader())
          : controller.products.isEmpty
              ? const EmptyDataWidget()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: controller.products.isNotEmpty
                        ? controller.products.first.category == "Backgrounds"
                            ? .7
                            : 1.65
                        : 1.65,
                  ),
                  itemBuilder: (context, index) {
                    return Obx(
                      () => UniqueIdItem(
                        model: controller.products[index],
                        onTapSelected: () {
                          controller.onTapSelected(index);
                        },
                      ),
                    );
                  },
                  itemCount: controller.products.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                ),
    );
  }
}
