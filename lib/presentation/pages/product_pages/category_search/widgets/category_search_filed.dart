import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/getx/category_search_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/widgets/filter_options_bottom_sheet.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class CategorySearchFiled extends GetView<CategorySearchController> {
  const CategorySearchFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      sliver: AppFormFiled(
        controller: controller.searchController,
        prefixIcon: Icon(
          Icons.search,
          color: ColorManager.black.withOpacity(.4),
        ),
        hint: '${AppStrings.search} ...',
        suffixIcon: IntrinsicHeight(
          child: Obx(
            () => Stack(
              children: [
                InkWell(
                  onTap: () => Get.bottomSheet(
                    const FilterOptionsBottomSheet(),
                    isScrollControlled: true,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      VerticalDivider(
                        width: 0,
                        endIndent: 10,
                        indent: 10,
                        color: ColorManager.black.withOpacity(.4),
                      ),
                      16.horizontalSpace(),
                      const AppIcon(
                        icon: IconsAssets.filter,
                      ),
                      20.horizontalSpace(),
                    ],
                  ),
                ),
                if (controller.optionsValues.isNotEmpty)
                  PositionedDirectional(
                    top: 4,
                    start: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.appRedColor,
                      ),
                      child: Text(
                        controller.optionsValues.length.toString(),
                        style: Get.textTheme.bodyLarge!.copyWith(
                          fontSize: AppSize.s12(context),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        borderRadius: 100,
        borderColor: ColorManager.black.withOpacity(.4),
        action: TextInputAction.search,
        onSubmit: (value) {
          controller.searchProduct();
        },
      ).toSliver(),
    );
  }
}
