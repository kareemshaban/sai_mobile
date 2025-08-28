import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/splash/getx/splash_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox.expand(
              child: Gif(
                image: AssetImage(controller.image),
                autostart: Autostart.once,
                placeholder: (context) => const SizedBox(),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.isError)
                      AppButton(
                        title: AppStrings.tryAgain,
                        onTap: controller.checkAppVersion,
                      )
                    else
                      const SizedBox(),
                    20.verticalSpace(),
                    if (controller.currentVersion.isNotEmpty)
                      Text(
                        'by : DreamWD\nv ${controller.currentVersion}',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.titleMedium!.copyWith(
                          fontSize: AppSize.s12(context),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
