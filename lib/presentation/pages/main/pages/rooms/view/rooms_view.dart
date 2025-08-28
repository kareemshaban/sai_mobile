import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/getx/rooms_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/pages/general_rooms_page.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/pages/my_own_rooms_page.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/pages/popular_rooms_page.dart';
import 'package:new_sai/presentation/widgets/guest_dilaog.dart';

class RoomsView extends GetView<RoomsController> {
  const RoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return isGuest()
        ? const GuestDilaog()
        : Obx(() {
            if (controller.currentIndex == 0) {
              return const MyOwnRoomsPage();
            }
            if (controller.currentIndex == 1) {
              return const PopularRoomsPage();
            }
            return const GeneralRoomsPage();
          });
  }
}
