import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/model/cart_local_model.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class ConfirmOrderProductWidget extends StatelessWidget {
  final CartLocalModel model;
  const ConfirmOrderProductWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(
          image: model.image,
          width: 70,
          height: 70,
          radius: 5,
          fit: BoxFit.cover,
        ),
        15.horizontalSpace(),
        Flexible(
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: Get.textTheme.titleMedium!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
              10.verticalSpace(),
              Row(
                children: [
                  const AppIcon(
                    icon: IconsAssets.coins,
                    height: 15,
                    width: 15,
                  ),
                  5.horizontalSpace(),
                  Text(
                    (model.price * model.quantity).formatCurrency(context),
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontSize: AppSize.s15(context),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Text(
          "${AppStrings.count} ${model.quantity}",
          style: Get.textTheme.displayMedium!.copyWith(
            fontSize: AppSize.s15(context),
          ),
        ),
      ],
    );
  }
}
