import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class FlagForFormFiled extends StatelessWidget {
  final void Function()? onTap;
  final String flag;
  final String code;
  final bool isName;
  const FlagForFormFiled({
    super.key,
    this.onTap,
    required this.flag,
    required this.code,
    this.isName = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            8.horizontalSpace(),
            if (isName)
              Text(
                flag,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              )
            else
              Image.asset(
                flag,
                width: 26,
                height: 26,
                package: "fl_country_code_picker",
              ),
            4.horizontalSpace(),
            Text(
              code,
              textDirection: TextDirection.ltr,
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSize.s15(context),
              ),
            ),
            VerticalDivider(
              color: ColorManager.black.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}
