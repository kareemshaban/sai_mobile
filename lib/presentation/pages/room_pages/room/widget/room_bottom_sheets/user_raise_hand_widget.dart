import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/zego_handler/internal/internal.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class UserRaiseHandWidget extends StatelessWidget {
  final ZegoUser model;
  final void Function()? onTapApprove;
  final void Function()? onTapReject;

  const UserRaiseHandWidget(
      {required this.model, this.onTapApprove, this.onTapReject, super.key});

  @override
  Widget build(BuildContext context) {
    final roomController = Get.find<RoomController>();
    return Obx(() {
      final privi = roomController.apiUsers
          .firstWhereOrNull((element) => element.id.toString() == model.userID)
          ?.privileges;
      return Container(
        width: 1.w(context),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Image.network(
                      roomController.getUserImage(model.userID),
                      fit: BoxFit.cover,
                      width: 45,
                      height: 45,
                      errorBuilder: (context, error, stackTrace) =>
                          roomController.userErrorImageWidget(
                        width: 45,
                        height: 45,
                      ),
                    ),
                  ),
                ),
                if (privi != null && privi.data.profileFrame.file.isNotEmpty)
                  PrivilegeDataView(
                    url: privi.data.profileFrame.file,
                    width: 65,
                    height: 65,
                  ),
              ],
            ),
            10.horizontalSpace(),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                model.userName,
                style: context.textTheme.labelMedium!.copyWith(
                  color: Get.find<AppController>().isVipActive()
                      ? privi != null &&
                              privi.data.colorfulName.value.isNotEmpty
                          ? Colors.white.fromHex(privi.data.colorfulName.value)
                          : null
                      : null,
                ),
              ),
            ),
            10.horizontalSpace(),
            GestureDetector(
              onTap: onTapApprove,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: ColorManager.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.check,
                  color: ColorManager.white,
                  size: 18,
                ),
              ),
            ),
            10.horizontalSpace(),
            GestureDetector(
              onTap: onTapReject,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: ColorManager.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.close,
                  color: ColorManager.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
