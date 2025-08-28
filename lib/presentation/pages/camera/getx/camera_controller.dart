import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class CameraController extends GetxController {
  late PageController pageController;
  List<String> modes = [
    AppStrings.video,
    AppStrings.photo,
    // AppStrings.text,
  ];
  late bool isStory;

  final RxInt _currentIndex = 1.obs;
  final RxBool _isFlashOn = false.obs;

  int get currentIndex => _currentIndex.value;
  bool get isFlashOn => _isFlashOn.value;

  set currentIndex(value) => _currentIndex.value = value;
  set isFlashOn(value) => _isFlashOn.value = value;

  onChangeFlash(CameraState state) {
    isFlashOn = !isFlashOn;
    state.sensorConfig
        .setFlashMode(isFlashOn ? FlashMode.always : FlashMode.none);
  }

  onChangedCaptureMode(int index, CameraState state) {
    if (index == 0) {
      state.setState(CaptureMode.video);
    } else if (index == 1) {
      state.setState(CaptureMode.photo);
    } else {
      state.setState(CaptureMode.preview);
    }
  }

  onPageChanged(int index, CameraState state) {
    currentIndex = index;
    onChangedCaptureMode(index, state);
  }

  @override
  void onInit() {
    isStory = Get.arguments['isStory'] ?? false;
    pageController = PageController(
      initialPage: 1,
      viewportFraction: .25,
    );
    super.onInit();
  }
}
