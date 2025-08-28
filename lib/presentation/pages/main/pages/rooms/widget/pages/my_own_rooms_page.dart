import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/getx/rooms_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/create_room_widget.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/room_item_widget.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_loading/room_loading_item.dart';

class MyOwnRoomsPage extends GetView<RoomsController> {
  const MyOwnRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      child: Obx(
        () => Column(
          children: [
            if (controller.loadingMyRoom)
              const RoomLoadingItem()
            else if (controller.myRoom.id == 0)
              const CreateRoomWidget()
            else
              RoomItemWidget(room: controller.myRoom),
            14.verticalSpace(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.getMyOwnPage(),
                child: CustomScrollView(
                  controller: controller.memperScrollController,
                  slivers: [
                    if (controller.loadingMemperRooms) ...[
                      Text(
                        AppStrings.joined,
                        style: Get.textTheme.titleMedium!.copyWith(
                          fontSize: AppSize.s20(context),
                        ),
                      ).toSliver(),
                      16.verticalSpace().toSliver(),
                      SliverPadding(
                        padding: const EdgeInsets.only(bottom: 20),
                        sliver: SliverList.separated(
                          itemBuilder: (context, index) =>
                              const RoomLoadingItem(),
                          separatorBuilder: (context, index) =>
                              5.verticalSpace(),
                          itemCount: 10,
                        ),
                      ),
                    ] else ...[
                      if (controller.memperRooms.isNotEmpty) ...[
                        Text(
                          AppStrings.joined,
                          style: Get.textTheme.titleMedium!.copyWith(
                            fontSize: AppSize.s20(context),
                          ),
                        ).toSliver(),
                        16.verticalSpace().toSliver(),
                        SliverPadding(
                          padding: const EdgeInsets.only(bottom: 20),
                          sliver: SliverList.separated(
                            itemBuilder: (context, index) => RoomItemWidget(
                              room: controller.memperRooms[index],
                            ),
                            separatorBuilder: (context, index) =>
                                5.verticalSpace(),
                            itemCount: controller.memperRooms.length,
                          ),
                        ),
                        if (controller.loadingMemperRoomsPagination)
                          const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: AppLoader(),
                            ),
                          ).toSliver(),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
