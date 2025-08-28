import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class SwitchCameraButton extends StatelessWidget {
  final CameraState state;
  const SwitchCameraButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        state.switchCameraSensor(
          aspectRatio: CameraAspectRatios.ratio_16_9,
        );
      },
      child: AppIcon(
        icon: IconsAssets.cameraRotate,
        color: ColorManager.white.withOpacity(.9),
        width: 30,
        height: 30,
      ),
    );
  }
}
