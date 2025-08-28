import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class RoomMempersWidget extends StatelessWidget {
  final void Function()? onTap;
  final UserEntity user;
  final bool isMuted;
  const RoomMempersWidget({
    super.key,
    this.onTap,
    required this.user,
    this.isMuted = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
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
                    errorBuilder: (context, error, stackTrace) {
                      return const AppImage(
                        image: Constants.userErrorWidget,
                        width: 55,
                        height: 55,
                      );
                    },
                  ),
                ),
              ),
              PrivilegeDataView(
                url: user.privileges.data.profileFrame.file,
                width: 75,
                height: 75,
              )
            ],
          ),
          8.horizontalSpace(),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s20(context),
                    color: Get.find<AppController>().isVipActive()
                        ? user.privileges.data.colorfulName.value.isNotEmpty
                            ? Colors.white.fromHex(
                                user.privileges.data.colorfulName.value)
                            : null
                        : null,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "ID: ${user.referenceId}",
                      style: Get.textTheme.titleSmall!.copyWith(
                        fontSize: AppSize.s13(context),
                        color: ColorManager.black.withOpacity(.5),
                      ),
                    ),
                    if (user.badges.isNotEmpty) ...[
                      2.horizontalSpace(),
                      PrivilegeDataView(
                        url: user.badges.first,
                        isBadges: true,
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (isMuted) ...[
            8.horizontalSpace(),
            const Icon(
              Icons.block,
              color: ColorManager.red,
            ),
          ],
          8.horizontalSpace(),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: user.type == "owner"
                  ? const Color(0x99FF4646)
                  : user.type == "admin"
                      ? ColorManager.green
                      : const Color(0x997B34FF),
            ),
            child: Text(
              user.type.tr(),
              style: Get.textTheme.bodySmall!.copyWith(
                fontSize: AppSize.s10(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
