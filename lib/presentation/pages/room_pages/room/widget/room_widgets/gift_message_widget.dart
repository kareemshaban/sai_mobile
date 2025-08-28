import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_send_gift_model.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class GiftMessageWidget extends StatelessWidget {
  final RoomSendGiftModel gift;
  const GiftMessageWidget({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    if (context.locale == arabicLocale) {
      return SlideInRight(
        duration: const Duration(milliseconds: 300),
        child: giftWidget(context),
      );
    }
    return SlideInLeft(
      duration: const Duration(milliseconds: 300),
      child: giftWidget(context),
    );
  }

  Widget giftWidget(BuildContext context) {
    final controller = Get.find<RoomController>();

    return Obx(
      () {
        final user = controller.apiUsers
            .firstWhereOrNull((element) => element.id == gift.sender.id);
        return Container(
          constraints: BoxConstraints(
            maxWidth: .75.w(context),
          ),
          margin: const EdgeInsets.only(bottom: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  controller.openProfileBottomSheet(gift.sender.id.toString());
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      
                      Image.network(
                        controller.getUserImage(gift.sender.id.toString()),
                        errorBuilder: (context, error, stackTrace) {
                          return controller.userErrorImageWidget(
                            width: 40,
                            height: 40,
                          );
                        },
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      if (user != null)
                        PrivilegeDataView(
                          width: 50,
                          height: 50,
                          url: user.privileges.data.profileFrame.file,
                        ),
                        
                    ],
                  ),
                ),
              ),
              3.horizontalSpace(),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        controller
                            .openProfileBottomSheet(gift.sender.id.toString());
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              gift.sender.name,
                              style: Get.textTheme.bodySmall!.copyWith(
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
                          ),
                          if (user != null && user.badges.isNotEmpty) ...[
                            2.horizontalSpace(),
                            PrivilegeDataView(
                              url: user.badges.first,
                              isBadges: true,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorManager.black.withOpacity(.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${gift.sender.name}"
                        " ${AppStrings.send2}"
                        " ${AppStrings.gift}"
                        " x${gift.giftCount ?? 0}"
                        " ${gift.giftType == 0 ? "${AppStrings.for1} ${gift.recevier?.name ?? ''}" : gift.giftType == 1 ? AppStrings.forAllOnMics : AppStrings.forAllInRoom}",
                        style: Get.textTheme.bodySmall!.copyWith(
                          fontSize: AppSize.s14(context),
                        ),
                      ),
                    ),
                    5.verticalSpace(),
                    AppImage(
                      image: gift.giftImage,
                      width: 60,
                      height: 60,
                      radius: 8,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
