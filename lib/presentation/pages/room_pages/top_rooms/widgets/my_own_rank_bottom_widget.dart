import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/getx/top_rooms_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/theme_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class MyOwnRankBottomWidget extends GetView<TopRoomsController> {
  const MyOwnRankBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loadingGlobal) {
        return const SizedBox();
      } else {
        if (controller.users.any(
            (element) => element.userID == controller.appController.user.id)) {
          final user = controller.users.firstWhere(
              (element) => element.userID == controller.appController.user.id);
          return Container(
            width: 1.w(context),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              boxShadow: getBoxShadow(
                opacity: .13,
                blurRadius: 50,
                y: -4,
              ),
              color: controller.filterValue == "topRooms"
                  ? ColorManager.topRoomsColor2
                  : controller.filterValue == "topSenders"
                      ? ColorManager.topSenderColor2
                      : ColorManager.topBillionaireColor2,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(110),
                          child: Image.network(
                            user.profileImg,
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
                          url: user.privileges.data.profileFrame.file,
                          width: 65,
                          height: 65,
                        ),
                      ],
                    ),
                    15.horizontalSpace(),
                    Text(
                      user.name,
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: AppSize.s17(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      }
    });
  }
}
