import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class BillWidget extends StatelessWidget {
  final String total;
  final String discount;
  final String? deliveryValue;
  final String finalTotal;
  const BillWidget({
    super.key,
    required this.total,
    required this.discount,
    this.deliveryValue,
    required this.finalTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppStrings.total,
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSize.s15(context),
              ),
            ),
            const Spacer(),
            Text(
              total,
              style: Get.textTheme.titleMedium!.copyWith(
                fontSize: AppSize.s15(context),
              ),
            ),
            2.horizontalSpace(),
            const AppIcon(
              icon: IconsAssets.coins,
              width: 12,
              height: 12,
            ),
          ],
        ),
        20.verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.discountValue,
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSize.s15(context),
              ),
            ),
            Text(
              '%$discount',
              style: Get.textTheme.titleMedium!.copyWith(
                fontSize: AppSize.s15(context),
              ),
            ),
          ],
        ),
        20.verticalSpace(),
        if (deliveryValue != null) ...[
          Row(
            children: [
              Text(
                AppStrings.deliveryCost,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
              const Spacer(),
              Text(
                deliveryValue!,
                style: Get.textTheme.titleMedium!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
              2.horizontalSpace(),
              const AppIcon(
                icon: IconsAssets.coins,
                width: 12,
                height: 12,
              ),
            ],
          ),
          20.verticalSpace(),
        ],
        Row(
          children: [
            Text(
              AppStrings.finalTotal,
              style: Get.textTheme.displayMedium!.copyWith(
                fontSize: AppSize.s16(context),
              ),
            ),
            const Spacer(),
            Text(
              finalTotal,
              style: Get.textTheme.displayMedium!.copyWith(
                fontSize: AppSize.s16(context),
              ),
            ),
            2.horizontalSpace(),
            const AppIcon(
              icon: IconsAssets.coins,
              width: 12,
              height: 12,
            ),
          ],
        ),
        35.verticalSpace(),
      ],
    );
  }
}
