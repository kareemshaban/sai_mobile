import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';

class LottieScreen extends StatelessWidget {
  const LottieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RoomController>();
    return Obx(() {
      if (!controller.showLottie.value || controller.giftUrls.isEmpty) {
        return const SizedBox.shrink();
      }
      /////////
      final currentGift = controller.giftUrls.first;
      final url = currentGift['url'];
      final id = currentGift['id'];
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Lottie.network(
          url.toString(),
          key: ValueKey(id),
          controller: controller.animationController,
          fit: BoxFit.cover,
          onLoaded: (composition) {
            controller.animationController.duration = composition.duration;
            controller.animationController.forward(from: 0);
          },
        ),
      );
    });
  }
}
