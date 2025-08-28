import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_permission.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/camera/getx/camera_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

import 'capture_button.dart';
import 'capture_mode_page_view.dart';

class CameraBottomBar extends GetView<CameraController> {
  final CameraState state;
  const CameraBottomBar({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      bottom: 0,
      width: 1.w(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        color: ColorManager.black.withOpacity(.3),
        child: Column(
          children: [
            CaptureModePageView(state: state),
            18.verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // if (true)
                const SizedBox(width: 50),
                // else
                //   const AppIcon(
                //     icon: IconsAssets.emoji,
                //     color: ColorManager.white,
                //     width: 50,
                //     height: 50,
                //   ),
                CaptureButton(
                  state: state,
                  isStory: controller.isStory,
                ),
                InkWell(
                  onTap: () async {
                    if (await AppPermission.requestStoragePermission() ||
                        await AppPermission.requestMediaLocationPermission()) {
                      Get.toNamed(
                        AppRoutes.galleryRoute,
                        arguments: {
                          'isStory': controller.isStory,
                        },
                      );
                    }
                  },
                  child: const AppIcon(
                    icon: IconsAssets.gallery,
                    width: 38,
                    height: 38,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
            if (!controller.isStory) ...[
              7.verticalSpace(),
              Text(
                AppStrings.post,
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontSize: AppSize.s20(context),
                  fontWeight: FontWeightManger.semiBold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
