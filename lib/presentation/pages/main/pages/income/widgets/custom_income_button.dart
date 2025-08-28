import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class CustomIncomeButton extends StatelessWidget {
  final String title;
  final String icon;
  final String? value;
  final Color? color;
  final void Function()? onTap;
  const CustomIncomeButton({
    super.key,
    required this.title,
    required this.icon,
    this.color,
    this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          16.horizontalSpace(),
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: AppIcon(
              icon: icon,
            ),
          ),
          18.horizontalSpace(),
          Text(
            title,
            style: Get.textTheme.titleMedium!.copyWith(
              fontSize: AppSize.s18(context),
            ),
          ),
          const Spacer(),
          if (value != null)
            Container(
              padding: const EdgeInsets.only(top: 10,left: 4,right: 4,bottom: 5),
              margin: const EdgeInsetsDirectional.only(end: 10),
              decoration: const BoxDecoration(
                color: ColorManager.red,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  value!,
                  style: Get.textTheme.bodyLarge!.copyWith(
                    fontSize: AppSize.s14(context),
                  ),
                ),
              ),
            ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 22,
            color: ColorManager.iconGreyColor,
          ),
          16.horizontalSpace(),
        ],
      ),
    );
  }
}
