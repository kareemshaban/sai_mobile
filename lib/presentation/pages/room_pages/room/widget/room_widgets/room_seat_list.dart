import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';

import 'seat_widget.dart';

class RoomSeatList extends GetView<RoomController> {
  const RoomSeatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (controller.room.microphonesCount == 7) ...[
            const Center(
              child: SeatWidget(index: 0),
            ),
            10.verticalSpace(),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  6,
                  (index) => SeatWidget(index: index + 1),
                ),
              ),
            ),
          ],
          if (controller.room.microphonesCount == 8) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SeatWidget(index: 0),
                10.horizontalSpace(),
                const SeatWidget(index: 1),
              ],
            ),
            10.verticalSpace(),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  6,
                  (index) => SeatWidget(index: index + 2),
                ),
              ),
            ),
          ],
          if (controller.room.microphonesCount == 14) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SeatWidget(index: 0),
                10.horizontalSpace(),
                const SeatWidget(index: 1),
              ],
            ),
            10.verticalSpace(),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  12,
                  (index) => SeatWidget(index: index + 2),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
