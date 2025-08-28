import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/domain/entity/stories_entity/post_data_entity.dart';
import 'package:new_sai/presentation/pages/gallery/getx/gallery_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:photo_manager/photo_manager.dart';

enum MediaTypeEnum {
  video,
  photo,
  text,
}

class CaptureButton extends StatelessWidget {
  final CameraState state;
  final bool isStory;
  const CaptureButton({super.key, required this.state, required this.isStory});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (state is PhotoCameraState) {
          var photo = state as PhotoCameraState;
          var result = await photo.takePhoto();
          if (result.path != null) {
            List<SelectedPathsModel> pathes = [];
            pathes.add(
                SelectedPathsModel(path: result.path!, type: AssetType.image));
            Get.toNamed(
              AppRoutes.postViewRoute,
              arguments: {
                "isStory": isStory,
                "data": PostDataEntity(
                  mediaPathList: pathes,
                  textContent: "",
                )
              },
            );
          }
        }
        if (state is VideoCameraState) {
          (state as VideoCameraState).startRecording();
        }
        if (state is VideoRecordingCameraState) {
          var video = state as VideoRecordingCameraState;
          await video.stopRecording(
            onVideo: (videoClip) {
              if (videoClip.path != null) {
                List<SelectedPathsModel> pathes = [];
                pathes.add(SelectedPathsModel(
                    type: AssetType.video, path: videoClip.path!));
                Get.toNamed(
                  AppRoutes.postViewRoute,
                  arguments: {
                    "isStory": isStory,
                    "data": PostDataEntity(
                      mediaPathList: pathes,
                      textContent: "",
                    )
                  },
                );
              }
            },
          );
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: ColorManager.white,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: ColorManager.black,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _checkbuttonState(),
              shape: BoxShape.circle,
            ),
            child: state is VideoRecordingCameraState
                ? const Center(
                    child: Icon(
                      Icons.square_rounded,
                      color: ColorManager.white,
                      size: 45,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  _checkbuttonState() {
    switch (state.runtimeType) {
      case const (PhotoCameraState):
        return ColorManager.primary;
      case const (VideoCameraState):
      case const (VideoRecordingCameraState):
        return ColorManager.red;
    }
  }
}
