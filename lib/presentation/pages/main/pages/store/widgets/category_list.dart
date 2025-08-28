import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/store/getx/store_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_loading/category_loading_item.dart';

import 'category_item.dart';

class CategoryList extends GetView<StoreController> {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingHomeData
          ? Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppStrings.products,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s25(context),
                    ),
                  ),
                ),
                11.verticalSpace(),
                Wrap(
                  spacing: 9,
                  runSpacing: 21,
                  children: List.generate(
                    5,
                    (index) => const CategoryLoadingItem(),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                if (controller.homeData.categories.isNotEmpty) ...[
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      AppStrings.products,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s25(context),
                      ),
                    ),
                  ),
                  11.verticalSpace(),
                  Wrap(
                    spacing: 9,
                    runSpacing: 21,
                    children: List.generate(
                      controller.homeData.categories.length,
                      (index) => CategoryItem(
                          category: controller.homeData.categories[index]),
                    ),
                  ),
                  15.verticalSpace(),
                ],
              ],
            ),
    );
  }
}
