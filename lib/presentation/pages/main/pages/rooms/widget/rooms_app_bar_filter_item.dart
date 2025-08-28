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
      child: SizedBox(
        height: 60,
        child: Column(
          children: [
            Text(
              title,
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSize.s22(context),
                color: color ?? (isActive ? null : ColorManager.textGrey),
              ),
            ),
            AnimatedOpacity(
              opacity: isActive ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Transform.rotate(
                angle: 2.37,
                child: AppIcon(
                  icon: IconsAssets.line,
                  color: color ?? ColorManager.black,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
