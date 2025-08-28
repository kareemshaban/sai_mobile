import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';

class RoomMessageList extends GetView<RoomController> {
  const RoomMessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: 10,
          //     right: 10,
          //   ),
          //   child: ListView.builder(
          //     reverse: true,
          //     controller: controller.scrollController2,
          //     physics: controller.enableScroll
          //         ? const NeverScrollableScrollPhysics()
          //         : null,
          //     padding: EdgeInsets.zero,
          //     itemBuilder: (context, index) => Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         controller.messages[index],
          //       ],
          //     ),
          //     itemCount: controller.messages.length,
          //   ),
          // ),
          
          Obx(
            () => Align(
              alignment: AlignmentDirectional.topStart,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                reverse: true,
                controller: controller.scrollController2,
                physics: controller.enableScroll
                    ? const NeverScrollableScrollPhysics()
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    controller.messages.length,
                    (index) {
                      return controller.messages[index];
                    },
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  controller.roomNotificationList.length,
                  (index) {
                    return controller.roomNotificationList[index];
                  },
                ),
              ),
            ),
          ),
          // Obx(
          //   () => ListView.builder(
          //     itemBuilder: (context, index) =>
          //         controller.roomNotificationList[index],
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     itemCount: controller.roomNotificationList.length,
          //   ),
          // ),
        ],
      ),
    );
  }
}
