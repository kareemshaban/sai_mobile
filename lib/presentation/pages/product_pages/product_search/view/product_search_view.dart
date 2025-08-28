import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_loading/product_loading_item.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';
import 'package:new_sai/presentation/widgets/product_item.dart';
import 'package:new_sai/presentation/pages/product_pages/product_search/getx/product_search_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/product_search/widget/latest_search_item.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';

class ProductSearchView extends GetView<ProductSearchController> {
  const ProductSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        leadingWidth: 60,
        title: AppFormFiled(
          controller: controller.searchController,
          action: TextInputAction.search,
          suffixIcon: InkWell(
            onTap: () => controller.searchController.clear(),
            child: const Icon(
              Icons.close,
              color: ColorManager.iconGreyColor2,
            ),
          ),
          onSubmit: (value) {
            controller.searchProduct();
          },
          prefixIcon: const Icon(
            Icons.search,
            color: ColorManager.iconGreyColor2,
          ),
          hint: AppStrings.search,
        ),
      ),
      body: Obx(
        () => controller.isSearchEmpty && controller.products.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.lastSearches.isNotEmpty) ...[
                    20.verticalSpace(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        AppStrings.latestSearches,
                        style: Get.textTheme.titleMedium!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                    ),
                    20.verticalSpace(),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => LatestSearchItem(
                          model: controller.lastSearches[index],
                          onTap: () {
                            controller.searchController.text =
                                controller.lastSearches[index].name;
                            controller.searchProduct();
                          },
                          onTapDelete: () {
                            controller.lastSearchBox.deleteAt(index);
                            controller.lastSearches.removeAt(index);
                          },
                        ),
                        separatorBuilder: (context, index) =>
                            23.horizontalSpace(),
                        itemCount: controller.lastSearches.length,
                      ),
                    ),
                  ],
                  const Expanded(child: EmptyDataWidget()),
                ],
              )
            : controller.loadingSearch
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 17,
                      mainAxisSpacing: 11,
                      childAspectRatio: 1.3 / 2,
                    ),
                    itemBuilder: (context, index) => const ProductLoadingItem(),
                    itemCount: 6,
                  )
                : controller.products.isEmpty
                    ? const EmptyDataWidget()
                    : Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 20,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 17,
                                mainAxisSpacing: 11,
                                childAspectRatio: 1.3 / 2,
                              ),
                              itemBuilder: (context, index) => ProductItem(
                                product: controller.products[index],
                                isFavorite:
                                    controller.products[index].isMyFavorite ==
                                        1,
                                onTapFavorite: () =>
                                    controller.onTapFavorite(index),
                              ),
                              itemCount: controller.products.length,
                            ),
                          ),
                          if (controller.loadingSearchPagination)
                            const Center(child: AppLoader()),
                        ],
                      ),
      ),
    );
  }
}
