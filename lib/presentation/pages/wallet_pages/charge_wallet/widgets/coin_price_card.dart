import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/domain/entity/wallet_entity/units_entity.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class CoinPriceCard extends StatelessWidget {
  const CoinPriceCard({super.key, required this.unit});
  final ChargingUnitEntity unit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  child: const AppIcon(
                    icon: IconsAssets.coins,
                    width: 20,
                    height: 20,
                  ),
                ),
                Text(
                  unit.goldValue,
                  style: Get.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeightManger.semiBold,
                    fontSize: AppSize.s15(context),
                  ),
                ),
              ],
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                child: Text("${unit.unitValue} SAR"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
