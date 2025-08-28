import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/settings_entity/record_entity.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class RecordItem extends StatelessWidget {
  final RecordEntity model;
  final bool withCoins;
  const RecordItem({super.key, required this.model, this.withCoins = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.user,
                style: Get.textTheme.titleMedium!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
              Text(
                model.date,
                style: Get.textTheme.headlineMedium!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
            ],
          ),
        ),
        8.horizontalSpace(),
        Text(
          model.goldValue.formatCurrencyWithoutSymbol,
          style: Get.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.s15(context),
          ),
        ),
        8.horizontalSpace(),
        if (withCoins)
          const AppIcon(icon: IconsAssets.coins)
        else
          const AppIcon(
            icon: IconsAssets.sar,
            width: 20,
            height: 20,
          ),
      ],
    );
  }
}
