import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/getx/rooms_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/room_item_widget.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_loading/room_loading_item.dart';

class PopularRoomsPage extends GetView<RoomsController> {
  const PopularRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () => controller.getPopularRooms(),
        child: CustomScrollView(
          controller: controller.popularScrollController,
          slivers: [
            if (controller.loadingPopularRooms)
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) => const RoomLoadingItem(),
                  separatorBuilder: (context, index) => 5.verticalSpace(),
                  itemCount: 5,
                ),
              )
            else
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) => RoomItemWidget(
                    room: controller.popularRooms[index],
                    withFlag: true,
                  ),
                  separatorBuilder: (context, index) => 5.verticalSpace(),
                  itemCount: controller.popularRooms.length,
                ),
              ),
            if (controller.loadingPopularRoomsPagination)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: AppLoader()),
              ).toSliver(),
          ],
        ),
      ),
    );
  }
}
