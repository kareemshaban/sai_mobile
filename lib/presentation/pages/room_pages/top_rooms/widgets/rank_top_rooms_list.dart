import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/data/mapper/room_mapper.dart';
import 'package:new_sai/data/model/room_model/room_model.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/room_item_widget.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/getx/top_rooms_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class RankTopRoomsList extends GetView<TopRoomsController> {
  const RankTopRoomsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => Container(
          width: 1.w(context),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: controller.filterValue == "topRooms"
                ? ColorManager.topRoomsColor2
                : controller.filterValue == "topSenders"
                    ? ColorManager.topSenderColor2
                    : ColorManager.topBillionaireColor2,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView.separated(
            itemBuilder: (context, index) {
              if (controller.filterValue == "topRooms") {
                return RoomItemWidget(
                  room: RoomModel(
                    id: controller.users[index].chatRoomId,
                    roomReferenceId: controller.users[index].referenceId,
                    roomImage: controller.users[index].profileImg,
                    roomName: controller.users[index].name,
                    membersCount: controller.users[index].onlineUsersCount,
                    profileLevel: controller.users[index].profileLevel,
                    lockCode: controller.users[index].lockCode,
                    backgroundTheme: controller.users[index].backgroundTheme,
                    falg: controller.users[index].total,
                  ).toDomain(),
                  isForRank: true,
                  topNumber: (index + 1).toString(),
                );
              }
              return InkWell(
                onTap: controller.appController.user.id ==
                        controller.users[index].userID
                    ? null
                    : () => Get.toNamed(
                          AppRoutes.userProfileRoute,
                          arguments: {
                            'id': controller.users[index].userID,
                            "isFromChat": false,
                          },
                        ),
                child: Container(
                  width: 1.w(context),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.white,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${index + 1}-",
                        style: Get.textTheme.labelLarge!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                      5.horizontalSpace(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(110),
                            child: Image.network(
                              controller.users[index].profileImg,
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const AppImage(
                                  image: Constants.userErrorWidget,
                                  width: 55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          PrivilegeDataView(
                            url: controller
                                .users[index].privileges.data.profileFrame.file,
                            width: 65,
                            height: 65,
                          ),
                        ],
                      ),
                      15.horizontalSpace(),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.users[index].name,
                              style: Get.textTheme.titleLarge!.copyWith(
                                fontSize: AppSize.s17(context),
                              ),
                            ),
                            2.verticalSpace(),
                            Row(
                              children: [
                                Text(
                                  "ID: ${controller.users[index].referenceId}",
                                  style: Get.textTheme.headlineMedium!.copyWith(
                                    fontSize: AppSize.s12(context),
                                  ),
                                ),
                                5.horizontalSpace(),
                                if (controller.users[index].badges.isNotEmpty)
                                  PrivilegeDataView(
                                    url: controller.users[index].badges.first,
                                    width: 20,
                                    height: 20,
                                    isBadges: true,
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      10.horizontalSpace(),
                      Text(
                        num.parse(controller.users[index].total)
                            .formatCurrencyWithoutSymbol,
                        style: Get.textTheme.labelLarge,
                      ),
                      4.horizontalSpace(),
                      const AppIcon(
                        icon: IconsAssets.coins2,
                        width: 14,
                        height: 14,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => 15.verticalSpace(),
            itemCount: controller.users.length,
          ),
        ),
      ),
    );
  }
}
