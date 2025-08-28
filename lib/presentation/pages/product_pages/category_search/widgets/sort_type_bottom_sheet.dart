import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/getx/category_search_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class SortTypeBottomSheet extends GetView<CategorySearchController> {
  const SortTypeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.order2,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s22(context),
                ),
              ),
              20.verticalSpace(),
              RadioListTile(
                value: "most_price",
                groupValue: controller.sortTypeValue,
                onChanged: controller.onChangeSortTypeValue,
                title: Text(
                  AppStrings.mostPrice,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s18(context),
                  ),
                ),
              ),
              RadioListTile(
                value: "less_price",
                groupValue: controller.sortTypeValue,
                onChanged: controller.onChangeSortTypeValue,
                title: Text(
                  AppStrings.lessPrice,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s18(context),
                  ),
                ),
              ),
              RadioListTile(
                value: "latest",
                groupValue: controller.sortTypeValue,
                onChanged: controller.onChangeSortTypeValue,
                title: Text(
                  AppStrings.latest,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s18(context),
                  ),
                ),
              ),
              RadioListTile(
                value: "oldest",
                groupValue: controller.sortTypeValue,
                onChanged: controller.onChangeSortTypeValue,
                title: Text(
                  AppStrings.oldest,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s18(context),
                  ),
                ),
              ),
            ],
          ),
          if (controller.sortTypeValue.isNotEmpty)
            InkWell(
              onTap: () {
                Get.back();
                controller.sortTypeValue = '';
                controller.searchProduct();
              },
              child: Text(
                AppStrings.delete,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s16(context),
                  color: ColorManager.appRedColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
