import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/getx/unique_personal_id_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class UniqueIdLineWidget extends GetView<UniquePersonalIdController> {
  const UniqueIdLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            controller.market.subcategories.length,
            (index) {
              return AnimatedOpacity(
                opacity: controller.currentIndex == index ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Transform.rotate(
                  angle: 2.37,
                  child: const AppIcon(
                    icon: IconsAssets.line,
                    color: ColorManager.black,
                    width: 25,
                    height: 25,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
