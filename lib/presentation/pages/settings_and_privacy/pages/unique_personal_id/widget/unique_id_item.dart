import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/settings_entity/settings_market_product_entity.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_image_view.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

import 'buy_settings_product_dialog.dart';

class UniqueIdItem extends StatelessWidget {
  final SettingsMarketProductEntity model;
  final void Function()? onTapSelected;
  const UniqueIdItem({super.key, required this.model, this.onTapSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (model.isSelected) {
          return;
        }
        if (model.isBuy) {
          onTapSelected!();
          return;
        }
        Get.dialog(
          BuySettingsProductDialog(
            productId: model.id,
            goldValue: model.goldPrice,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: model.category == "Backgrounds"
              ? ColorManager.primary.withOpacity(.2)
              : ColorManager.yellowColor2,
        ),
        child: model.category == "Backgrounds"
            ? Stack(
                children: [
                  AppImage(
                    image: model.image,
                    fit: BoxFit.cover,
                    radius: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 1.w(context),
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      color: ColorManager.yellowColor3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AppIcon(
                            icon: IconsAssets.coins,
                            width: 20,
                            height: 20,
                          ),
                          8.horizontalSpace(),
                          Text(
                            model.isSelected
                                ? AppStrings.wasAppointed
                                : model.isBuy
                                    ? AppStrings.purchased
                                    : model
                                        .goldPrice.formatCurrencyWithoutSymbol,
                            style: Get.textTheme.titleMedium!,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: InkWell(
                      onTap: () => Get.to(RoomImageView(image: model.image)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorManager.black.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.visibility_outlined,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageAssets.specialIdBadge,
                        width: 50,
                        height: 50,
                      ),
                      10.horizontalSpace(),
                      Text(
                        model.productId,
                        style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: AppSize.s16(context),
                          color: ColorManager.red,
                        ),
                      )
                    ],
                  ),
                  10.verticalSpace(),
                  Container(
                    width: 1.w(context),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    color: ColorManager.yellowColor3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppIcon(
                          icon: IconsAssets.coins,
                          width: 20,
                          height: 20,
                        ),
                        8.horizontalSpace(),
                        Text(
                          model.isSelected
                              ? AppStrings.wasAppointed
                              : model.isBuy
                                  ? AppStrings.purchased
                                  : model.goldPrice.formatCurrencyWithoutSymbol,
                          style: Get.textTheme.titleMedium!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
