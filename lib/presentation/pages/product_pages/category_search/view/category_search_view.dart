import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/widgets/category_search_category_list.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/widgets/category_search_filed.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/getx/category_search_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/widgets/sort_type_bottom_sheet.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

import '../widgets/category_search_product_list.dart';

class CategorySearchView extends GetView<CategorySearchController> {
  const CategorySearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: Text(controller.category.name),
          actions: [
            Stack(
              children: [
                InkWell(
                  onTap: () => Get.bottomSheet(const SortTypeBottomSheet()),
                  child: const AppIcon(
                    icon: IconsAssets.arrowUpDown,
                  ),
                ),
                if (controller.sortTypeValue.isNotEmpty)
                  PositionedDirectional(
                    top: -5,
                    start: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.appRedColor,
                      ),
                      child: Text(
                        "1",
                        style: Get.textTheme.bodyLarge!.copyWith(
                          fontSize: AppSize.s12(context),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            16.horizontalSpace(),
          ],
        ),
        body: Obx(
          () => CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              const CategorySearchFiled(),
              const CategorySearchCategoryList(),
              const CategorySearchProductList(),
              if (controller.loadingSearchPagination)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: AppLoader()),
                ).toSliver(),
            ],
          ),
        ),
      ),
    );
  }
}
