import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class EditProfileValueButton extends StatelessWidget {
  final String title;
  final String value;
  final double? valueTextSize;
  final void Function()? onTap;
  const EditProfileValueButton({
    super.key,
    required this.title,
    required this.value,
    this.valueTextSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            Text(
              title,
              style: Get.textTheme.titleMedium!.copyWith(
                fontSize: AppSize.s20(context),
              ),
            ),
            8.horizontalSpace(),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                value,
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.headlineSmall!.copyWith(
                  fontSize: valueTextSize ?? AppSize.s20(context),
                  color: ColorManager.dividerColor,
                ),
              ),
            ),
            8.horizontalSpace(),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.iconGreyColor,
              size: 22,
            )
          ],
        ),
      ),
    );
  }
}
