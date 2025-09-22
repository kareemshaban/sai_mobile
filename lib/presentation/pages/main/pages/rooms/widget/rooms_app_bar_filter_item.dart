import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class RoomsAppBarFilterItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final void Function()? onTap;
  final Color? color;
  const RoomsAppBarFilterItem({
    super.key,
    required this.title,
    this.isActive = false,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Get.textTheme.titleSmall!.copyWith(
              fontSize: AppSize.s22(context),
              color: color ?? (isActive ? null : ColorManager.textGrey),
            ),
          ),
          Container(
            height: 3.0,
            width: 15.0,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(5)
            ),
          ),
        ],
      ),
    );
  }
}
