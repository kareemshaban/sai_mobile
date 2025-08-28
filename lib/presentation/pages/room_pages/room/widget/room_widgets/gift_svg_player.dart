import 'package:flutter/material.dart';
import 'package:flutter_svgaplayer3/player.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';

class GiftSvgPlayer extends StatelessWidget {
  const GiftSvgPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    print("mdknvsdnvsd");
    // print(controller.svgController);
    return GetBuilder<RoomController>(
      builder: (controller) {
        return SizedBox(
          width: 1.w(context),
          height: 1.h(context),
          child: Center(
            child: SVGAImage(
              controller.svgController,
            ),
          ),
        );
      },
    );
  }
}
