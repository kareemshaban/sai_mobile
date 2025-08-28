import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/custom_switch.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final String? icon;
  final IconData? iconData;
  final String? value;
  final void Function()? onTap;
  final bool isSwitch;
  final bool withColor;
  final bool switchValue;
  const SettingItem({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.value,
    this.isSwitch = false,
    this.iconData,
    this.withColor = true,
    this.switchValue = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (icon != null) ...[
            AppIcon(
              icon: icon!,
              width: 20,
              height: 20,
              color: withColor ? ColorManager.iconGreyColor : null,
            ),
            7.horizontalSpace(),
          ],
          if (iconData != null) ...[
            Icon(
              iconData!,
              size: 25,
              color: ColorManager.iconGreyColor,
            ),
            7.horizontalSpace(),
          ],
          Text(
            title,
            style: Get.textTheme.titleMedium!.copyWith(
              fontSize: AppSize.s20(context),
            ),
          ),
          if (value != null) ...[
            7.horizontalSpace(),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                value!,
                textAlign: TextAlign.end,
                style: Get.textTheme.headlineSmall!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
            ),
          ] else
            const Spacer(),
          7.horizontalSpace(),
          if (isSwitch)
            CustomSwitch(
              value: switchValue,
            )
          else
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: ColorManager.iconGreyColor,
            )
        ],
      ),
    );
  }
}
