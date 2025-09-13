import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/getx/top_rooms_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/widgets/rank_rooms_item.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class RankRoomsWidget extends GetView<TopRoomsController> {
  const RankRoomsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.w(context),
      height: 205,
      //color: Colors.red,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Obx(
                () => Image.asset(
                  controller.filterValue == "topRooms"
                      ? ImageAssets.topRoomsBlue
                      : controller.filterValue == "topSenders"
                          ? ImageAssets.topRoomsYellow
                          : ImageAssets.topRoomsRed,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          if (controller.users.isNotEmpty)
            PositionedDirectional(
              top: 35,
              start: .38.w(context),
              child: RankRoomsItem(
                name: controller.users.first.name,
                image: controller.users.first.profileImg,
                total: controller.users.first.total.toString(),
                profileFrame:
                    controller.users.first.privileges.data.profileFrame.file,
                id: controller.filterValue != "topRooms"
                    ? controller.users.first.userID
                    : controller.users.first.chatRoomId,
                referenceId: controller.users.first.referenceId.toString(),
                isUser: controller.filterValue != "topRooms",
                lockCode: controller.users.first.lockCode,
                roomBackground: controller.users.first.backgroundTheme,
              ),
            ),
          if (controller.users.isEmpty)
            PositionedDirectional(
            top: 35,
            start: .38.w(context),
            child: RankRoomsItem(
            name: AppStrings.empty,
            image: "",
            total: "0",
            profileFrame:"",
            id: 0,
            referenceId: "",
            isUser: controller.filterValue != "topRooms",
            lockCode: "",
            roomBackground: "",
            ),
            ),
          if (controller.users.length >= 2)
            PositionedDirectional(
              top: 60,
              end: .11.w(context),
              child: RankRoomsItem(
                name: controller.users[1].name,
                image: controller.users[1].profileImg,
                total: controller.users[1].total.toString(),
                profileFrame:
                    controller.users[1].privileges.data.profileFrame.file,
                id: controller.filterValue != "topRooms"
                    ? controller.users[1].userID
                    : controller.users[1].chatRoomId,
                referenceId: controller.users[1].referenceId.toString(),
                isUser: controller.filterValue != "topRooms",
                lockCode: controller.users[1].lockCode,
                roomBackground: controller.users[1].backgroundTheme,
              ),
            ),
          if(controller.users.length < 2)
            PositionedDirectional(
              top: 60,
              end: .11.w(context),
              child: RankRoomsItem(
                name: AppStrings.empty,
                image: "",
                total: "0",
                profileFrame:"",
                id: 0,
                referenceId: "",
                isUser: controller.filterValue != "topRooms",
                lockCode: "",
                roomBackground: "",
              ),
            ),

          if (controller.users.length >= 3)
            PositionedDirectional(
              top: 72,
              start: .13.w(context),
              child: RankRoomsItem(
                name: controller.users[2].name,
                image: controller.users[2].profileImg,
                total: controller.users[2].total.toString(),
                profileFrame:
                    controller.users[2].privileges.data.profileFrame.file,
                id: controller.filterValue != "topRooms"
                    ? controller.users[2].userID
                    : controller.users[2].chatRoomId,
                referenceId: controller.users[2].referenceId.toString(),
                isUser: controller.filterValue != "topRooms",
                lockCode: controller.users[2].lockCode,
                roomBackground: controller.users[2].backgroundTheme,
              ),
            ),
          if(controller.users.length < 3)
            PositionedDirectional(
              top: 72,
              start: .13.w(context),
              child: RankRoomsItem(
                name: AppStrings.empty,
                image: "",
                total: "0",
                profileFrame:"",
                id: 0,
                referenceId: "",
                isUser: controller.filterValue != "topRooms",
                lockCode: "",
                roomBackground: "",
              ),
            ),
        ],
      ),
    );
  }
}
