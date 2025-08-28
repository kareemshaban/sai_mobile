import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/camera/getx/camera_controller.dart';

import 'camera_back_button.dart';
import 'camera_bottom_bar.dart';
import 'camera_flash_button.dart';
import 'switch_camera_button.dart';

class CameraPhotoMode extends GetView<CameraController> {
  final CameraState state;
  const CameraPhotoMode({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CameraBackButton(),
        PositionedDirectional(
          end: 25,
          top: 25,
          child: Column(
            children: [
              SwitchCameraButton(state: state),
              27.verticalSpace(),
              CameraFlashButton(state: state),
              // if (controller.isStory) ...[
              //   24.verticalSpace(),
              //   const CameraTimerButton(),
              // ],
            ],
          ),
        ),
        CameraBottomBar(state: state)
      ],
    );
  }
}
