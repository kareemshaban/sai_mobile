import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_mempers_widget.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class RoomMempersBottomSheet extends GetView<RoomController> {
  const RoomMempersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      height: .6.h(context),
      decoration: const BoxDecoration(
        color: ColorManager.scaffoldBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: PageView(
        controller: controller.roomMemperPageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: controller.onSearchPageChanged,
        children: [
          Obx(
            () => Stack(
              children: [
                Column(
                  children: [
                    8.verticalSpace(),
                    Text(
                      "${AppStrings.members}(${controller.roomMempers.length})",
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s22(context),
                      ),
                    ),
                    8.verticalSpace(),
                    const Divider(height: 0),
                    Expanded(
                      child: controller.loadingRoomMempers
                          ? const Center(child: AppLoader())
                          : RefreshIndicator(
                              onRefresh: () => controller.getRoomMempers(),
                              child: ListView.separated(
                                controller:
                                    controller.roomMempersScrollController,
                                padding: const EdgeInsets.all(20),
                                itemBuilder: (context, index) {
                                  return Obx(
                                    () => RoomMempersWidget(
                                      onTap: () =>
                                          controller.openProfileBottomSheet(
                                              controller.roomMempers[index].id
                                                  .toString()),
                                      user: controller.roomMempers[index],
                                      isMuted: controller.mutedListLocally.any(
                                              (element) =>
                                                  element ==
                                                  controller
                                                      .roomMempers[index].id
                                                      .toString()) ||
                                          controller.mutedList.any((element) =>
                                              element ==
                                              controller.roomMempers[index].id
                                                  .toString()),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    10.verticalSpace(),
                                itemCount: controller.roomMempers.length,
                              ),
                            ),
                    ),
                    if (controller.loadingRoomMempersPaginate)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: AppLoader(),
                        ),
                      ),
                  ],
                ),
                PositionedDirectional(
                  end: 0,
                  child: InkWell(
                    onTap: controller.goToSearch,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Icon(
                        Icons.search,
                        color: ColorManager.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Column(
              children: [
                12.verticalSpace(),
                Row(
                  children: [
                    AppBackButton(
                      onTap: controller.backFromSearch,
                    ),
                    10.horizontalSpace(),
                    Expanded(
                      child: AppFormFiled(
                        suffixIcon: InkWell(
                          onTap: controller.onTapSearch,
                          child: const Icon(
                            Icons.search,
                          ),
                        ),
                        controller: controller.roomMemperSearchController,
                        filledColor: ColorManager.transparent,
                        hint: AppStrings.searchForMembers,
                        onSubmit: (value) {
                          controller.onTapSearch();
                        },
                      ),
                    ),
                    16.horizontalSpace(),
                  ],
                ),
                12.verticalSpace(),
                const Divider(height: 0),
                Expanded(
                  child: controller.loadingSearch
                      ? const Center(
                          child: AppLoader(),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (context, index) {
                            final user = controller.searchUsers[index];
                            return InkWell(
                              onTap: () => controller.openProfileBottomSheet(
                                user.id.toString(),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(110),
                                      child: Image.network(
                                        user.profileImg,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const AppImage(
                                            image: Constants.userErrorWidget,
                                            width: 55,
                                            height: 55,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  8.horizontalSpace(),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.name,
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                            fontSize: AppSize.s20(context),
                                          ),
                                        ),
                                        Text(
                                          "ID: ${user.referenceId}",
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                            fontSize: AppSize.s13(context),
                                            color: ColorManager.black
                                                .withOpacity(.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  8.horizontalSpace(),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              10.verticalSpace(),
                          itemCount: controller.searchUsers.length,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
