import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/camera/getx/camera_controller.dart';
import 'package:new_sai/presentation/pages/camera/widgets/camera_photo_mode.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class CameraView extends GetView<CameraController> {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.black,
        body: CameraAwesomeBuilder.custom(
          builder: (CameraState state, preview) {
            return state.when(
              onPreparingCamera: (PreparingCameraState state) {
                return const Center(
                    child: AppLoader(color: ColorManager.white));
              },
              onPhotoMode: (PhotoCameraState state) {
                return CameraPhotoMode(state: state);
              },
              onPreviewMode: (PreviewCameraState state) {
                return CameraPhotoMode(state: state);
              },
              onVideoMode: (VideoCameraState state) {
                return CameraPhotoMode(state: state);
              },
              onVideoRecordingMode: (VideoRecordingCameraState state) {
                return CameraPhotoMode(state: state);
              },
            );
          },
          saveConfig: SaveConfig.photoAndVideo(
            initialCaptureMode: CaptureMode.photo,
            exifPreferences: ExifPreferences(saveGPSLocation: false),
          ),
          sensorConfig: SensorConfig.single(
            aspectRatio: CameraAspectRatios.ratio_4_3,
          ),
          enablePhysicalButton: true,
          mirrorFrontCamera: true,
        ),
      ),
    );
  }
}
