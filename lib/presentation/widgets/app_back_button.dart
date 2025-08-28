import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';

import 'app_icon.dart';

class AppBackButton extends StatelessWidget {
  final Color? color;
  final void Function()? onTap;
  const AppBackButton({super.key, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Get.back(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.horizontalSpace(),
          RotatedBox(
            quarterTurns: isArabic(context) ? 0 : 2,
            child: AppIcon(
              icon: IconsAssets.arrowBack,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
