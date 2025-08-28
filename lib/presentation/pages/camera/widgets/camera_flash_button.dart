import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/camera/getx/camera_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class CameraFlashButton extends GetView<CameraController> {
  final CameraState state;
  const CameraFlashButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.onChangeFlash(state);
      },
      child: Obx(
        () => AppIcon(
          icon: controller.isFlashOn
              ? IconsAssets.falshOff
              : IconsAssets.falshOff,
          color: ColorManager.white.withOpacity(.8),
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}
