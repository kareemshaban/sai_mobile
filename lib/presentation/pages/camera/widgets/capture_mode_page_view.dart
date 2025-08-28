import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/camera/getx/camera_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class CaptureModePageView extends GetView<CameraController> {
  final CameraState state;
  const CaptureModePageView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 1.w(context),
      child: PageView.builder(
        controller: controller.pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) => controller.onPageChanged(index, state),
        itemBuilder: (context, index) {
          return Align(
            alignment: const Alignment(-.1, 0),
            child: InkWell(
              onTap: () => controller.pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              ),
              child: Obx(
                () => Text(
                  controller.modes[index],
                  style: Get.textTheme.bodyLarge!.copyWith(
                    fontSize: AppSize.s20(context),
                    fontWeight: FontWeightManger.semiBold,
                    color: ColorManager.white
                        .withOpacity(controller.currentIndex == index ? 1 : .5),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: controller.modes.length,
      ),
    );
  }
}
