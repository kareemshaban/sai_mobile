import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/store_entity/product_entity.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class ProductItem extends StatelessWidget {
  final bool isForFavorite;
  final ProductEntity product;
  final bool isFavorite;
  final bool isLoading;
  final void Function()? onTapFavorite;

  const ProductItem({
    super.key,
    this.isForFavorite = false,
    required this.product,
    this.isFavorite = false,
    this.isLoading = false,
    this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading
          ? null
          : () => Get.toNamed(
                AppRoutes.productDetailsRoute,
                arguments: product.id,
                preventDuplicates: false,
              ),
      child: Container(
        width: 154,
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorManager.black.withOpacity(.4),
            width: .2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 1.w(context),
              height: 135,
              child: Stack(
                children: [
                  Container(
                    width: 1.w(context),
                    height: 135,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: AppImage(
                      image: product.image,
                      radius: 10,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: InkWell(
                      onTap: onTapFavorite,
                      child: Container(
                        width: 25,
                        height: 25,
                        margin: const EdgeInsets.all(3),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFEAEAEA),
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 17,
                          color: isFavorite ? ColorManager.red : null,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 5),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFEAEAEA),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            product.reviewVal.toString(),
                            style: Get.textTheme.titleSmall!.copyWith(
                              fontSize: AppSize.s10(context),
                            ),
                          ),
                          1.horizontalSpace(),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 13,
                          ),
                          2.horizontalSpace(),
                          Text(
                            "(${product.reviewsCount})",
                            style: Get.textTheme.titleSmall!.copyWith(
                              fontSize: AppSize.s7(context),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            3.verticalSpace(),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSize.s13(context),
              ),
            ),
            10.verticalSpace(),
            Row(
              children: [
                Text(
                  product.hasOptions > 0
                      ? AppStrings.priceUponSelection
                      : product.offerPrice != 0
                          ? product.offerPrice.formatCurrency(context)
                          : product.buyPrice.formatCurrency(context),
                  style: Get.textTheme.titleLarge!.copyWith(
                    fontSize: AppSize.s11(context),
                  ),
                ),
                2.horizontalSpace(),
                const AppIcon(
                  icon: IconsAssets.coins,
                  width: 12,
                  height: 12,
                ),
                2.horizontalSpace(),
                if (product.offerPrice != 0 && product.hasOptions == 0)
                  Text(
                    "${AppStrings.discount} ${((product.offerPrice / product.buyPrice) * 100).toStringAsFixed(0)}%",
                    style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSize.s7(context),
                      color: ColorManager.green,
                    ),
                  ),
                3.horizontalSpace(),
              ],
            ),
            8.verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.category.name,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s9(context),
                  ),
                ),
                if (!isForFavorite)
                  if (!isLoading)
                    Container(
                      width: 45,
                      height: 45,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.primary,
                      ),
                      child: const AppIcon(
                        icon: IconsAssets.cartProduct,
                        color: ColorManager.white,
                      ),
                    ),
              ],
            ),
            if (isForFavorite) ...[
              10.verticalSpace(),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: AppStrings.addToCart,
                      textSize: AppSize.s8(context),
                      height: 22,
                    ),
                  ),
                  12.horizontalSpace(),
                  const Icon(
                    Icons.more_horiz,
                    color: ColorManager.iconGreyColor,
                    size: 22,
                  )
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
