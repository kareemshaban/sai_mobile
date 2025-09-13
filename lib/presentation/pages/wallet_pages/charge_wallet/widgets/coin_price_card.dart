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
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  child: const AppIcon(
                    icon: IconsAssets.coins,
                    width: 25,
                    height: 25,
                  ),
                ),
                Text(
                  unit.goldValue,
                  style: Get.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeightManger.semiBold,
                    fontSize: AppSize.s18(context),
                  ),
                ),
              ],
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber.withAlpha(200),
                    borderRadius: BorderRadius.circular(15)),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                child: Text("${unit.unitValue} SAR" , style: TextStyle(color: Colors.black , fontSize: 16.0),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
