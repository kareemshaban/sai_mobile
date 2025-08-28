import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/room_entity/gift_entity.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class GiftItem extends StatelessWidget {
  final GiftEntity gift;
  final GiftEntity selectedGift;
  final void Function()? onTap;
  const GiftItem({
    super.key,
    required this.gift,
    this.onTap,
    required this.selectedGift,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: selectedGift.id == gift.id
              ? Border.all(
                  color: ColorManager.primary,
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage(
              image: gift.giftImg,
              width: 38,
              height: 38,
              fit: BoxFit.contain,
            ),
            7.verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  gift.goldValue.formatCurrencyWithoutSymbol,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s12(context),
                      color:Colors.white
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
          ],
        ),
      ),
    );
  }
}
