import 'package:flutter/material.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class CameraTimerButton extends StatelessWidget {
  const CameraTimerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppIcon(
      icon: IconsAssets.cameraTimer,
      color: ColorManager.white.withOpacity(.8),
      width: 35,
      height: 35,
    );
  }
}
