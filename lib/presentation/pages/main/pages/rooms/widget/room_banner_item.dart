import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/room_entity/room_banners_entity.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';

class RoomBannerItem extends StatelessWidget {
  final Color color;
  final String title;
  final RoomBannerItemEntity banner;
  const RoomBannerItem({
    super.key,
    required this.color,
    required this.title,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.topRoomsRoute),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        color: color.withOpacity(.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            16.horizontalSpace(),
            Stack(
              alignment: Alignment.center,
              children: [
                AppImage(
                  image: banner.profileImg,
                  width: 40,
                  height: 40,
                  isCircle: true,
                  fit: BoxFit.cover,
                ),
                PrivilegeDataView(
                  url: banner.privileges.data.profileFrame.file,
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            8.horizontalSpace(),
            Text(
              banner.name,
              style: Get.textTheme.bodyLarge!.copyWith(
                fontSize: AppSize.s16(context),
                color: Get.find<AppController>().isVipActive()
                    ? banner.privileges.data.colorfulName.value.isNotEmpty
                        ? ColorManager.white
                            .fromHex(banner.privileges.data.colorfulName.value)
                        : null
                    : null,
              ),
            ),
            ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [Colors.yellow, Colors.yellow],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Lottie.asset(LottieAssets.firstPlace)),
            const Spacer(),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color,
                ),
                child: Text(
                  title,
                  style: Get.textTheme.bodyLarge!.copyWith(
                    fontSize: AppSize.s14(context),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
