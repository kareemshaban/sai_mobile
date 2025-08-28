import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/presentation/pages/main/getx/main_controller.dart';
import 'package:new_sai/presentation/pages/main/widgets/main_bottom_nav_bar.dart';
import 'package:new_sai/presentation/widgets/app_exit_dialog.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.dialog(const AppExitDialog());
        }
      },
      child: Obx(
        () => Scaffold(
          appBar: controller.appBars[controller.currentIndex],
          body: controller.pages[controller.currentIndex],
          bottomNavigationBar: const MainBottomNavBar(),
        ),
      ),
    );
  }
}
