import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/room_item_widget.dart';
import 'package:new_sai/presentation/pages/room_pages/country_room/getx/country_room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_loading/room_loading_item.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

class CountryRoomView extends GetView<CountryRoomController> {
  const CountryRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: Text(controller.country.name),
        ),
        body: Column(
          children: [
            20.verticalSpace(),
            SizedBox(
              height: 33,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) => Obx(
                  () => InkWell(
                    onTap: () {
                      controller.country =
                          controller.roomsController.countries[index];
                      controller.getRoom();
                    },
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(end: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: controller.country.id ==
                                controller.roomsController.countries[index].id
                            ? ColorManager.primary
                            : ColorManager.white,
                      ),
                      child: Text(
                        controller.roomsController.countries[index].name,
                        style: Get.textTheme.bodyLarge!.copyWith(
                          fontSize: AppSize.s12(context),
                          color: controller.country.id ==
                                  controller.roomsController.countries[index].id
                              ? null
                              : ColorManager.black,
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: controller.roomsController.countries.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            20.verticalSpace(),
            Expanded(
              child: controller.loadingRoom
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      itemBuilder: (context, index) => const RoomLoadingItem(),
                      separatorBuilder: (BuildContext context, int index) =>
                          15.verticalSpace(),
                      itemCount: 10,
                    )
                  : controller.rooms.isEmpty
                      ? const EmptyDataWidget()
                      : ListView.separated(
                          controller: controller.scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          itemBuilder: (context, index) => RoomItemWidget(
                            room: controller.rooms[index],
                            isTop: index == 0 || index == 1 || index == 2,
                            topNumber: (index + 1).toString(),
                            withFlag: true,
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              15.verticalSpace(),
                          itemCount: controller.rooms.length,
                        ),
            ),
            20.verticalSpace(),
            if (controller.loadingRoomPagination) ...[
              const Center(child: AppLoader()),
              20.verticalSpace(),
            ],
          ],
        ),
      ),
    );
  }
}
