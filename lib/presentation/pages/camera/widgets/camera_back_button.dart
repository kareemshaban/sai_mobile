import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';

class CameraBackButton extends StatelessWidget {
  const CameraBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      start: 25,
      top: 25,
      child: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.close,
          color: ColorManager.white.withOpacity(.85),
        ),
      ),
    );
  }
}
