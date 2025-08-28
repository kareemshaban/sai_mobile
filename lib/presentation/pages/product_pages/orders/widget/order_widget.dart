import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/enums.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/store_entity/order_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class OrderWidget extends StatelessWidget {
  final OrderEntity order;
  const OrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.toNamed(AppRoutes.orderDetailsRoute, arguments: order.id),
      child: Container(
        width: 1.w(context),
        height: 161,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorManager.white,
        ),
        child: Row(
          children: [
            Column(
              children: [
                AppImage(
                  image: order.market.logo,
                  width: 100,
                  height: 133,
                  radius: 10,
                  fit: BoxFit.cover,
                ),
                Text(
                  "${AppStrings.orderNumber} ${order.id}",
                  style: Get.textTheme.headlineSmall!.copyWith(
                    fontSize: AppSize.s10(context),
                    fontWeight: FontWeightManger.light,
                  ),
                )
              ],
            ),
            10.horizontalSpace(),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${AppStrings.productsCount} ${order.productCount}",
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontSize: AppSize.s16(context),
                    ),
                  ),
                  13.verticalSpace(),
                  Text(
                    order.statueTranslate,
                    style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSize.s16(context),
                      color: order.statue == OrderState.canceled
                          ? ColorManager.red
                          : Colors.amberAccent,
                    ),
                  ),
                  16.verticalSpace(),
                  Text(
                    order.orderDatetime,
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontSize: AppSize.s12(context),
                      fontWeight: FontWeightManger.light,
                    ),
                  ),
                  const Spacer(),
                  const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorManager.iconGreyColor,
                      size: 22,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
