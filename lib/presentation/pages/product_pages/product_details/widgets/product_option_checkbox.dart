import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class ProductOptionCheckbox extends StatelessWidget {
  final String name;
  final num price;
  final bool value;
  final void Function(bool?)? onChange;

  const ProductOptionCheckbox({
    super.key,
    required this.name,
    required this.price,
    this.value = false,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: name,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s18(context),
                  ),
                ),
                TextSpan(
                  text: "+${price.formatCurrency(context)}",
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s14(context),
                    color: Colors.amber,
                  ),
                ),
                const WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: AppIcon(
                      icon: IconsAssets.coins,
                      width: 12,
                      height: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: value,
              onChanged: onChange,
            ),
          ),
        ],
      ),
    );
  }
}
