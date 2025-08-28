import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class RoomUserBottomSheet extends GetView<RoomController> {
  const RoomUserBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      decoration: const BoxDecoration(
        color: ColorManager.scaffoldBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => controller
                  .openProfileBottomSheet(controller.users[index].userID),
              child: Obx(
                () {
                  final user = controller.apiUsers.firstWhereOrNull((element) =>
                      element.id.toString() == controller.users[index].userID);
                  return Row(
                    children: [
                      Text(
                        "${index + 1}. ",
                        style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image.network(
                                controller.getUserImage(
                                  controller.users[index].userID,
                                ),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    controller.userErrorImageWidget(
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                          ),
                          if (user != null)
                            PrivilegeDataView(
                              url: user.privileges.data.profileFrame.file,
                              width: 70,
                              height: 70,
                            ),
                        ],
                      ),
                      8.horizontalSpace(),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.users[index].userName,
                              style: Get.textTheme.titleMedium!.copyWith(
                                fontSize: AppSize.s16(context),
                                color: controller.appController.isVipActive()
                                    ? user != null &&
                                            user.privileges.data.colorfulName
                                                .value.isNotEmpty
                                        ? Colors.white.fromHex(user
                                            .privileges.data.colorfulName.value)
                                        : null
                                    : null,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "ID: ${user != null ? user.referenceId : controller.users[index].userID}",
                                  style: Get.textTheme.titleMedium!.copyWith(
                                    fontSize: AppSize.s14(context),
                                  ),
                                ),
                                if (user != null && user.badges.isNotEmpty) ...[
                                  2.horizontalSpace(),
                                  PrivilegeDataView(
                                    url: user.badges.first,
                                    isBadges: true,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      8.horizontalSpace(),
                      if (controller.mutedListLocally.any((element) =>
                              element == controller.users[index].userID) ||
                          controller.mutedList.any((element) =>
                              element == controller.users[index].userID))
                        const Icon(
                          Icons.block,
                          color: ColorManager.red,
                        )
                    ],
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) => 10.verticalSpace(),
          itemCount: controller.users.length,
        ),
      ),
    );
  }
}
