import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/model/cart_local_model.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class CartProductItem extends StatelessWidget {
  final CartLocalModel model;
  final void Function()? onIncreaceQuantity;
  final void Function()? onDecreaceQuantity;
  final void Function()? onDeleteProduct;
  const CartProductItem({
    super.key,
    required this.model,
    this.onIncreaceQuantity,
    this.onDecreaceQuantity,
    this.onDeleteProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 161,
      width: 1.w(context),
      padding: const EdgeInsetsDirectional.only(
        start: 5,
        end: 13,
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          AppImage(
            image: model.image,
            width: 100,
            height: 142,
            radius: 15,
            fit: BoxFit.cover,
          ),
          5.horizontalSpace(),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.title,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s16(context),
                  ),
                ),
                11.verticalSpace(),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: "${AppStrings.was}  ",
                //         style: Get.textTheme.labelSmall!.copyWith(
                //           fontSize: AppSize.s10(context),
                //           color: ColorManager.textGrey2,
                //         ),
                //       ),
                //       TextSpan(
                //         text: "12000",
                //         style: Get.textTheme.labelSmall!.copyWith(
                //           fontSize: AppSize.s10(context),
                //           color: ColorManager.textGrey2,
                //           decoration: TextDecoration.lineThrough,
                //           decorationColor: ColorManager.textGrey2,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // 1.verticalSpace(),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: (model.quantity * model.price)
                            .formatCurrency(context),
                        style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: AppSize.s14(context),
                        ),
                      ),
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: AppIcon(
                            icon: IconsAssets.coins,
                            width: 12,
                            height: 12,
                          ),
                        ),
                      )
                      // TextSpan(
                      //   text: "${AppStrings.discount} 23%",
                      //   style: Get.textTheme.titleLarge!.copyWith(
                      //     fontSize: AppSize.s10(context),
                      //     color: ColorManager.green,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                20.verticalSpace(),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.lightGreyColor.withOpacity(.2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: onIncreaceQuantity,
                          child: const Icon(
                            Icons.add,
                            size: 18,
                            color: ColorManager.iconGreyColor,
                          ),
                        ),
                        5.horizontalSpace(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.lightGreyColor.withOpacity(.7),
                          ),
                          child: Text(
                            model.quantity.toString(),
                            style: Get.textTheme.titleSmall!.copyWith(
                              fontSize: AppSize.s14(context),
                            ),
                          ),
                        ),
                        5.horizontalSpace(),
                        model.quantity != model.minQuantity
                            ? InkWell(
                                onTap: onDecreaceQuantity,
                                child: const Icon(
                                  Icons.remove,
                                  size: 18,
                                  color: ColorManager.iconGreyColor,
                                ),
                              )
                            : InkWell(
                                onTap: onDeleteProduct,
                                child: const AppIcon(
                                  icon: IconsAssets.delete,
                                  color: ColorManager.appRedColor,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
