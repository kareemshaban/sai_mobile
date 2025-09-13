import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/data/mapper/room_mapper.dart';
import 'package:new_sai/data/model/room_model/room_model.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/check_lock_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';
import 'package:x_overlay/x_overlay.dart';

class RankRoomsItem extends StatelessWidget {
  final String name;
  final String image;
  final String total;
  final String? profileFrame;
  final bool isUser;
  final String referenceId;
  final int id;
  final String lockCode;
  final String roomBackground;
  const RankRoomsItem({
    super.key,
    required this.name,
    required this.image,
    required this.total,
    this.profileFrame,
    this.isUser = true,
    required this.referenceId,
    required this.id,
    this.lockCode = '',
    this.roomBackground = '',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (isUser) {
          if (Get.find<AppController>().user.id != id) {
            Get.toNamed(AppRoutes.userProfileRoute, arguments: {
              'id': id,
              'isFromChat': false,
            });
          }
        } else {
          if (lockCode.isNotEmpty) {
            Get.dialog(CheckLockDialog(
              room: RoomModel(
                id: id,
                backgroundTheme: roomBackground,
                roomName: name,
                roomImage: image,
                roomReferenceId: num.parse(referenceId),
              ).toDomain(),
              lockCode: lockCode,
            ));
            return;
          }
          if (Get.isRegistered<RoomController>()) {
            final roomController = Get.find<RoomController>();
            if (AppRoutes.overlayController.pageStateNotifier.value ==
                XOverlayPageState.overlaying) {
              AppRoutes.overlayController.hide();
              await roomController.closeAndDisposeRoom();
            }
            roomController.initController(
              id.toString(),
              data: {
                "roomName": name,
                "referenceId": num.parse(referenceId),
                "backgroundTheme": roomBackground,
                "roomImage": image,
              },
            );
          }
          Get.toNamed(AppRoutes.roomRoute, arguments: {
            "id": id.toString(),
            "data": {
              "roomName": name,
              "referenceId": num.parse(referenceId),
              "backgroundTheme": roomBackground,
              "roomImage": image,
            },
          });
        }
      },
      child: Container(

        child: SizedBox(
          width: MediaQuery.widthOf(context) / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  image != '' ?  AppImage(
                    image: image,
                    width: 55,
                    height: 55,
                    isCircle: true,
                    fit: BoxFit.cover,
                  ) : Image(image: AssetImage('assets/images/user.png') , width: 55, height: 55, fit: BoxFit.cover,),
                  if (profileFrame != null)
                    PrivilegeDataView(
                      url: profileFrame!,
                      width: 65,
                      height: 65,
                    ),
                ],
              ),
              1.verticalSpace(),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontSize: AppSize.s16(context),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    num.parse(total).formatCurrencyWithoutSymbol,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s14(context),
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  4.horizontalSpace(),
                  const AppIcon(
                    icon: IconsAssets.coins2,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
