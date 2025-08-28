import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/getx/category_search_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class FilterOptionsBottomSheet extends GetView<CategorySearchController> {
  const FilterOptionsBottomSheet({super.key});

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
      child: Obx(
        () => Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.filter,
                  style: Get.textTheme.titleLarge!.copyWith(
                    fontSize: AppSize.s24(context),
                  ),
                ),
                20.verticalSpace(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.options[index].name,
                        style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: AppSize.s20(context),
                        ),
                      ),
                      ...List.generate(
                        controller.options[index].values.length,
                        (index2) {
                          return RadioListTile<int>(
                            value: controller.options[index].values[index2].id,
                            groupValue: controller.optionsValues[
                                    controller.options[index].id] ??
                                0,
                            onChanged: (value) {
                              controller.optionsValues[
                                  controller.options[index].id] = value!;
                            },
                            title: Text(
                              controller.options[index].values[index2].name,
                              style: Get.textTheme.titleMedium!.copyWith(
                                fontSize: AppSize.s20(context),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  itemCount: controller.options.length,
                ),
                10.verticalSpace(),
                AppButton(
                  title: AppStrings.apply,
                  width: 1.w(context),
                  onTap: () {
                    Get.back();
                    controller.searchProduct();
                  },
                ),
              ],
            ),
            if (controller.optionsValues.isNotEmpty)
              InkWell(
                onTap: () {
                  controller.optionsValues.clear();
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
      ),
    );
  }
}
