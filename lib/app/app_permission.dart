import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_permission_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  static Future<bool> requestStoragePermission() async {
    final storage = await Permission.storage.request();

    if (storage.isGranted) {
      return storage.isGranted;
    } else {
      Get.dialog(AppPermissionDialog(
          message: AppStrings.youMustEnablePermissionToAccessTheStorage));
    }
    return false;
  }

  static Future<bool> requestAudioPermission() async {
    final audio = await Permission.audio.request();
    if (audio.isGranted) {
      return audio.isGranted;
    } else {
      Get.dialog(AppPermissionDialog(
          message: AppStrings.youMustEnablePermissionToAccessAudioFiles));
    }
    return false;
  }

  static Future<bool> requestPhotoPermission() async {
    final photo = await Permission.photos.request();
    if (photo.isGranted) {
      return photo.isGranted;
    } else {
      Get.dialog(AppPermissionDialog(
          message: AppStrings.youMustEnablePermissionToAccessPhotoFiles));
    }
    return false;
  }

  static Future<bool> requestVideoPermission() async {
    final video = await Permission.videos.request();
    if (video.isGranted) {
      return video.isGranted;
    } else {
      Get.dialog(AppPermissionDialog(
          message: AppStrings.youMustEnablePermissionToAccessVideoFiles));
    }
    return false;
  }

  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      return status.isGranted;
    } else {
      Get.dialog(AppPermissionDialog(
          message: AppStrings.youMustEnablePermissionToAccessTheCamera));
    }
    return false;
  }

  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      return status.isGranted;
    } else {
      Get.dialog(AppPermissionDialog(
          message: AppStrings.youMustEnablePermissionToAccessTheLocation));
    }
    return false;
  }

  static Future<bool> requestMicPermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      return status.isGranted;
    } else {
      Get.dialog(AppPermissionDialog(
          message: AppStrings.youMustEnablePermissionToAccessTheMic));
    }
    return false;
  }

  static Future<bool> requestMediaLocationPermission() async {
    final status = await Permission.accessMediaLocation.request();
    if (status.isGranted) {
      return status.isGranted;
    } else {
      Get.dialog(AppPermissionDialog(
          message: AppStrings.youMustEnablePermissionToAccessMediaFiles));
    }
    return false;
  }
}
