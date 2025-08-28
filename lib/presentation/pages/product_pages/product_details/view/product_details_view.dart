import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/dynamic_link_handler.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/widgets/order_bottom_sheet_button.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/widgets/product_description.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/widgets/product_images.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/widgets/product_name_and_review.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/widgets/product_options_widget.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/widgets/product_price_and_quantity.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/widgets/product_store_details.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/widgets/similar_products_list.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/share_bottom_sheet.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(
          AppStrings.productDetails,
        ),
        actions: [
          GetBuilder<ProductDetailsController>(
            tag: Get.arguments.toString(),
            builder: (controller) {
              return Obx(
                () => controller.loadingGetProduct
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          final link =
                              "Checkout this product in SAI app ${DynamicLinkHandler.createProductLink(id: controller.product.id, productName: controller.product.name)}";
                          Get.bottomSheet(ShareBottomSheet(shareLink: link));
                        },
                        child: const AppIcon(icon: IconsAssets.share2)),
              );
            },
          ),
          16.horizontalSpace(),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImages(),
            ProductNameAndReview(),
            ProductStoreDetails(),
            ProductDescription(),
            ProductOptionsWidget(),
            ProductPriceAndQuantity(),
            SimilarProductsList(),
          ],
        ),
      ),
      bottomNavigationBar: isGuest() ? null : const OrderBottomSheetButton(),
    );
  }
}
